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

# combines:
# periodic exports from: https://github.com/karlicoss/ghexport
# github GDPR export
class github:
    gdpr_dir: PathIsh = "~/data/github/gdpr"
    export_path: Paths = "~/data/github/ghexport/"
    ghexport: Optional[PathIsh] = repo("ghexport")


# combines:
# periodic exports from: https://github.com/karlicoss/rexport/
# comment export from: https://github.com/seanbreckenridge/pushshift_comment_export
class reddit:
    export_path: Paths = "~/data/rexport/"
    pushshift_export_path: Paths = "~/data/rps_comments/*.json"
    rexport: Optional[PathIsh] = repo("rexport")

# parses a manually created log file with https://github.com/seanbreckenridge/autotui
# https://github.com/seanbreckenridge/HPI/blob/master/my/body/weight.py
class weight:
    datafile: PathIsh = "~/data/weight.json"

# parses my zsh history and any backups
class zsh:
    export_path: Paths = "~/data/zsh_history/"
    live_file: Optional[PathIsh] = path.join(environ["ZDOTDIR"], ".zsh_history")

# parses current/finished http://todotxt.org/ using topydo
class todotxt:
    export_path: Paths = "~/data/todotxt/"
    live_file: Optional[PathIsh] = path.join(environ["XDG_CONFIG_HOME"], "todo", "todo.txt")

# parses information from git repositories which match my emails
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

# https://github.com/seanbreckenridge/blizzard_gdpr_parser
class blizzard:
    export_path: Paths = "~/data/blizzard/parsed.json"

# https://github.com/seanbreckenridge/forum_parser
class old_forums:
    export_path: Paths = "~/data/old_forums/*.json"

# parses the GDPR export
class skype:
    export_path: Paths = "~/data/skype.json"

# parses the GDPR export
class facebook:
    gdpr_dir: PathIsh = "~/data/facebook_gdpr/"

# parses backups of and the live ipython history sqlite databases
class ipython:
    export_path: Paths = "~/data/ipython/*.sqlite"

# parses https://takeout.google.com
class google:
    takeout_path: Paths = "~/data/google_takeout/"

# https://github.com/seanbreckenridge/ttt
class ttt:
    export_path: Paths = "~/data/ttt/*.csv"
    live_file: Optional[PathIsh] = path.join(environ["XDG_DATA_HOME"], "ttt_history.csv")


# class stackexchange:
#    export_path: Paths = "~/data/stexport"
#    stexport: Optional[PathIsh] = repo("stexport")
