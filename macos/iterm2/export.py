#!/usr/bin/env python3
"""Export the live iTerm2 preferences into the portable files tracked by git.

The full preferences plist contains machine state and is deliberately not
tracked. Only two reviewable artefacts are: the default profile as JSON and the
colour preset. Both can be imported on another Mac.

Usage: export.py PLIST OUTPUT_DIR
"""

from __future__ import annotations

import json
import plistlib
import sys
from pathlib import Path

# Keys iTerm2 writes into an .itermcolors file. The profile dict contains more
# colour keys than this (per-appearance variants and tuning knobs), so keep the
# preset limited to the documented set.
COLOUR_KEYS = (
    "Ansi 0 Color",
    "Ansi 1 Color",
    "Ansi 2 Color",
    "Ansi 3 Color",
    "Ansi 4 Color",
    "Ansi 5 Color",
    "Ansi 6 Color",
    "Ansi 7 Color",
    "Ansi 8 Color",
    "Ansi 9 Color",
    "Ansi 10 Color",
    "Ansi 11 Color",
    "Ansi 12 Color",
    "Ansi 13 Color",
    "Ansi 14 Color",
    "Ansi 15 Color",
    "Background Color",
    "Badge Color",
    "Bold Color",
    "Cursor Color",
    "Cursor Guide Color",
    "Cursor Text Color",
    "Foreground Color",
    "Link Color",
    "Selected Text Color",
    "Selection Color",
)


def write_if_changed(path: Path, data: bytes) -> bool:
    if path.exists() and path.read_bytes() == data:
        return False
    path.write_bytes(data)
    return True


def default_profile(prefs: dict) -> dict:
    guid = prefs.get("Default Bookmark Guid")
    profiles = prefs.get("New Bookmarks", [])
    for profile in profiles:
        if guid and profile.get("Guid") == guid:
            return profile
    if not profiles:
        raise SystemExit("no profiles in preferences")
    return profiles[0]


def main(argv: list[str]) -> int:
    if len(argv) != 3:
        print(__doc__.strip().splitlines()[-1], file=sys.stderr)
        return 2

    plist_path = Path(argv[1])
    out_dir = Path(argv[2])

    with plist_path.open("rb") as handle:
        prefs = plistlib.load(handle)

    profile = default_profile(prefs)
    name = profile.get("Name") or "profile"

    profile_json = json.dumps(profile, indent=2, sort_keys=True, ensure_ascii=False) + "\n"
    colours = {key: profile[key] for key in COLOUR_KEYS if key in profile}
    itermcolors = plistlib.dumps(colours, fmt=plistlib.FMT_XML, sort_keys=True)

    write_if_changed(out_dir / f"{name}.json", profile_json.encode())
    write_if_changed(out_dir / "default.itermcolors", itermcolors)
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv))
