"""
Configuration file for
https://github.com/karlicoss/HPI/
https://github.com/seanbreckenridge/HPI/
https://github.com/seanbreckenridge/HPI-personal
[Human Programming Interface]
"""

import sys
import tempfile
from os import environ, path, listdir
from typing import Optional, Callable, List, Sequence
from pathlib import Path

from my.core.common import PathIsh, Paths

### HELPERS

# e.g., converts to ~/Repos/name
# ~/Repos/ is where I store a lot of my git repositories
def repo(name: str) -> str:
    return path.join(environ["REPOS"], name)


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


### REORDER PATH

try:
    # https://github.com/seanbreckenridge/reorder_editable
    # if my easy-install.pth file was ordered wrong, fix it and exit!
    from reorder_editable import Editable, ReorderEditableError
except:
    pass
else:
    try:
        if Editable().reorder(
            [repo("HPI-personal"), repo("HPI"), repo("HPI-karlicoss")]
        ):
            # this is true if we actually reordered the path, else path was already ordered
            print(
                "easy-install.pth was ordered wrong! It has been reordered, exiting to apply changes...",
                file=sys.stderr,
            )
            sys.exit(0)
    except ReorderEditableError as re:
        if "Provided one or more value" in str(re):
            print(str(re), file=sys.stderr)
        else:
            raise re


### MODULES

DISABLED_MODULES = [
    "my.body",
    "my.polar",
    "my.stackexchange",
    "my.rtm",
    "my.media",
    r"my.google\.takeout",  # ignore karlicoss google module
    "my.orgmode",
    "my.jawbone",
    "my.twitter.twint",
    "my.twitter.talon",
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
    "my.bumble",
    "my.instagram",
    "my.hackernews",
    "my.zotero",  # temporarily? till I start using it
]


# https://github.com/seanbreckenridge/mint
# If I can't import the 'budget' module that is installed by mint
# add `my.money` (the dependent module) to disabled, so it doesn't
# clutter hpi doctor on devices that don't have it installed
# e.g., on my phone (termux), where installing pandas/numpy/scipy/matplotlib
# doesnt work
try:
    import budget
except:
    DISABLED_MODULES.append("my.mint")

# albums may not work on some versions of python
try:
    from nextalbums import __main__ as _m
except:
    DISABLED_MODULES.append("my.nextalbums")


class core:
    cache_dir: PathIsh = path.join(environ["HOME"], ".cache", "cachew")
    tmp_dir: PathIsh = path.join(tempfile.gettempdir(), "HPI-tempdir")
    enabled_modules: Sequence[str] = []
    disabled_modules: Sequence[str] = tuple(DISABLED_MODULES)


### MODULE CONFIG

# combines:
# periodic exports from: https://github.com/karlicoss/ghexport
# github GDPR export
class github:
    gdpr_dir: PathIsh = data("github/gdpr")
    export_path: Paths = data("github/ghexport")


MAILDIR = Path(
    environ.get("MAILDIR", path.join(environ["HOME"], ".local", "share", "mail"))
)


def list_mailboxes(p: Path) -> Sequence[Path]:
    dirs: List[Path] = []
    if MAILDIR.exists():
        dirs = [p / f for f in listdir(p) if "@" in f]
    return tuple(dirs)


class mail:
    # locally synced IMAP mailboxes using mbsync
    class imap:
        # path[s]/glob to the the mailboxes/IMAP files
        mailboxes = list_mailboxes(MAILDIR)


# combines:
# periodic exports from: https://github.com/karlicoss/rexport/
# comment export from: https://github.com/seanbreckenridge/pushshift_comment_export
class reddit:
    class rexport:
        export_path: Paths = data("rexport")

    class pushshift:
        export_path: Paths = data("pushshift")


# parses my zsh history and any backups
class zsh:
    export_path: Paths = data("zsh_history")
    live_file: Optional[PathIsh] = if_exists(
        path.join(environ["ZDOTDIR"], ".zsh_history")
    )


# parses bash history
class bash:
    export_path: Paths = data("bash_history")


# parses current/finished http://todotxt.org/ using topydo
class todotxt:
    class file_backups:
        export_path: Paths = data("todotxt")
        live_file: Optional[PathIsh] = if_exists(
            path.join(environ["HPIDATA"], "todo", "todo.txt")
        )


# parses the history of me adding/removing rss feeds
class rss:
    class newsboat:
        class file_backups:
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
    class history_daemon:
        export_path: Paths = data("mpv/*.json")


# use my active firefox database
from browserexport.browsers.firefox import Firefox

live_dbs: List[Path] = []
try:
    live_dbs.append(Firefox.locate_database())
