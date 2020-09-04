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
    pushshift_export_path: Paths = "~/data/rps_comments/*.json"
    rexport: Optional[PathIsh] = repo("rexport")


class weight:
    datafile: PathIsh = "~/data/weight.json"


class zsh:
    export_path: Paths = "~/data/zsh_history/"
    live_file: Optional[PathIsh] = path.join(environ["ZDOTDIR"], ".zsh_history")

class todotxt:
    export_path: Paths = "~/data/todotxt/"
    live_file: Optional[PathIsh] = path.join(environ["XDG_CONFIG_HOME"], "todo", "todo.txt")

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

# uses my dameon for watching mpv events
# https://github.com/seanbreckenridge/mpv-sockets/blob/master/DAEMON.md
class mpv:
    export_path: Paths = "~/data/mpv/*.json"


# uses ffexport https://github.com/seanbreckenridge/ffexport
class firefox:
    export_path: Paths = "~/data/firefox/dbs/*.sqlite"


# uses lolexport: https://github.com/seanbreckenridge/lolexport
class league_of_legends:
    export_path: Paths = "~/data/league_of_legends/parsed.json"
    username = "purplepinapples"

# uses https://github.com/seanbreckenridge/steamscraper
class steam:
    export_path: Paths = "~/data/steam.json"

# uses https://github.com/seanbreckenridge/steamscraper
class blizzard:
    export_path: Paths = "~/data/blizzard/parsed.json"

class old_forums:
    export_path: Paths = "~/data/old_forums/*.json"

# class stackexchange:
#    export_path: Paths = "~/data/stexport"
#    stexport: Optional[PathIsh] = repo("stexport")
