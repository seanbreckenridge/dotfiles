# dotfiles

Work in progress dotfiles for arch [i3-gaps].

Uses [yadm](https://yadm.io) to manage dotfiles.

[.yadm](./.yadm) includes lists of packages for pacman/yay, python libs to install with pip, and global npm cli tools.

The package lists can be updated, and `yadm bootstrap` can be run repeatedely to make sure everything is installed.


## Install

```
yadm clone https://github.com/seanbreckenridge/dotfiles
yadm bootstrap
```

#### yadm with a README.md

Since yadm acts directly on the `$HOME` directory instead of symlinking,
in order to have a README for this repo without polluting `$HOME` with a `README.md`
file, this uses hooks located at [.yadm/hooks](.yadm/hooks) to temporarily copy
the `README.md` to `$HOME` while commiting, and then deleting it afterwards.

Theres another hook that moves `~/README.md` to `~/.yadm/README.md` `post-merge`, so that
README changes done through the web interface stay updated locally.

As long as you're on `git>=2.9`, you can use `core.hooksPath` to change the hooks dir.

After cloning, that can be setup by doing:

```
yadm gitconfig core.hooksPath ~/.yadm/hooks
```

Then, by editing the README at `~/.yadm/README.md` locally, 
it gets added automatically to the next commit.

This does have the downside of not being able to commit README changes directly, and
there are some edge cases, but it works for its intended purpose.

The easiest way to edit the README directly (without attaching it to another commit)
is through modifying it on github, and then `yadm pull`.

#### LICENSE

Unless where attributed, all code is licensed under the MIT License:

MIT License

Copyright (c) 2019 Sean Breckenridge

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
