from os import environ, path
from typing import Optional
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

#class stackexchange:
#    export_path: Paths = "~/data/stexport"
#    stexport: Optional[PathIsh] = repo("stexport")
