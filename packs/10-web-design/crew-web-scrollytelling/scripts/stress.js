#!/usr/bin/env node
/*
 * stress.js : fast-flick stress test for scroll-film scrub engines.
 *
 *   node stress.js <url> [width] [height]
 *
 * Simulates violent up/down scrolling (instant jumps top<->film-end, 5 rounds),
 * then checks: (1) the playhead lands on the target frame after each settle,
 * (2) the final settle is exact, (3) the rAF loop never starved (max delta).
 * Page must expose the dev contract (window.__ready) and the engine globals
 * `target` and `displayed` in script scope (the skill's standard engine does).
 */
const puppeteer = require('puppeteer-core');

function chromePath() {
  if (process.env.CHROME_PATH) return process.env.CHROME_PATH;
  if (process.platform === 'darwin') return '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome';
  if (process.platform === 'win32') return 'C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe';
  return '/usr/bin/google-chrome';
}

const [url, w, h] = process.argv.slice(2);
(async () => {
  const b = await puppeteer.launch({ executablePath: chromePath(), headless: 'new', args: ['--hide-scrollbars', '--no-sandbox'] });
  try {
    const page = await b.newPage();
    await page.setViewport({ width: +(w || 1440), height: +(h || 900), deviceScaleFactor: 1 });
    await page.goto(url, { waitUntil: 'networkidle0', timeout: 60000 });
    await page.waitForFunction('window.__ready === true', { timeout: 45000 });
    const res = await page.evaluate(async () => {
      const sleep = ms => new Promise(r => setTimeout(r, ms));
      const film = document.getElementById('film');
      const filmEnd = (film ? film.offsetHeight : document.body.scrollHeight) - innerHeight;
      let maxDelta = 0, last = performance.now(), run = true;
      (function meter() {
        const n = performance.now(); const d = n - last; if (d > maxDelta) maxDelta = d; last = n;
        if (run) requestAnimationFrame(meter);
      })();
      const samples = [];
      for (let i = 0; i < 5; i++) {
        scrollTo(0, filmEnd); await sleep(380);
        samples.push({ at: 'bottom', tgt: Math.round(target), disp: displayed, gap: Math.round(Math.abs(displayed - target)) });
        scrollTo(0, 0); await sleep(380);
        samples.push({ at: 'top', tgt: Math.round(target), disp: displayed, gap: Math.round(Math.abs(displayed - target)) });
      }
      await sleep(700); run = false;
      return {
        samples,
        settled: { tgt: Math.round(target), disp: displayed, gap: Math.round(Math.abs(displayed - target)) },
        maxDelta: Math.round(maxDelta),
      };
    });
    const gaps = res.samples.map(s => s.gap);
    const pass = res.settled.gap <= 2 && Math.max(...gaps) <= 10 && res.maxDelta < 160;
    console.log(JSON.stringify({ ...res, worstGap: Math.max(...gaps) }));
    console.log(pass ? 'STRESS PASS' : 'STRESS FAIL : playhead cannot keep up with fast scroll');
    process.exitCode = pass ? 0 : 3;
  } finally { await b.close().catch(() => {}); }
})().catch(e => { console.error(e.message); process.exit(1); });
