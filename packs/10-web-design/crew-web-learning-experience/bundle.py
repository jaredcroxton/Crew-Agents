#!/usr/bin/env python3
"""Crew learning-experience offline bundler. Stdlib only, no dependencies.

Produces ONE double-clickable HTML file: Google woff2 fonts inlined as
base64 @font-face (fetched at bundle time, skipped gracefully when offline,
the system-stack fallbacks carry the type), opener frames inlined as data
URIs into each module's media.framesInline, and the course inlined as the
courseData seed. The app's boot precedence (localStorage course key first,
then the inline seed, then fetch) means the bundle never overrides a
machine's edits: the seed only fills an absent key.

Usage: python3 bundle.py [index.html] [course.json] [out.html]
Defaults: index.html, course.json (optional), learning-experience-bundle.html
"""
import base64
import json
import mimetypes
import os
import re
import sys
import urllib.request

UA = {"User-Agent": ("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) "
                     "AppleWebKit/537.36 (KHTML, like Gecko) "
                     "Chrome/126.0.0.0 Safari/537.36")}
FONT_MIME = {".woff2": "font/woff2", ".woff": "font/woff", ".ttf": "font/ttf", ".otf": "font/otf"}


def fetch(url, timeout=12):
    req = urllib.request.Request(url, headers=UA)
    return urllib.request.urlopen(req, timeout=timeout).read()


def inline_fonts(html):
    """Replace Google Fonts stylesheet links with inline base64 @font-face."""
    links = re.findall(
        r'<link[^>]+href="(https://fonts\.googleapis\.com/css2[^"]+)"[^>]*>', html)
    for href in links:
        try:
            css = fetch(href).decode("utf-8")

            def embed(match):
                url = match.group(1)
                ext = os.path.splitext(url.split("?")[0])[1].lower()
                mime = FONT_MIME.get(ext, "font/woff2")
                b64 = base64.b64encode(fetch(url)).decode()
                return "url(data:%s;base64,%s)" % (mime, b64)

            css = re.sub(r"url\((https://[^)]+)\)", embed, css)
            if "url(https://" in css:
                raise RuntimeError("a font URL survived embedding")
            tag = re.search(
                r'<link[^>]+href="%s"[^>]*>' % re.escape(href), html).group(0)
            html = html.replace(tag, "<style>/* bundled fonts */\n%s</style>" % css)
            print("fonts: inlined %s" % href.split("family=")[-1][:60])
        except Exception as exc:
            print("fonts: skipped (%s); system stacks carry the type" % exc)
    return html


def frame_paths(root, frames_dir, count):
    """Resolve frame files: frame_0001.webp preferred, frame_0001.jpg fallback."""
    paths = []
    for i in range(1, count + 1):
        base = os.path.join(root, frames_dir, "frame_%04d" % i)
        for ext in (".webp", ".jpg", ".jpeg", ".png"):
            if os.path.exists(base + ext):
                paths.append(base + ext)
                break
        else:
            raise FileNotFoundError(base + ".jpg")
    return paths


def inline_frames(course, root):
    """Inline every opted-in opener's frames as data URIs (framesInline)."""
    total = 0
    for mod in course.get("modules", []):
        media = (mod.get("opener") or {}).get("media") or {}
        frames_dir, count = media.get("framesDir"), int(media.get("frameCount") or 0)
        if not frames_dir or not count:
            continue
        inline = []
        for path in frame_paths(root, frames_dir, count):
            mime = mimetypes.guess_type(path)[0] or "image/jpeg"
            with open(path, "rb") as fh:
                data = fh.read()
            total += len(data)
            inline.append("data:%s;base64,%s" % (mime, base64.b64encode(data).decode()))
        media["framesInline"] = inline
        print("frames: inlined %d for %s" % (count, mod.get("module", "?")))
    if total:
        print("frames: %.1fMB binary (%.1fMB encoded)" % (
            total / 1e6, total * 1.33 / 1e6))
    return course


def inject_seed(html, course):
    """Replace (or insert) the inline courseData seed with this course."""
    seed = '<script id="courseData" type="application/json">%s</script>' % (
        json.dumps(course, ensure_ascii=False).replace("</", "<\\/"))
    pattern = re.compile(
        r'<script id="courseData" type="application/json">.*?</script>', re.S)
    if pattern.search(html):
        return pattern.sub(lambda _m: seed, html, count=1)
    return html.replace("</body>", seed + "\n</body>")


def main():
    index = sys.argv[1] if len(sys.argv) > 1 else "index.html"
    course_path = sys.argv[2] if len(sys.argv) > 2 else "course.json"
    out = sys.argv[3] if len(sys.argv) > 3 else "learning-experience-bundle.html"
    root = os.path.dirname(os.path.abspath(index))

    with open(index, encoding="utf-8") as fh:
        html = fh.read()

    if os.path.exists(course_path):
        with open(course_path, encoding="utf-8") as fh:
            course = json.load(fh)
    else:
        match = re.search(
            r'<script id="courseData" type="application/json">(.*?)</script>',
            html, re.S)
        if not match:
            sys.exit("bundle: no course.json and no inline seed to bundle")
        course = json.loads(match.group(1))
        print("course: using the inline seed (no course.json found)")

    html = inline_fonts(html)
    course = inline_frames(course, root)
    html = inject_seed(html, course)

    with open(out, "w", encoding="utf-8") as fh:
        fh.write(html)
    print("bundle: wrote %s (%.1fMB), double-clickable, boots from file://" % (
        out, os.path.getsize(out) / 1e6))


if __name__ == "__main__":
    main()
