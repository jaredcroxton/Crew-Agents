#!/usr/bin/env node
/*
 * stress2.js : engine-agnostic fast-flick stress test.
 *
 *   node stress2.js <url> <outdir> [width] [height]
 *
 * No dev-contract globals needed. Method: load page, wait for network idle +
 * settle, screenshot clean top state (B). Then 5 rounds of violent top<->bottom
 * jumps, settle at top, screenshot (A). Writes A/B PNGs; caller compares SSIM.
 * A healthy engine returns to the same top-of-page pixels after abuse.
 */
const puppeteer = require('puppeteer-core');

function chromePath() {
  if (process.env.CHROME_PATH) return process.env.CHROME_PATH;
  if (process.platform === 'darwin') return '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome';
  return '/usr/bin/google-chrome';
}

const [url, outdir, w, h] = process.argv.slice(2);
(async () => {
  const b = await puppeteer.launch({ executablePath: chromePath(), headless: 'new', args: ['--hide-scrollbars', '--no-sandbox'] });
  try {
    const page = await b.newPage();
    await page.setViewport({ width: +(w || 1440), height: +(h || 900), deviceScaleFactor: 1 });
    await page.goto(url, { waitUntil: 'networkidle0', timeout: 90000 });
    await new Promise(r => setTimeout(r, 4500));   // loaders/entrances settle
    await page.screenshot({ path: `${outdir}/clean_top.png` });
    const t0 = Date.now();
    await page.evaluate(async () => {
      const sleep = ms => new Promise(r => setTimeout(r, ms));
      const end = (document.scrollingElement || document.documentElement).scrollHeight - innerHeight;
      for (let i = 0; i < 5; i++) {
        scrollTo(0, end); await sleep(350);
        scrollTo(0, 0);  await sleep(350);
      }
      await sleep(1200);
    });
    const wall = Date.now() - t0;                   // main-thread starvation shows up here
    await page.screenshot({ path: `${outdir}/after_abuse_top.png` });
    console.log(JSON.stringify({ wallMs: wall, expectedMs: 5 * 700 + 1200 }));
  } finally { await b.close().catch(() => {}); }
})().catch(e => { console.error(e.message); process.exit(1); });
