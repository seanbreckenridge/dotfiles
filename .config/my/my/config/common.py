from os import environ, path
from my.core.warnings import high


def repo(name: str) -> str:
    """
    e.g., converts to ~/Repos/name
    ~/Repos/ is where I store a lot of my git repositories
    """
    if "REPOS" in environ:
        return path.join(environ["REPOS"], name)
    else:
        high(
            r"Hey I use the $REPOS environment variable to determine where repositories are on my computer. If you have some directory you put those -- set something like 'export REPOS=~/projects' in your shell config. Otherwise, you can edit this 'def repo' function, or remove it from whatevers using it -- its probably some of my personal config"
        )
        return name
