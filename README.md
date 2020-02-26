# dotfiles

- [zsh](http://zsh.sourceforge.net/)
- [i3-gaps](https://github.com/Airblader/i3) - window manager
- [yadm](https://yadm.io) to manage dotfiles
- my [fork of st](https://github.com/seanbreckenridge/st) as terminal (sets colors in `config.h`)
- [picom ](https://github.com/yshui/picom) for window compositing
- [firefox-developer-edition](https://www.archlinux.org/packages/community/x86_64/firefox-developer-edition/)
- [rofi](https://github.com/davatorium/rofi) (launcher) with
  [solarized-darker](https://github.com/davatorium/rofi-themes/blob/master/User%20Themes/solarized-darker.rasi)
- [emacs (doom)](https://github.com/koalaman/shellcheck) (primary) and
  [nvim](https://neovim.io/) as editors - see [editor](./.scripts/bin/editor)
- [i3lock](https://i3wm.org/i3lock/) for screen lock; [daemon process](https://github.com/seanbreckenridge/dotfiles/blob/master/.scripts/system/lock_screen) caches pixelated version of screen to speed up start time
- [dunst](https://dunst-project.org/) for notificaitons
- [i3blocks](https://github.com/vivien/i3blocks) for status bar
- [lightdm](https://wiki.archlinux.org/index.php/LightDM) - display manager
- [todotxt](http://todotxt.org/) for todos, with a [rofi interface](https://github.com/seanbreckenridge/dotfiles/blob/master/.config/i3blocks/blocks/todo) as GUI.
- [ranger](https://github.com/ranger/ranger) - file manager

[.config/yadm](./.config/yadm) includes lists of packages for pacman/yay, python, and npm.

Packages can be added to the `.txt` files manually, and then `yadm bootstrap` can be run repeatedely to make sure everything is installed.

- [.config/shortcuts.toml](.config/shortcuts.toml) - describes basic shell scripts that are created by [shortcuts](https://github.com/seanbreckenridge/shortcuts)
- [dir-aliases](https://github.com/seanbreckenridge/dotfiles/blob/master/.scripts/bin/dir-aliases) generates aliases from `key->directory` mappings described in [./.config/directories](./.config/directories)
- [.scripts/bin](.scripts/bin) - generic scripts
    - media related, [duration](https://github.com/seanbreckenridge/dotfiles/blob/master/.scripts/bin/duration) to get media length, [gifme](https://github.com/seanbreckenridge/dotfiles/blob/master/.scripts/bin/duration) to convert video to gifs.
    - [gitopen](https://github.com/seanbreckenridge/dotfiles/blob/master/.scripts/bin/gitopen) to open current git directory in browser
    - [qr](https://github.com/seanbreckenridge/dotfiles/blob/master/.scripts/bin/qr) - create a QR code from a string and display it full screen
- [.scripts/system](.scripts/system) - i3 related scripts
- [fzf](https://github.com/junegunn/fzf) **everywhere** - in [ranger](https://github.com/seanbreckenridge/dotfiles/blob/f5d82fffc43ff46fbbe98a7bc3bdaa1a277ddc9e/.config/ranger/commands.py#L15-L45), to search `cwd` recursively and jump to directories (`Alt+C`), to edit files (`Mod+w e`), to kill processes (`Mod+w k`), to [edit config files](https://github.com/seanbreckenridge/dotfiles/blob/f5d82fffc43ff46fbbe98a7bc3bdaa1a277ddc9e/.config/shortcuts.toml#L7-L10) (`Mod+w c`), and to [search the entire system](https://github.com/seanbreckenridge/dotfiles/blob/master/.config/zsh/functions/flocate). [Mode in i3](https://github.com/seanbreckenridge/dotfiles/blob/6e73de090b9c5e8265385a4ed450b7aa9d33169a/.config/i3/config#L220-L231) to [launch](https://github.com/seanbreckenridge/dotfiles/blob/master/.scripts/bin/launch) terminals with formerly mentioned commands, and in [`vim`](https://github.com/seanbreckenridge/dotfiles/blob/master/.config/nvim/init.vim) to match against lines/files/commands/buffers.

### Install

    yadm clone https://github.com/seanbreckenridge/dotfiles
    yadm bootstrap

#### LICENSE

Unless where attributed, any customization and scripts are licensed under the MIT License:

```
MIT License

Copyright (c) 2019-20 Sean Breckenridge

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
```
