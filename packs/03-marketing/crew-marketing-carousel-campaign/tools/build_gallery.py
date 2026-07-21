#!/usr/bin/env python3
"""
build_gallery.py - assemble one master review gallery of every carousel campaign
for an offer, in sequence (campaign sections, per-carousel filmstrips).

Copies each carousel's living hero (mp4) + poster + 3 body slides into
assets/<campaign>/, web-sizing the stills to JPEG so the page stays light, and
generates index.html. Heroes show as poster stills with a LIVE badge and play
in a lightbox on click (never autoplay many videos, it freezes the renderer).

ADAPT PER CAMPAIGN SET: edit PROJECTS (the folder holding your campaign project
folders), CAMPAIGNS (one entry per style campaign), and the brand strings in
TEMPLATE. The three entries below are the fictional Saltbrook worked example,
one offer told in the three bundled style recipes.
"""
import os, shutil
from PIL import Image

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
ASSETS = os.path.join(ROOT, "assets")
PROJECTS = os.path.expanduser("~/Desktop")

CONCEPTS = ["The Announcement", "The Differentiator", "The Credentials",
            "The Mechanism", "The Close", "The Keepsake"]

# per campaign: key, title, tagline, accent, hero stems[6], dirs
CAMPAIGNS = [
    {
        "key": "acid", "title": "The Acid Archive",
        "tag": "Brutalist acid-editorial. Marble statues eroding into pixel-sort, lime stickers stamped over newsprint.",
        "accent": "#D9E021", "num": "01",
        "proj": "campaign-acid",
        "heroes": ["hero1-announcement", "hero2-differentiator", "hero3-credentials",
                   "hero4-mechanism", "hero5-close", "hero6-keepsake"],
        "herodir": "exports", "pagesdir": "exports/pages", "motiondir": "exports/motion",
    },
    {
        "key": "limelight", "title": "Limelight",
        "tag": "Grayscale photoreal portraits, one acid-lime circle, physical paint smears that mean something on every hero.",
        "accent": "#D6DE23", "num": "02",
        "proj": "campaign-limelight",
        "heroes": ["hero1-announcement", "hero2-differentiator", "hero3-credentials",
                   "hero4-mechanism", "hero5-close", "hero6-keepsake"],
        "herodir": "exports", "pagesdir": "exports/pages", "motiondir": "exports/motion",
    },
    {
        "key": "drop", "title": "The Drop",
        "tag": "The offer sold like a sneaker drop. Colour-drenched rooms, checkerboard floors, glowing labelled glass held to camera. 4K.",
        "accent": "#C6D400", "num": "03",
        "proj": "campaign-drop",
        "heroes": ["hero1-announcement", "hero2-differentiator", "hero3-credentials",
                   "hero4-mechanism", "hero5-close", "hero6-keepsake"],
        "herodir": "exports", "pagesdir": "exports/pages", "motiondir": "exports/motion",
    },
]

def webjpg(src, dst, w=864, q=85):
    im = Image.open(src).convert("RGB")
    if im.width != w:
        im = im.resize((w, round(im.height * w / im.width)), Image.LANCZOS)
    im.save(dst, "JPEG", quality=q, optimize=True)

def main():
    for c in CAMPAIGNS:
        base = os.path.join(PROJECTS, c["proj"])
        outdir = os.path.join(ASSETS, c["key"])
        os.makedirs(outdir, exist_ok=True)
        for i, stem in enumerate(c["heroes"], start=1):
            # hero video
            mp4 = os.path.join(base, c["motiondir"], stem + ".mp4")
            if os.path.exists(mp4):
                shutil.copy(mp4, os.path.join(outdir, "c%d_hero.mp4" % i))
            # hero poster
            poster = os.path.join(base, c["herodir"], stem + ".png")
            webjpg(poster, os.path.join(outdir, "c%d_hero.jpg" % i))
            # body slides
            for k in (2, 3, 4):
                pg = os.path.join(base, c["pagesdir"], "c%dp%d.png" % (i, k))
                webjpg(pg, os.path.join(outdir, "c%d_s%d.jpg" % (i, k)))
        print("copied", c["key"])

    # ---- generate index.html ----
    sections = []
    nav = []
    for c in CAMPAIGNS:
        nav.append(f'<a href="#{c["key"]}"><span class="n">{c["num"]}</span>{c["title"]}</a>')
        rows = []
        for i in range(1, 7):
            frames = []
            # slide 1 = hero (poster still + LIVE badge; video plays in lightbox)
            frames.append(f'''
        <figure class="frame hero" data-full="assets/{c["key"]}/c{i}_hero.jpg" data-vid="assets/{c["key"]}/c{i}_hero.mp4">
          <img loading="lazy" src="assets/{c["key"]}/c{i}_hero.jpg" alt="hero">
          <span class="live">▶ LIVE</span>
          <figcaption>01 · HERO</figcaption>
        </figure>''')
            for k in (2, 3, 4):
                frames.append(f'''
        <figure class="frame" data-full="assets/{c["key"]}/c{i}_s{k}.jpg">
          <img loading="lazy" src="assets/{c["key"]}/c{i}_s{k}.jpg" alt="slide {k}">
          <figcaption>0{k} · SLIDE</figcaption>
        </figure>''')
            rows.append(f'''
      <article class="carousel">
        <div class="clabel"><span class="cnum">C{i}</span><span class="cname">{CONCEPTS[i-1]}</span></div>
        <div class="strip">{''.join(frames)}
        </div>
      </article>''')
        sections.append(f'''
  <section id="{c["key"]}" class="campaign" style="--accent:{c["accent"]}">
    <header class="chead">
      <div class="cnum-big">{c["num"]}</div>
      <div>
        <h2>{c["title"]}</h2>
        <p>{c["tag"]}</p>
      </div>
    </header>
    <div class="rows">{''.join(rows)}</div>
  </section>''')

    html = TEMPLATE.replace("{{NAV}}", "\n    ".join(nav)).replace("{{SECTIONS}}", "\n".join(sections))
    open(os.path.join(ROOT, "index.html"), "w").write(html)
    print("wrote index.html")


