import os

from promnesia.common import Source
from promnesia.sources import (
    facebook,
    reddit,
    commits,
    todotxt,
    albums,
    github,
    auto,
    takeout,
    discord,
    ffexport,
    mpv,
    newsboat,
    old_forums,
    trakt,
    ttt,
    zsh,
    smscalls,
)


SOURCES = [
    todotxt,
    albums,
    github,
    commits,
    smscalls,
    reddit,
    discord,
    facebook,
    newsboat,
    mpv,
    trakt,
    takeout,
    old_forums,
    ttt,
    zsh,
    Source(ffexport, name="browsing"),
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

