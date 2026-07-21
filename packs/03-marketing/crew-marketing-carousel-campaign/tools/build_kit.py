#!/usr/bin/env python3
"""
build_kit.py - assemble the posting kit at ~/Desktop/[Campaign Name]/.
One folder per carousel, numbered files, caption txt, top-level READ ME.
Safe to re-run; hero videos are added when exports/motion/*.mp4 exist.

ADAPT PER CAMPAIGN: edit KIT and the CAROUSELS list (number, name, hero stem,
caption). The captions below are the FICTIONAL Saltbrook Ceramics worked
example; they follow the caption formula in references/offer-and-copy.md.
"""
import os, shutil

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
KIT = os.path.expanduser("~/Desktop/Carousels Saltbrook")

CAROUSELS = [
    (1, "The Announcement", "hero1-announcement",
"""Six pieces. One day.

ONE DAY ON THE WHEEL. 14.11. Six hours at your own wheel.

You walk in never having touched clay and walk out having thrown six real pieces. We fire the lot in the studio kiln and you collect the finished set two weeks later.

No experience needed. Clay, tools, aprons and firing all included.

$349 opening price. The lowest it will ever be. 12 wheels only.

Tap the link in bio to lock your wheel.

#PotteryWorkshop #WheelThrowing #LearnPottery #MakerWorkshop #Handmade #SaltbrookCeramics"""),
    (2, "The Differentiator", "hero2-differentiator",
"""Stop scrolling. Start throwing.

40 saved reels, a folder of tutorials, a wishlist with a wheel in it. That is every maker feed. So we turned off the screen.

On 14.11 you are in the studio, at a wheel, hands on clay, with a potter beside you. No modules. No replays. You make it and you take it home.

$349 opening price. 12 wheels only.

Tap the link in bio to see open wheels.

#PotteryWorkshop #WheelThrowing #LearnPottery #MakerWorkshop #Handmade #SaltbrookCeramics"""),
    (3, "The Credentials", "hero3-credentials",
"""Check who is teaching before you book.

Twenty years of production throwing. Work stocked in three galleries. More than 400 beginners taught at this wheel. Not an influencer. A potter who teaches, and still throws daily.

ONE DAY ON THE WHEEL. 14.11. $349 opening price. 12 wheels only.

Tap the link in bio to lock your wheel.

#PotteryWorkshop #WheelThrowing #LearnPottery #MakerWorkshop #Handmade #SaltbrookCeramics"""),
    (4, "The Mechanism", "hero4-mechanism",
"""Throw. Trim. Glaze. Collect.

Morning: centre your first ball of clay and throw six pieces at your own wheel. Afternoon: trim your best and glaze two favourites from the studio glaze wall. We fire everything in the studio kiln, and two weeks later you collect a finished, food-safe set.

Clay, tools, firing and glazes all included.

$349 opening price. 12 wheels only.

Tap the link in bio to book 14.11.

#PotteryWorkshop #WheelThrowing #LearnPottery #MakerWorkshop #Handmade #SaltbrookCeramics"""),
    (5, "The Close", "hero5-close",
"""No experience. No problem.

If you can push your hands into mud, you can throw a pot. One day, six hours, built for absolute beginners: walk in at nine, leave with six pieces headed for the kiln.

$349 opening price. This is the floor, it only goes up from here. 12 wheels only. 14.11.

Tap the link in bio to start.

#PotteryWorkshop #WheelThrowing #BeginnerPottery #LearnPottery #Handmade #SaltbrookCeramics"""),
    (6, "The Keepsake", "hero6-keepsake",
"""Everything you own was made by someone else.

Your mug, your bowl, your plates: all of it arrived in a box, made by hands you will never meet. On 14.11 you make the next one yourself: thrown by your hands, glazed in your colour, fired and permanent.

ONE DAY ON THE WHEEL. $349 opening price. 12 wheels only.

Tap the link in bio to own your seat.

#PotteryWorkshop #WheelThrowing #MadeByHand #LearnPottery #Handmade #SaltbrookCeramics"""),
]

FIRST_COMMENT = "Seats are limited for 14.11. Book here: [BOOKING LINK]"

README = """CAROUSELS SALTBROOK - HOW TO POST

Each folder is one complete carousel, ready to go.

TO POST ONE:
1. Open Instagram (or Facebook), create a new post, and select the files in number order:
   1 - HERO video (post first).mp4   <- this is slide 1
   2 - slide.png
   3 - slide.png
   4 - slide.png
   (If the video will not upload, use "1 - HERO backup image.png" instead.)
2. Open "0 - CAPTION.txt" in the same folder. Copy the caption, paste it into the post.
3. Publish, then paste the FIRST COMMENT (bottom of the caption file) as your first comment.
4. Make sure the booking link is in your bio before posting. If you boost the post as an ad, the ad button carries the same link.

POSTING ORDER (one per week, building to the event):
  Week 1: Carousel 1 - The Announcement
  Week 2: Carousel 6 - The Keepsake
  Week 3: Carousel 2 - The Differentiator
  Week 4: Carousel 3 - The Credentials
  Week 5: Carousel 4 - The Mechanism
  Launch week: Carousel 5 - The Close, plus re-run whichever earlier one performed best.

NOTE: If you have two style campaigns for the same offer, run ONE campaign per
channel, or alternate campaigns per week for variety. Do not post both versions
of the same concept in the same week.

Event: ONE DAY ON THE WHEEL, 14.11. $349 opening price.
Replace [BOOKING LINK] in each caption file once the booking page is live.
"""


def main():
    os.makedirs(KIT, exist_ok=True)
    open(os.path.join(KIT, "READ ME FIRST.txt"), "w").write(README)
    videos = 0
    for n, name, hero, caption in CAROUSELS:
        folder = os.path.join(KIT, "Carousel %d - %s" % (n, name))
        os.makedirs(folder, exist_ok=True)
        open(os.path.join(folder, "0 - CAPTION.txt"), "w").write(
            caption + "\n\n---\nFIRST COMMENT (post right after publishing):\n" + FIRST_COMMENT + "\n")
        shutil.copy(os.path.join(ROOT, "exports", hero + ".png"),
                    os.path.join(folder, "1 - HERO backup image.png"))
        for p in (2, 3, 4):
            shutil.copy(os.path.join(ROOT, "exports", "pages", "c%dp%d.png" % (n, p)),
                        os.path.join(folder, "%d - slide.png" % p))
        mp4 = os.path.join(ROOT, "exports", "motion", hero + ".mp4")
        if os.path.exists(mp4) and os.path.getsize(mp4) > 100000:
            shutil.copy(mp4, os.path.join(folder, "1 - HERO video (post first).mp4"))
            videos += 1
    print("kit built at", KIT, "| videos included:", videos, "/ 6")


if __name__ == "__main__":
    main()
