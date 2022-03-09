import os

import subprocess
from pathlib import Path
from typing import Iterator
from typing import NamedTuple
from functools import lru_cache

import click


@lru_cache(maxsize=1)
def playlistdir() -> Path:
    proc = subprocess.run(
        ["plainplay", "playlistdir"], check=True, encoding="utf-8", capture_output=True
    )
    p = Path(proc.stdout.strip())
    assert p.exists(), "'plainplay playlistdir' returned path that doesnt exist"
    return p


@lru_cache(maxsize=1)
def musicdir() -> Path:
    return Path(os.environ["PLAINTEXT_PLAYLIST_MUSIC_DIR"])


class PlaylistPath(NamedTuple):
    path: str

    def in_dir(self, directory: Path) -> Path:
        return directory / self.path

    def in_musicdir(self) -> Path:
        return self.in_dir(musicdir())


def iterate_playlists(playlist_txt_dir: Path) -> Iterator[PlaylistPath]:
    """
    Get individual lines from each playlist.txt file
    """
    for playlistfile in playlist_txt_dir.rglob("*.txt"):
        try:
            for line in filter(
                str.strip, playlistfile.read_text(encoding="utf-8").splitlines()
            ):
                yield PlaylistPath(line.strip())
        except UnicodeDecodeError as e:
            click.echo(f"While decoding {playlistfile}", err=True)
            raise e
