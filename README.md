# dotfiles

This was originally linux-only, but over the months and years I've added a compatability layer of sorts; [A global `ON_OS` variable](.profile) which has the current operating system (`linux`, `mac`, `android` (termux) or `windows` (WSL)) is set on X server/terminal launch. Lots of my scripts in [`cross-platform`](.local/scripts/cross-platform) and the bootstrap scripts in [`.config/yadm`](.config/yadm) dispatch against that to provide different functionality, e.g. [send notifications](.local/scripts/cross-platform/notify), [pick an item from a list](.local/scripts/cross-platform/picker) (dmenu/rofi-like), [prompt user for input](.local/scripts/cross-platform/input-dialog) etc...

I don't expect anyone to use this directly as its so personal, but hopefully you can pick and choose scripts and configuration that interests you for your own dotfiles

In general:

- [`zsh`](http://zsh.sourceforge.net/), plugins/configuration handled manually in [`.config/zsh`](.config/zsh) (split across multiple files)
- [`yadm`](https://yadm.io) to manage dotfiles, see [`yadm-with-README.md`](.config/yadm/yadm-with-README.md)
- [`alacritty`](https://github.com/alacritty/alacritty) as terminal (with [`tmux`](https://github.com/tmux/tmux))
- [`firefox-developer-edition`](https://www.archlinux.org/packages/community/x86_64/firefox-developer-edition/) - browser, addons listed in [`firefox_addons.txt`](./.local/share/firefox_addons.txt)
- [`neomutt`](https://github.com/neomutt/neomutt) for email
- [`nvim`](https://neovim.io/) (with [`coc`](https://github.com/neoclide/coc.nvim)) and sometimes [`(doom) emacs`](https://github.com/hlissner/doom-emacs) (when I want IDE-like support) as editors - see [`editor`](.local/scripts/cross-platform/editor)
- [`todotxt`](http://todotxt.org/) for todos, with a [`rofi-interface`](.local/scripts/generic/todo-prompt) as GUI
- [`ranger`](https://github.com/ranger/ranger) - terminal file manager, with a few [custom commands](.config/ranger/commands.py) to integrate [`fzf`](https://github.com/junegunn/fzf), lots of [additional bindings](.config/ranger/rc.conf)/an [extensive preview script](.config/ranger/scope.sh), a [shell function](https://sean.fish/d/functions/ranger?dark) so `cd`ing in ranger changes my shell directory

I use [`syncthing`](https://github.com/syncthing/syncthing) to sync my files/data across my computers.

On Arch:

- [`i3-gaps`](https://github.com/Airblader/i3) - window manager; [config file](.config/i3/config) - [`i3-notify-launcher`](https://sean.fish/d/i3-notify-launcher?dark) reminds me of [my bindings for my launcher mode](https://i.imgur.com/m6q3L37.png)
- [`rofi`](https://github.com/davatorium/rofi) - application launcher
- [`i3lock`](https://i3wm.org/i3lock/) for screen lock; [`daemon process`](.local/scripts/cross-platform/lock-screen) caches pixelated version of screen to speed up start time
- [`dunst`](https://dunst-project.org/) for notifications
- [`picom`](https://github.com/yshui/picom) for window compositing
- [`i3blocks`](https://github.com/vivien/i3blocks) as a status bar

On Mac:

- Uses [`skhd`](https://github.com/koekeishiya/skhd) as a hot-key daemon to run applications (e.g. `cmd + opt + enter` launches terminal)
- [`alfred`](https://www.alfredapp.com/) as a application launcher

On Android (using [Termux](https://termux.com/)):

Not a ton of application-specific setup yet, handles setting up `zsh`, installs all my packages using `apt`; see [`android_bootstrap`](./.config/yadm/android_bootstrap)

On Windows (in WSL):

Similar to Termux, does an `apt`-based install. Installs a bunch of languages/programs manually if since the versions on `apt` are ancient. Should install `yadm` manually, using:

`sh <(curl -sSL http://git.io/sinister) -u 'https://github.com/TheLocehiliosan/yadm/raw/master/yadm'`

---

* [.local/scripts/supervisor](.local/scripts/supervisor) has scripts/a config file for [`supervisor`](https://github.com/Supervisor/supervisor), so I dont have to write plists or systemd scripts, and background processes work on both mac and linux. That uses [`bgproc`](https://github.com/seanbreckenridge/bgproc) as an anacron replacement.
* [`ttt`](https://github.com/seanbreckenridge/ttt/) is sprinkled throughout lots of my scripts, it acts as an extension to my shell history, saving commands from `i3` `bindsym`s, or `ranger` commands.
* I typically default to [dracula](https://draculatheme.com/)-like color schemes to keep things consistent. Currently in use for `alacritty` (terminal), `rofi`, `bat`, `firefox` and `emacs`.
* [.config/yadm](.config/yadm) includes lists of global packages for pacman/apt/brew, python, ruby, npm, dart, rust, go, elixir and bash; the zsh [update](.config/zsh/functions/update) function updates all the corresponding packages. Packages can be added to the `.txt` files manually, and then `yadm bootstrap` can be run repeatedly to make sure everything is installed
* [.config/shortcuts.toml](.config/shortcuts.toml) - describes basic shell scripts that are created by [shortcuts](https://github.com/seanbreckenridge/shortcuts)
* [.local/scripts/generic](.local/scripts/generic) - lots of my scripts; e.g.
  * media related, [mduration](.local/scripts/generic/mduration) to get media length, [gifme](.local/scripts/generic/gifme) to convert video to gifs, lots of audio/video format conversion scripts
  * [qr](.local/scripts/generic/qr) - create a QR code from a string and display it full screen
  * [misspell-context](.local/scripts/generic/misspell-context) - finds common spelling mistakes using [misspell](https://github.com/client9/misspell) recursively, prompt me with the words in context so I can correct them

For a summary of tools I use often, see [here](https://exobrain.sean.fish/tools/).

### Install

    # on mac, run `xcode-select --install`
    yadm clone https://gitlab.com/seanbreckenridge/dotfiles
    # restart the computer so that ~/.profile/zsh is setup properly
    # so OS detection can be done to install the correct packages
    yadm bootstrap

#### LICENSE

Unless where attributed, any customization and scripts are licensed under the MIT License:

```
MIT License

Copyright (c) 2019-21 Sean Breckenridge

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
