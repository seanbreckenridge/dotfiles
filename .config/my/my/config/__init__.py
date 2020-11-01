"""
Configuration file for https://github.com/seanbreckenridge/HPI/
[Human Programming Interface]
"""

from os import environ, path
from typing import Optional, Callable, List, Sequence
from pathlib import Path

from my.core import PathIsh, Paths


class core:
    cache_dir: PathIsh = "/tmp/cachew"
    enabled_modules: Sequence[PathIsh] = []
    disabled_modules: Sequence[PathIsh] = []


# combines:
# periodic exports from: https://github.com/karlicoss/ghexport
# github GDPR export
class github:
    gdpr_dir: PathIsh = "~/data/github/gdpr"
    export_path: Paths = "~/data/github/ghexport/"


# combines:
# periodic exports from: https://github.com/karlicoss/rexport/
# comment export from: https://github.com/seanbreckenridge/pushshift_comment_export
class reddit:
    export_path: Paths = "~/data/rexport/"
    pushshift_export_path: Paths = "~/data/rps_comments/*.json"


# prompt me for actions using https://github.com/seanbreckenridge/autotui
class body:
    datadir: PathIsh = "~/data/body/"


# parses my zsh history and any backups
class zsh:
    export_path: Paths = "~/data/zsh_history/"
    live_file: Optional[PathIsh] = path.join(environ["ZDOTDIR"], ".zsh_history")


# parses current/finished http://todotxt.org/ using topydo
class todotxt:
    export_path: Paths = "~/data/todotxt/"
    live_file: Optional[PathIsh] = path.join(
        environ["XDG_CONFIG_HOME"], "todo", "todo.txt"
    )


# parses my rss history
class rss:
    export_path: Paths = "~/data/rss/"
    live_file: Optional[PathIsh] = path.join(
        environ["XDG_CONFIG_HOME"], "newsboat", "urls"
    )


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
    export_path: Paths = "~/data/firefox/*.sqlite"


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


# parses the GDPR export
class spotify:
    gdpr_dir: PathIsh = "~/data/spotify/"


# parses backups of and the live ipython history sqlite databases
class ipython:
    export_path: Paths = "~/data/ipython/*.sqlite"


# parses https://takeout.google.com
class google:
    takeout_path: Paths = "~/data/google_takeout/"
    # this is the directory that my google drive gets mirrored to locally
    # when it detects a new takeout, it sends a warning, so I can run
    # the script to move it to takeout_path
    google_drive_local_path: Optional[Paths] = "~/GoogleDrive/Takeout/"


# https://github.com/seanbreckenridge/ttt
class ttt:
    export_path: Paths = "~/data/ttt/*.csv"
    live_file: Optional[PathIsh] = path.join(
        environ["XDG_DATA_HOME"], "ttt_history.csv"
    )


# https://github.com/seanbreckenridge/aw-watcher-window
class window_watcher:
    export_path: Paths = "~/data/window_watcher/*.csv"
    live_file: Optional[PathIsh] = path.join(
        environ["XDG_DATA_HOME"], "window_events.csv"
    )


class smscalls:
    export_path: PathIsh = "~/GoogleDrive/SMSBackups/"


class photos:
    paths: List[PathIsh] = ["~/Pictures/iCloudPhotos/", "~/data/google_takeout/"]
    # dont ignore anything
    ignored: Callable[[Path], bool] = lambda p: False


# parses the GDPR export
class apple:
    gdpr_dir: PathIsh = "~/data/apple/"


# parses the GDPR export
class discord:
    export_path: Paths = "~/data/discord/"


# .gpx files from https://github.com/mendhak/gpslogger
class gpslogger:
    export_path: Paths = "~/GoogleDrive/GPSLogger/"


from typing import Sequence, Union, Tuple
from datetime import datetime, date

DateIsh = Union[datetime, date, str]
LatLon = Tuple[float, float]


class location:
    from .locations_secret import home

class time:
    class tz:
        policy = 'convert'

# class stackexchange:
#    export_path: Paths = "~/data/stexport"
#    stexport: Optional[PathIsh] = repo("stexport")
