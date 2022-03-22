"""
Configuration file for
https://github.com/karlicoss/HPI/
https://github.com/seanbreckenridge/HPI/
https://github.com/seanbreckenridge/HPI-personal
[Human Programming Interface]
"""

import tempfile
from os import environ, path
from typing import Optional, Callable, List, Sequence, Union, Tuple
from pathlib import Path
from datetime import datetime, date
from browserexport.browsers.firefox import Firefox


from my.core.common import PathIsh, Paths
from my.core.warnings import high

from .common import repo
from .reorder_path import seanbreckenridge_reorder_path

seanbreckenridge_reorder_path()

#############
#           #
#  HELPERS  #
#           #
#############


def if_exists(p: PathIsh) -> Optional[Path]:
    pp = Path(p)
    if pp.exists():
        return pp
    return None


def filter_exists(pths: List[PathIsh]) -> List[Path]:
    res: List[Path] = []
    for p in pths:
        r = if_exists(p)
        if r is not None:
            res.append(r)
    return res


# if the HPIDATA environment variable is set (which points to my data)
# use that. Else, just default to ~/data
PREFIX: Path = Path(environ.get("HPIDATA", path.join(environ["HOME"], "data")))


def data(p: PathIsh) -> Path:
    """prepend my data directory onto this path"""
    return PREFIX / p


#############
#           #
#  MODULES  #
#           #
#############

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
    import budget  # noqa
except ImportError:
    DISABLED_MODULES.append("my.mint")

# albums may not work on some versions of python
try:
    from nextalbums import __main__ as _m  # noqa
except ImportError:
    DISABLED_MODULES.append("my.nextalbums")


class core:
    cache_dir: PathIsh = path.join(environ["HOME"], ".cache", "cachew")
    tmp_dir: PathIsh = path.join(tempfile.gettempdir(), "HPI-tempdir")
    enabled_modules: Sequence[str] = []
    disabled_modules: Sequence[str] = tuple(DISABLED_MODULES)


###################
#                 #
#  MODULE CONFIG  #
#                 #
###################


class github:
    """
    combines:
    periodic exports from: https://github.com/karlicoss/ghexport
    github GDPR export
    """

    gdpr_dir: PathIsh = data("github/gdpr")
    export_path: Paths = data("github/ghexport")


# if you want to override this, you can set in your ~/.bashrc or something:
# export MAILDIR='~/Documents/mail'
# or glob something:
# MAILDIR='~/.local/share/mail/*@gmail.com'
MAILDIR = environ.get("MAILDIR", "~/.local/share/mail")


class mail:
    # locally synced IMAP mailboxes using mbsync
    class imap:
        # path[s]/glob to the the mailboxes/IMAP files
        # you could also just do something like:
        # mailboxes = "~/Documents/mail/*@*"
        # to match any files in that directory with '@' in them
        #
        # to confirm this is matching your files, can do:
        # hpi query my.mail.imap.files -s
        mailboxes = MAILDIR

    #class mbox:
    #   mailboxes = "~/Downloads/importExportBackup"


# combines:
class reddit:
    class rexport:
        """periodic exports from: https://github.com/karlicoss/rexport/"""

        export_path: Paths = data("rexport")

    class pushshift:
        """
        comment export using
        https://github.com/seanbreckenridge/pushshift_comment_export
        """

        export_path: Paths = data("pushshift")


# parses my zsh history and any backups
class zsh:
    export_path: Paths = data("zsh_history")
    live_file: Optional[PathIsh] = if_exists(
        path.join(environ["ZDOTDIR"], ".zsh_history")
    )


# parses bash history
class bash:
    export_path: Paths = (data("bash_history"), data("bash"))


# parses current/done http://todotxt.org/
class todotxt:
    class git_history:
        export_path: Path = data("todo_git_history")


# parses the history of me adding/removing rss feeds
class rss:
    class newsboat:
        class git_history:
            export_path: Path = data("newsboat_git")


# parses information from git repositories which match my emails
class commits:
    try:
        from .commits_secret import emails, names

        emails = emails
        names = names
    except ImportError:
        pass

    roots: Paths = filter_exists(
        [
            repo(""),
            Path(environ["HOME"]) / "Documents/OldRepos",
            Path(environ["HOME"]) / ".local/share/go/src/github.com/seanbreckenridge/",
        ]
    )


class mpv:
    class history_daemon:
        """https://github.com/seanbreckenridge/mpv-history-daemon"""

        export_path: Paths = data("mpv/*.json")


