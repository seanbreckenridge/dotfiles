"""
Config file for https://github.com/seanbreckenridge/my_feed
"""

from .feed_secret import broken_tags, ignore_specific_files  # noqa
from .seanb.feed_transform_secret import TRANSFORMS  # noqa

ignore_mpv_prefixes: set[str] = {
    "/home/sean/Repos/",
    "/home/sean/Downloads",
    "/home/sean/Documents",
}

allow_mpv_prefixes: set[str] = {
    "/home/sean/Music/",
    "/home/data/media/music/",
    "/home/sean/Downloads/Sort/",
    "/Users/sean/Music",
}

ignore_mpv_prefixes.update(ignore_specific_files)

from typing import Iterator, Callable, TYPE_CHECKING

if TYPE_CHECKING:
    from my_feed.sources.model import FeedItem


def sources() -> Iterator[Callable[[], Iterator["FeedItem"]]]:
    from my_feed.sources import games
    from my_feed.transform import transform

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
    yield nextalbums.history
    yield mal.history
    yield mal.deleted_history
    yield transform(listens.history)
    yield transform(mpv.history)
    yield transform(facebook_spotify_listens.history)
