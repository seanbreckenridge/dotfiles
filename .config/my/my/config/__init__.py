"""
Configuration file for
https://github.com/karlicoss/HPI/
https://github.com/seanbreckenridge/HPI/
[Human Programming Interface]
"""

import sys
from os import environ, path
from typing import Optional, Callable, List, Sequence
from pathlib import Path

from my.core import PathIsh, Paths


def repo(name: str) -> str:
    return path.join(environ["REPOS"], name)


# https://github.com/seanbreckenridge/reorder_editable
# if my easy-install.pth file was ordered wrong, fix it and exit!
from reorder_editable import Editable

if Editable().reorder([repo("HPI"), repo("HPI-fork")]):
    # this is true if we actually reordered the path, else path was already ordered
    print(
        "easy-install.pth was ordered wrong! It has been reordered, exiting to apply changes...",
        file=sys.stderr,
    )
    sys.exit(0)


# https://github.com/seanbreckenridge/ipgeocache
try:
    from .ipinfo_secret import ACCESS_TOKEN as ipinfo_secret_token

    environ["IPINFO_TOKEN"] = ipinfo_secret_token
except ImportError:
    pass


class core:
    cache_dir: PathIsh = path.join(environ["HOME"], ".cache", "cachew")
    enabled_modules: Sequence[str] = []
    disabled_modules: Sequence[str] = [
        "my.reading.polar",
        "my.stackexchange",
        "my.rtm",
        "my.media",
        "my.google",
        "my.jawbone",
        "my.twitter",
        "my.vk",
        "my.rss",
        "my.photos",
        "my.location.google",
        "my.calendar",
        "my.taplog",
        "my.runnerup",
        "my.rescuetime",
        "my.pocket",
        "my.lastfm",
        "my.kobo",
        "my.instapaper",
        "my.hypothesis",
        "my.foursquare",
        "my.fbmessenger",
        "my.endomondo",
        "my.arbtt",
        "my.emfit",
        "my.bluemaestro",
        "my.zotero",  # temporarily? till I start using it
    ]


def if_exists(p: PathIsh) -> Optional[PathIsh]:
    pp = Path(p)
    if pp.exists():
        return pp
    return None


# if the HPIDATA environment variable is set (which points to my data)
# use that. Else, just default to ~/data
prefix: Path = Path(environ.get("HPIDATA", path.join(environ["HOME"], "data")))

# prepend my data directory onto this path
def data(p: PathIsh) -> Path:
    return prefix / p


# combines:
# periodic exports from: https://github.com/karlicoss/ghexport
# github GDPR export
class github:
    gdpr_dir: PathIsh = data("github/gdpr")
    export_path: Paths = data("github/ghexport")


# combines:
# periodic exports from: https://github.com/karlicoss/rexport/
# comment export from: https://github.com/seanbreckenridge/pushshift_comment_export
class reddit:
    export_path: Paths = data("rexport")
    pushshift_export_path: Paths = data("pushshift")


# prompt me for actions using https://github.com/seanbreckenridge/autotui
# interfaces created by https://github.com/seanbreckenridge/ttally
class body:
    datadir: PathIsh = environ.get("TTALLY_DATA_DIR", data("phone/ttally/"))


# parses my zsh history and any backups
class zsh:
    export_path: Paths = data("zsh_history")
    live_file: Optional[PathIsh] = if_exists(
        path.join(environ["ZDOTDIR"], ".zsh_history")
    )


# parses current/finished http://todotxt.org/ using topydo
class todotxt:
    export_path: Paths = data("todotxt")
    live_file: Optional[PathIsh] = if_exists(
        path.join(environ["XDG_CONFIG_HOME"], "todo", "todo.txt")
    )


# parses the history of me adding/removing rss feeds
class newsboat:
    export_path: Paths = data("newsboat")


