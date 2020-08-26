from os import environ
from typing import Optional
from pathlib import Path

from my.core import PathIsh, Paths

class github:
    gdpr_dir: PathIsh = Path('~/data/github/gdpr').expanduser()
    export_path: Paths = "~/data/github/ghexport/*.json"
    ghexport : Optional[PathIsh] = environ["REPOS"] + '/ghexport'
