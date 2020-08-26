from os import environ
from typing import Optional
from pathlib import Path

from my.core import PathIsh, Paths

class github:
    gdpr_dir: PathIsh = Path('~/data/github/gdpr').expanduser()
    export_path: Paths = "~/data/github/ghexport/"
    ghexport : Optional[PathIsh] = environ["REPOS"] + '/ghexport'

class zsh:
    export_path: Paths = "~/data/zsh_history/"
    live_zsh_history: Optional[PathIsh] = environ["ZDOTDIR"] + '/.zsh_history'
