import os

from promnesia.common import Source
from promnesia.sources import reddit, auto, github, smscalls

from promnesia_sean.sources import (
    facebook,
    ipython,
    commits,
    todotxt,
    albums,
    google_takeout,
    discord,
    browsing,
    mpv,
    newsboat,
    old_forums,
    trakt,
    ttt,
    zsh,
)

SOURCES = [
    Source(discord, render_markdown=True),
    Source(reddit, render_markdown=True),
    Source(github, render_markdown=True),
    ipython,
    todotxt,
    albums,
    commits,
    smscalls,
    facebook,
    newsboat,
    mpv,
    trakt,
    google_takeout,
    old_forums,
    ttt,
    zsh,
    browsing,
    Source(
        auto.index,
        "~/Repos/",
        name="Repos",
        ignored=[
            "*/dss-cruzhacks/data/*.csv",
            "*/albums/*",
            "*fixture/*",
            "*/vcr_cassettes/*",
            "*/search_index.json",
            "*/yarn.lock",
            "*/package.json",
            "*[plus1]*",
            "*/package-lock.json",
            "*/promnesia-fork/tests/*",
        ],
    ),
    Source(auto.index, "~/Documents/", name="Documents"),
    Source(
        auto.index,
        "~/GoogleDrive/",
        name="GoogleDrive",
        # ignore any data files
        ignored=["*.gpx", "*/SMSBackups/*.xml"],
    ),
]

CACHE_DIR = os.path.join(os.environ["HOME"], ".cache", "promnesia")
