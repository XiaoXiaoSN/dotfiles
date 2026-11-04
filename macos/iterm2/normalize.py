#!/usr/bin/env python3
"""Normalize the iTerm2 preferences file that is shared through git.

iTerm2 owns this file: it loads it from this folder and writes it back when
preferences change. Two kinds of churn would otherwise make every commit noisy:

  * machine and UI state (window frames, toolbar layout, Sparkle, NoSync*
    counters) that says nothing about the settings themselves
  * dictionary ordering, which is not stable between saves

This script drops that state and writes a deterministic, sorted plist. Every
real preference is kept. The file is only rewritten when its bytes change, so
watching it cannot loop.

Usage: normalize.py PATH [PATH...]
"""

from __future__ import annotations

import plistlib
import re
import sys
from pathlib import Path

# iTerm2 prefixes keys it does not synchronise with "NoSync"; the rest are
# AppKit/Sparkle window and updater state.
VOLATILE = re.compile(
    r"^("
    r"NSWindow Frame"
    r"|NSSplitView Subview Frames"
    r"|NSToolbar Configuration"
    r"|NoSync"
    r"|SU[A-Z]"
    r")"
)


def normalize(path: Path) -> bool:
    """Rewrite *path* in normalized form. Returns True when bytes changed."""
    with path.open("rb") as handle:
        data = plistlib.load(handle)

    kept = {key: value for key, value in data.items() if not VOLATILE.match(key)}

    tmp = path.with_name(path.name + ".normalized")
    with tmp.open("wb") as handle:
        plistlib.dump(kept, handle, fmt=plistlib.FMT_XML, sort_keys=True)

    if not path.exists() or path.read_bytes() != tmp.read_bytes():
        tmp.replace(path)
        return True

    tmp.unlink()
    return False


def main(argv: list[str]) -> int:
    if len(argv) < 2:
        print(__doc__.strip().splitlines()[-1], file=sys.stderr)
        return 2

    for name in argv[1:]:
        path = Path(name)
        if not path.exists():
            print(f"skip missing {path}", file=sys.stderr)
            continue
        if normalize(path):
            print(f"normalized {path}")

    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv))