live_dbs: List[Path] = []
try:
    live_dbs.append(Firefox.locate_database())
except Exception:
    pass


class browser:
    """
    uses browserexport https://github.com/seanbreckenridge/browserexport
    """

    class export:
        export_path: Paths = data("browsing")

    class active_browser:
        export_path: Paths = tuple(live_dbs)


class league:
    class export:
        """https://github.com/seanbreckenridge/lolexport"""

        export_path: Paths = data("league_of_legends/*.json")
        username = "purplepinapples"


class chess:
    class export:
        """https://github.com/seanbreckenridge/chess_export"""

        export_path: Paths = data("chess")


class listenbrainz:
    class export:
        """https://github.com/seanbreckenridge/listenbrainz_export"""

        export_path: Paths = data("listenbrainz")


class trakt:
    class export:
        """https://github.com/seanbreckenridge/traktexport"""

        export_path: Paths = data("trakt")


class mal:
    class export:
        """https://github.com/seanbreckenridge/malexport"""

        export_path: PathIsh = data("malexport")


class grouvee:
    class export:
        """https://github.com/seanbreckenridge/grouvee_export"""

        export_path: Paths = data("grouvee")


class nextalbums:
    """
    uses my personal albums system
    https://github.com/seanbreckenridge/albums
    """

    export_path: Paths = data("albums.json")


class steam:
    class scraper:
        """https://github.com/seanbreckenridge/steamscraper"""

        export_path: Paths = data("steam.json")


class piazza:
    class scraper:
        """https://github.com/seanbreckenridge/piazza-scraper"""

        export_path: Paths = data("piazza/*.json")


class blizzard:
    """https://github.com/seanbreckenridge/blizzard_gdpr_parser"""

    class gdpr:
        export_path: Paths = data("blizzard/parsed.json")


environ["OLD_FORUMS_SELECTORS"] = str(data("old_forum_selectors.json"))


class old_forums:
    """https://github.com/seanbreckenridge/old_forums"""

    # path[s]/glob to the folder which contains JSON/HTML files
    export_path: Paths = data("old_forums")


class project_euler:
    export_path: Paths = data("project_euler")


class skype:
    class gdpr:
        export_path: Paths = data("skype.json")


class facebook:
    class gdpr:
        gdpr_dir: PathIsh = data("facebook_gdpr")


class spotify:
    class gdpr:
        gdpr_dir: PathIsh = data("spotify")


class twitch:
    class overrustle:
        """
        my chatlogs from the overrustle_logs dump
        https://github.com/seanbreckenridge/overrustle_parser
        """

        export_path: Paths = data("twitch/overrustle_logs.json")

    class gdpr:
        """parses the privacy request"""

        gdpr_dir: PathIsh = data("twitch/gdpr")


class ipython:
    """parses backups of my ipython history"""

    export_path: Paths = data("ipython/*.sqlite")


class google:
    """
    parses https://takeout.google.com using
    https://github.com/seanbreckenridge/google_takeout_parser
    """

    takeout_path: Paths = data("google_takeout/*.zip")


class ttt:
    """https://github.com/seanbreckenridge/ttt"""

    export_path: Paths = data("ttt/*.csv")


class window_watcher:
    """https://github.com/seanbreckenridge/aw-watcher-window"""

    export_path: Paths = data("window_watcher/*.csv")
    force_individual: Optional[List[str]] = ["Alacritty"]


class smscalls:
    export_path: Paths = data("SMSBackups")


class photos:
    paths: List[PathIsh] = ["~/Pictures/iCloudPhotos/", data("google_takeout")]
    # dont ignore anything
    ignored: Callable[[Path], bool] = lambda _p: False


class apple:
    class privacy_export:
        gdpr_dir: PathIsh = data("apple")


class discord:
    class data_export:
        """https://github.com/seanbreckenridge/discord_data"""

        export_path: Paths = data("discord/*.zip")


class runelite:
    class screenshots:
        export_path: Paths = data("runelite_screenshots")


class gpslogger:
    """.gpx files from https://github.com/mendhak/gpslogger"""

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


DateIsh = Union[datetime, date, str]
LatLon = Tuple[float, float]


class location:
    try:
        from .locations_secret import home

        home = home
    except ImportError:
        pass


class time:
    class tz:
        policy = "convert"


# class stackexchange:
#    export_path: Paths = "~/data/stexport"
#    stexport: Optional[PathIsh] = repo("stexport")