except Exception:
    pass

# uses browserexport https://github.com/seanbreckenridge/browserexport
class browser:
    class export:
        export_path: Paths = data("browsing")

    class active_browser:
        export_path: Paths = tuple(live_dbs)


# uses lolexport: https://github.com/seanbreckenridge/lolexport
class league:
    class export:
        export_path: Paths = data("league_of_legends/parsed*.json")
        username = "purplepinapples"


# uses https://github.com/seanbreckenridge/chess_export
class chess:
    class export:
        export_path: Paths = data("chess")


# uses https://github.com/seanbreckenridge/listenbrainz_export
class listenbrainz:
    class export:
        export_path: Paths = data("listenbrainz")


# uses traktexport: https://github.com/seanbreckenridge/traktexport
class trakt:
    class export:
        export_path: Paths = data("trakt")


# uses malexport: https://github.com/seanbreckenridge/malexport
class mal:
    class export:
        export_path: PathIsh = data("malexport")


# uses https://github.com/seanbreckenridge/grouvee_export
class grouvee:
    class export:
        export_path: Paths = data("grouvee")


# uses my personal albums system: https://github.com/seanbreckenridge/albums
class nextalbums:
    export_path: Paths = data("albums.json")


# uses https://github.com/seanbreckenridge/steamscraper
class steam:
    class scraper:
        export_path: Paths = data("steam.json")


# https://github.com/seanbreckenridge/blizzard_gdpr_parser
class blizzard:
    class gdpr:
        export_path: Paths = data("blizzard/parsed.json")


environ["OLD_FORUMS_SELECTORS"] = str(data("old_forum_selectors.json"))
# https://github.com/seanbreckenridge/old_forums
class old_forums:
    # path[s]/glob to the folder which contains JSON/HTML files
    export_path: Paths = data("old_forums")


class project_euler:
    # path[s]/glob to the .txt export files
    export_path: Paths = data("project_euler")


# parses the GDPR export
class skype:
    class gdpr:
        export_path: Paths = data("skype.json")


# parses the GDPR export
class facebook:
    class gdpr:
        gdpr_dir: PathIsh = data("facebook_gdpr")


# parses the GDPR export
class spotify:
    class gdpr:
        gdpr_dir: PathIsh = data("spotify")


class twitch:

    # my chatlogs from the overrustle_logs dump
    # https://github.com/seanbreckenridge/overrustle_parser
    class overrustle:
        export_path: Paths = data("twitch/overrustle_logs.json")

    # parses the privacy request
    class gdpr:
        gdpr_dir: PathIsh = data("twitch/gdpr")


# parses backups of my ipython history
class ipython:
    export_path: Paths = data("ipython/*.sqlite")


# parses https://takeout.google.com using https://github.com/seanbreckenridge/google_takeout_parser
class google:
    takeout_path: Paths = data("google_takeout/*.zip")


# https://github.com/seanbreckenridge/ttt
class ttt:
    export_path: Paths = data("ttt/*.csv")


# https://github.com/seanbreckenridge/aw-watcher-window
class window_watcher:
    export_path: Paths = data("window_watcher/*.csv")
    force_individual: Optional[List[str]] = ["Alacritty"]


class smscalls:
    export_path: Paths = data("SMSBackups")


class photos:
    paths: List[PathIsh] = ["~/Pictures/iCloudPhotos/", data("google_takeout")]
    # dont ignore anything
    ignored: Callable[[Path], bool] = lambda p: False


# parses the GDPR export
class apple:
    class privacy_export:
        gdpr_dir: PathIsh = data("apple")


# parses the GDPR export
class discord:
    class data_export:
        export_path: Paths = data("discord/*.zip")


class runelite:
    class screenshots:
        export_path: Paths = data("runelite_screenshots")


# .gpx files from https://github.com/mendhak/gpslogger
class gpslogger:
    export_path: Paths = data("gpslogger")


class pdfs:
    paths: Paths = [
        "~/Documents/Books/",
        "~/Documents/Notes/",
    ]


class zulip:
    class organization:
        export_path: Paths = data("zulip/organization")


class twitter_archive:
    export_path: Paths = data("twitter/archive.zip")


class stackexchange:
    export_path: PathIsh = ""


from typing import Sequence, Union, Tuple
from datetime import datetime, date

DateIsh = Union[datetime, date, str]
LatLon = Tuple[float, float]


class location:
    try:
        from .locations_secret import home
    except:
        pass


class time:
    class tz:
        policy = "convert"


# class stackexchange:
#    export_path: Paths = "~/data/stexport"
#    stexport: Optional[PathIsh] = repo("stexport")
