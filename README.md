# dotfiles

Work in progress dotfiles for arch [i3-gaps].

Uses [yadm](https://yadm.io) to manage dotfiles.


## Install

```
yadm clone https://github.com/seanbreckenridge/dotfiles
yadm bootstrap
```

#### yadm and hooks

Since yadm acts directly on the $HOME directory instead of symlinking,
in order to have a README.md for this repo without polluting $HOME with a README.md
file, this uses hooks located at [.yadm/hooks](.yadm/hooks) to temporarily copy
the README.md to $HOME while commiting, and then deleting it after commiting.

Theres another hook that moves ~/README.md to ~/.yadm/README.md 'post-merge', so that
README.md changes done through the web interface stay updated locally

As long as you're on git>=2.9, you can use `core.hooksPath` to change the hooks dir.

After cloning, that can be setup by doing:

```
yadm gitconfig core.hooksPath ~/.yadm/hooks
```

Then, by editing the README at .yadm/README.md locally, if its been changed
it gets automatically added to the next commit you do.

This does have the downside of not being able to commit readme changes directly, and
there are some edge cases, but it works for its intended purpose.
