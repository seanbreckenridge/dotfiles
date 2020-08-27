"""
Configuration file for https://github.com/seanbreckenridge/HPI/
[Human Programming Interface]
"""

from os import environ, path
from typing import Optional, List
from pathlib import Path

from my.core import PathIsh, Paths


def repo(repo_name: str) -> str:
    return path.join(environ["REPOS"], repo_name)


class github:
    gdpr_dir: PathIsh = Path("~/data/github/gdpr").expanduser()
    export_path: Paths = "~/data/github/ghexport/"
    ghexport: Optional[PathIsh] = repo("ghexport")


class reddit:
    export_path: Paths = "~/data/rexport/"
    rexport: Optional[PathIsh] = repo("rexport")


class weight:
    logfile: PathIsh = "~/data/weight.log"


class zsh:
    export_path: Paths = "~/data/zsh_history/"
    live_zsh_history: Optional[PathIsh] = path.join(environ["ZDOTDIR"], ".zsh_history")


class commits:
    # names: List[str] = ["Sean Breckenridge"]
    emails: List[str] = [
        "seanbrecke@gmail.com",
        "sbrecken@ucsc.edu",
        "purplepinapplesyt@gmail.com",
    ]
    roots: Paths = [
        Path(environ["REPOS"]),
    ]


# class stackexchange:
#    export_path: Paths = "~/data/stexport"
#    stexport: Optional[PathIsh] = repo("stexport")
