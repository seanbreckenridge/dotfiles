from promnesia.common import Source
from promnesia.sources import (
    reddit,
    discord,
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
)


SOURCES = [
    reddit,
    discord,
    newsboat,
    mpv,
    trakt,
    takeout,
    old_forums,
    ttt,
    zsh,
    ffexport,
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