# parses information from git repositories which match my emails
class commits:
    names: List[str] = ["Sean Breckenridge"]
    emails: List[str] = [
        "seanbrecke@gmail.com",
        "sbrecken@ucsc.edu",
        "purplepinapplesyt@gmail.com",
    ]
    roots: Paths = [
        Path(environ["REPOS"]),
    ]


# uses my dameon for watching mpv events
# https://github.com/seanbreckenridge/mpv-history-daemon
class mpv:
    export_path: Paths = data("mpv/*.json")


# uses browserexport https://github.com/seanbreckenridge/browserexport
class browsing:
    export_path: Paths = data("browsing")

    # use my active firefox database
    from browserexport.browsers.firefox import Firefox

    live_databases: Paths = Firefox.locate_database()


# uses lolexport: https://github.com/seanbreckenridge/lolexport
class league_of_legends:
    export_path: Paths = data("league_of_legends/parsed*.json")
    username = "purplepinapples"


# uses chessdotcom_export: https://github.com/seanbreckenridge/chessdotcom_export
class chess:
    export_path: Paths = data("chessdotcom")


# uses traktexport: https://github.com/seanbreckenridge/traktexport
class trakt:
    export_path: Paths = data("trakt")


# uses my personal albums system: https://github.com/seanbreckenridge/albums
class albums:
    export_path: Paths = data("albums/*.json")


# uses https://github.com/seanbreckenridge/steamscraper
class steam:
    export_path: Paths = data("steam.json")


# https://github.com/seanbreckenridge/blizzard_gdpr_parser
class blizzard:
    export_path: Paths = data("blizzard/parsed.json")


# https://github.com/seanbreckenridge/forum_parser
class old_forums:
    export_path: Paths = data("old_forums/*.json")


# parses the GDPR export
class skype:
    export_path: Paths = data("skype.json")


# parses the GDPR export
class facebook:
    gdpr_dir: PathIsh = data("facebook_gdpr")


# parses the GDPR export
class spotify:
    gdpr_dir: PathIsh = data("spotify")


# parses backups of my ipython history
class ipython:
    export_path: Paths = data("ipython/*.sqlite")


# parses https://takeout.google.com
class google:
    takeout_path: Paths = data("google_takeout")
    # this is the directory that my google drive gets mirrored to locally
    # when it detects a new takeout, it sends a warning, so I can run
    # the script to move it to takeout_path
    google_drive_local_path: Optional[str] = "~/GoogleDrive/Takeout/"


# https://github.com/seanbreckenridge/ttt
class ttt:
    export_path: Paths = data("phone/ttt/*.csv")


class battery:
    export_path: Paths = data("battery.csv")


# https://github.com/seanbreckenridge/aw-watcher-window
class window_watcher:
    export_path: Paths = data("window_watcher/*.csv")
    force_individual: Optional[List[str]] = ["Alacritty"]


class smscalls:
    export_path: PathIsh = "~/GoogleDrive/SMSBackups/"


class photos:
    paths: List[PathIsh] = ["~/Pictures/iCloudPhotos/", data("google_takeout")]
    # dont ignore anything
    ignored: Callable[[Path], bool] = lambda p: False


# parses the GDPR export
class apple:
    gdpr_dir: PathIsh = data("apple")


# parses the GDPR export
class discord:
    export_path: Paths = data("discord")


# .gpx files from https://github.com/mendhak/gpslogger
class gpslogger:
    export_path: Paths = "~/GoogleDrive/GPSLogger/"


class pdfs:
    paths: Paths = [
        "~/Documents/Books/",
        "~/Documents/Notes/",
    ]


class stackexchange:
    export_path: PathIsh = ""


from typing import Sequence, Union, Tuple
from datetime import datetime, date

DateIsh = Union[datetime, date, str]
LatLon = Tuple[float, float]


class location:
    from .locations_secret import home


class time:
    class tz:
        policy = "convert"


# class stackexchange:
#    export_path: Paths = "~/data/stexport"
#    stexport: Optional[PathIsh] = repo("stexport")
