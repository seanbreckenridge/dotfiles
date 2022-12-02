# dotfiles

I have a separate repository [`seanb-core`](https://github.com/seanbreckenridge/seanb-core) I sync scripts up to make them easier to install -- this repository is more application configuration and very personal scripts

This was originally linux-only, but over the months and years I've added a compatability layer of sorts; A global `ON_OS` variable which uses [on_machine](https://github.com/seanbreckenridge/on_machine) to figure out which machine/operating system I'm on. (`linux_arch`, `mac`, `android` ([termux](https://termux.com/)) or `windows` (WSL)) is set on X server/terminal launch. The bootstrap scripts in [`.config/yadm`](.config/yadm) dispatch against that to install different packages

In general:

- [`zsh`](http://zsh.sourceforge.net/), plugins/configuration handled manually in [`.config/zsh`](.config/zsh) (split across multiple files)
- [`yadm`](https://yadm.io) to manage dotfiles, see [`yadm-with-README.md`](.config/yadm/yadm-with-README.md)
- [`kitty`](https://github.com/kovidgoyal/kitty) as terminal, [`alacritty`](https://github.com/alacritty/alacritty) on windows
- [`firefox-developer-edition`](https://www.archlinux.org/packages/community/x86_64/firefox-developer-edition/) - browser, addons listed in [`firefox_addons.txt`](./.local/share/firefox_addons.txt)
- [`neomutt`](https://github.com/neomutt/neomutt) for email
- [`nvim`](https://neovim.io/) (with [`nvim-cmp`](https://github.com/hrsh7th/nvim-cmp)) and rarely [`(doom) emacs`](https://github.com/hlissner/doom-emacs) as editors - see [`editor`](.local/scripts/cross-platform/editor)
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

- [.local/scripts/supervisor_jobs](.local/scripts/supervisor_jobs/) has jobs using [`supervisor`](https://github.com/Supervisor/supervisor) to daemonize, so I dont have to write plists or systemd scripts, and background processes work mac, linux, windows and android. That uses [`bgproc`](https://github.com/seanbreckenridge/bgproc) as an anacron replacement, and [`on_machine`](https://github.com/seanbreckenridge/on_machine) to figure out which jobs to run on each system/distribution
- [`ttt`](https://github.com/seanbreckenridge/ttt/) is sprinkled throughout lots of my scripts, it acts as an extension to my shell history, saving commands from `i3` `bindsym`s, or `ranger` commands. [Lets me `cd`](.config/zsh/cd.zsh) to one of those directories quickly using `fzf`
- [.config/yadm](.config/yadm) includes lists of global packages to install for pacman/apt/brew, python, ruby, npm, dart, rust, go, elixir and bash
- [.config/shortcuts.toml](.config/shortcuts.toml) - describes basic shell scripts that are created by [shortcuts](https://github.com/seanbreckenridge/shortcuts)
- [.local/scripts/generic](.local/scripts/generic) - lots of my scripts; e.g.
  - media related, [mduration](.local/scripts/generic/mduration) to get media length, [gifme](.local/scripts/generic/gifme) to convert video to gifs, lots of audio/video format conversion scripts
  - [qr](.local/scripts/generic/qr) - create a QR code from a string and display it full screen
  - [misspell-context](.local/scripts/generic/misspell-context) - finds common spelling mistakes using [misspell](https://github.com/client9/misspell) recursively, prompt me with the words in context so I can correct them

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

Copyright (c) 2019-22 Sean Breckenridge

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
