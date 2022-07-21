"""
Config file for https://github.com/seanbreckenridge/my_feed
"""

from .feed_secret import broken_tags  # noqa

ignore_mpv_prefixes: set[str] = {
    "/home/sean/Repos/",
    "/home/sean/Downloads",
}

allow_mpv_prefixes: set[str] = {
    "/home/sean/Music/",
    "/home/data/media/music/",
    "/home/sean/Downloads/Sort/",
    "/Users/sean/Music",
}

from typing import Iterator, Callable, TYPE_CHECKING

if TYPE_CHECKING:
    from my_feed.sources.model import FeedItem


def sources() -> Iterator[Callable[[], Iterator["FeedItem"]]]:
    from my_feed.sources import games

    yield games.steam
    yield games.osrs
    yield games.game_center
    yield games.grouvee
    yield games.chess

    from my_feed.sources import (
        trakt,
        listens,
        nextalbums,
        mal,
        mpv,
        facebook_spotify_listens,
    )

    yield trakt.history
    yield listens.history
    yield nextalbums.history
    yield mal.history
    yield mpv.history
    yield facebook_spotify_listens.history
