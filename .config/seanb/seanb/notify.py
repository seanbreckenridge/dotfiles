"""
Python wrapper to call out to
https://github.com/seanbreckenridge/dotfiles/blob/master/.local/scripts/cross-platform/notify
"""

import shlex
from subprocess import check_call


def notify(msg: str, /, *, title: str) -> None:
    check_call(["notify", shlex.quote(title), shlex.quote(msg)])