TEMPLATE = r'''<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Saltbrook Carousels · Full Campaign Gallery</title>
<style>
  :root {
    --bg: #0C0C0C; --panel: #141414; --line: #262626;
    --paper: #F4F4EF; --dim: #8C8C86; --lime: #D9E021;
  }
  * { margin: 0; padding: 0; box-sizing: border-box; }
  html { scroll-behavior: smooth; }
  body { background: var(--bg); color: var(--paper);
    font-family: -apple-system, "Helvetica Neue", Arial, sans-serif; line-height: 1.5; }
  .mono { font-family: ui-monospace, "SF Mono", Menlo, monospace; }

  /* top bar */
  .topbar { position: sticky; top: 0; z-index: 60; background: rgba(12,12,12,0.86);
    backdrop-filter: blur(14px); border-bottom: 1px solid var(--line); }
  .topbar .inner { max-width: 1500px; margin: 0 auto; padding: 16px 30px;
    display: flex; align-items: center; gap: 26px; flex-wrap: wrap; }
  .brand { font-weight: 800; letter-spacing: -0.01em; font-size: 18px; }
  .brand b { color: var(--lime); }
  .topnav { display: flex; gap: 8px; margin-left: auto; flex-wrap: wrap; }
  .topnav a { text-decoration: none; color: var(--paper); font-family: ui-monospace, Menlo, monospace;
    font-size: 12px; letter-spacing: 0.04em; border: 1px solid var(--line); padding: 7px 13px;
    border-radius: 999px; display: flex; align-items: center; gap: 8px; transition: all .15s; }
  .topnav a:hover { border-color: var(--lime); color: var(--lime); }
  .topnav a .n { opacity: 0.5; }

  /* hero masthead */
  .masthead { max-width: 1500px; margin: 0 auto; padding: 70px 30px 40px; }
  .masthead .kick { font-family: ui-monospace, Menlo, monospace; font-size: 12px; letter-spacing: 0.2em;
    color: var(--dim); margin-bottom: 20px; }
  .masthead h1 { font-size: clamp(40px, 7vw, 88px); line-height: 0.98; letter-spacing: -0.02em;
    font-weight: 850; text-transform: uppercase; }
  .masthead h1 em { font-style: normal; color: var(--lime); }
  .masthead .lead { max-width: 680px; margin-top: 22px; color: #C7C7C1; font-size: 16px; }
  .stats { display: flex; gap: 40px; margin-top: 34px; flex-wrap: wrap; }
  .stat b { display: block; font-size: 34px; font-weight: 800; letter-spacing: -0.01em; }
  .stat span { font-family: ui-monospace, Menlo, monospace; font-size: 11px; letter-spacing: 0.1em;
    color: var(--dim); text-transform: uppercase; }

  /* campaign section */
  .campaign { max-width: 1500px; margin: 0 auto; padding: 40px 30px 30px; scroll-margin-top: 80px; }
  .chead { display: flex; gap: 26px; align-items: flex-start; padding: 30px 0 24px;
    border-top: 2px solid var(--accent); }
  .cnum-big { font-family: ui-monospace, Menlo, monospace; font-size: 15px; font-weight: 700;
    color: var(--accent); padding-top: 8px; }
  .chead h2 { font-size: clamp(30px, 4.5vw, 52px); line-height: 1; letter-spacing: -0.01em;
    font-weight: 850; text-transform: uppercase; }
  .chead p { max-width: 640px; margin-top: 12px; color: var(--dim); font-size: 14.5px; }

  .rows { display: flex; flex-direction: column; gap: 12px; }
  .carousel { background: var(--panel); border: 1px solid var(--line); border-radius: 14px;
    padding: 16px 18px; }
  .clabel { display: flex; align-items: baseline; gap: 12px; margin-bottom: 12px; }
  .cnum { font-family: ui-monospace, Menlo, monospace; font-weight: 700; font-size: 13px;
    color: var(--accent); }
  .cname { font-weight: 700; font-size: 16px; letter-spacing: 0.01em; }

  .strip { display: flex; gap: 12px; overflow-x: auto; padding-bottom: 6px;
    scroll-snap-type: x mandatory; }
  .strip::-webkit-scrollbar { height: 8px; }
  .strip::-webkit-scrollbar-thumb { background: #333; border-radius: 8px; }
  .frame { flex: 0 0 auto; width: 232px; scroll-snap-align: start; cursor: zoom-in;
    position: relative; border-radius: 8px; overflow: hidden; background: #000;
    border: 1px solid var(--line); }
  .frame img, .frame video { width: 100%; aspect-ratio: 4 / 5; object-fit: cover; display: block; }
  .frame figcaption { position: absolute; left: 8px; bottom: 8px; font-family: ui-monospace, Menlo, monospace;
    font-size: 10px; letter-spacing: 0.08em; background: rgba(0,0,0,0.6); color: #fff;
    padding: 3px 7px; border-radius: 4px; }
  .frame .live { position: absolute; top: 8px; right: 8px; font-family: ui-monospace, Menlo, monospace;
    font-size: 10px; font-weight: 700; letter-spacing: 0.06em; background: var(--lime); color: #111;
    padding: 3px 8px; border-radius: 4px; }
  .frame.hero { cursor: pointer; }

  footer { max-width: 1500px; margin: 0 auto; padding: 40px 30px 90px; color: var(--dim);
    font-family: ui-monospace, Menlo, monospace; font-size: 12px; border-top: 1px solid var(--line);
    display: flex; justify-content: space-between; flex-wrap: wrap; gap: 12px; }

  /* lightbox */
  #lb { position: fixed; inset: 0; z-index: 100; background: rgba(6,6,6,0.94);
    display: none; align-items: center; justify-content: center; padding: 30px; cursor: zoom-out; }
  #lb.on { display: flex; }
  #lb img, #lb video { max-width: 92vw; max-height: 90vh; border-radius: 6px;
    box-shadow: 0 30px 90px rgba(0,0,0,0.6); }
  #lb .close { position: absolute; top: 20px; right: 26px; color: #fff; font-size: 30px;
    font-family: ui-monospace, Menlo, monospace; }
</style>
</head>
<body>

<div class="topbar">
  <div class="inner">
    <div class="brand">Saltbrook <b>·</b> Campaign Gallery</div>
    <nav class="topnav">
    {{NAV}}
    </nav>
  </div>
</div>

<div class="masthead">
  <div class="kick mono">ONE DAY ON THE WHEEL · 14.11 · $349 OPENING · 3 CAMPAIGNS</div>
  <h1>Everything<br>we <em>built.</em></h1>
  <p class="lead">Three complete Meta carousel campaigns for one offer, told three ways. Every carousel is four frames: a living hero and three coded slides. Scroll each strip, tap any frame to enlarge. (Fictional worked example.)</p>
  <div class="stats">
    <div class="stat"><b>3</b><span>Campaigns</span></div>
    <div class="stat"><b>18</b><span>Carousels</span></div>
    <div class="stat"><b>72</b><span>Frames</span></div>
    <div class="stat"><b>18</b><span>Living heroes</span></div>
  </div>
</div>

{{SECTIONS}}

<footer>
  <span>SALTBROOK · CAROUSEL GALLERY · 14.11</span>
  <span>ACID ARCHIVE · LIMELIGHT · THE DROP</span>
</footer>

<div id="lb"><span class="close mono">ESC ✕</span><span id="lbslot"></span></div>

<script>
/* lightbox: hero frames play their video, still frames enlarge the image */
const lb = document.getElementById('lb'), slot = document.getElementById('lbslot');
document.querySelectorAll('.frame').forEach(f => {
  f.addEventListener('click', () => {
    slot.innerHTML = '';
    if (f.dataset.vid) {
      const el = document.createElement('video');
      el.src = f.dataset.vid; el.controls = true; el.autoplay = true;
      el.loop = true; el.playsInline = true; el.muted = true;
      slot.appendChild(el);
      el.play().catch(()=>{});
    } else {
      const el = document.createElement('img');
      el.src = f.dataset.full;
      slot.appendChild(el);
    }
    lb.classList.add('on');
  });
});
function closeLb(){ lb.classList.remove('on'); slot.innerHTML=''; }
lb.addEventListener('click', closeLb);
document.addEventListener('keydown', e => { if (e.key === 'Escape') closeLb(); });
</script>
</body>
</html>
'''

if __name__ == "__main__":
    main()
