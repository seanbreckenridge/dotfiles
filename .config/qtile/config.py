# Copyright information at the bottom of the file
# refrenced:
# https://github.com/qtile/qtile-examples/blob/master/rxcomm/config.py.eee

import os
import sys
import subprocess
from typing import List, Tuple, Any, Mapping, Union

from libqtile.config import (
    Screen,
    Group,
    Drag,
    Click,
    Key as BasicKey,
    EzKey as Key,
    Match,
)
from libqtile.lazy import lazy
from libqtile import layout, bar, widget, hook, extension

from util import get_num_monitors

mod: str = "mod4"  # windows key
alt: str = "mod1"  # alt key
terminal: str = os.environ.get("TERMINAL", "urxvt")

# Keysym List:
# https://github.com/qtile/qtile/blob/master/libqtile/xkeysyms.py
keys: List[Key] = [
    # layout specific
    # for MonadTall
    Key("M-h", lazy.layout.left(), desc="move focus to left window"),
    Key("M-l", lazy.layout.right(), desc="move focus to right window"),
    Key("M-j", lazy.layout.down(), desc="cycle down focus on window stack"),
    Key("M-k", lazy.layout.up(), desc="cycle up focus on window stack"),
    Key("M-S-h", lazy.layout.shuffle_left(), desc="swap window to left"),
    Key("M-S-l", lazy.layout.shuffle_right(), desc="swap window to right"),
    Key("M-S-j", lazy.layout.shuffle_down(), desc="swap window down on stack"),
    Key("M-S-k", lazy.layout.shuffle_up(), desc="swap window up on stack"),
    Key("M-i", lazy.layout.grow(), desc="increase size of window"),
    Key("M-m", lazy.layout.shrink(), desc="decrease size of window"),
    Key("M-n", lazy.layout.normalize(), desc="reset size of windows"),
    Key(
        "M-o",
        lazy.layout.maximize(),
        desc="increase currently focused window to close to max",
    ),
    Key("M-S-<space>", lazy.layout.flip(), desc="flip layout stacks"),
    # bindings for Column layout - i3 like
    Key(
        "M-S-z",
        lazy.layout.toggle_split(),
        desc="toggle between splitting and stacking",
    ),
    # control size of windows in column mode
    Key("M-S-u", lazy.layout.grow_down(), desc="grow window downwards"),
    Key("M-S-i", lazy.layout.grow_up(), desc="grow window upwards"),
    Key("M-S-y", lazy.layout.grow_left(), desc="grow window left-wards"),
    Key("M-S-o", lazy.layout.grow_right(), desc="grow window towards right-wards"),
    # window (floating/fullscreen)
    Key(
        "M-S-f",
        lazy.window.toggle_floating(),
        desc="toggle currently focused window as floating",
    ),
    Key(
        "M-f",
        lazy.window.toggle_fullscreen(),
        desc="toggle fullscreen on currently focused window",
    ),
    # run commands
    Key("M-<Return>", lazy.spawn(terminal), desc="open a terminal"),
    Key("M-r", lazy.spawn('rofi -show run -display-run "run > "'), desc="run prompt"),
    Key(
        "M-<Tab>",
        lazy.spawn('rofi -show window -display-window "window > "'),
        desc="swap to window prompt",
    ),
    Key(
            "M-d",
            lazy.spawn("datenow"),
            desc="prompt to select a date format and copy to clipboard"
    ),
    Key(
            "M-S-d",
            lazy.spawn("mediasearch"),
            desc="search for media on letterboxd/trakt",
    ),
    Key(
        "<XF86Display>",
        lazy.spawn("randomize-wallpaper"),
        desc="randomize current wallpaper",
    ),
    Key("M-S-<Escape>", lazy.spawn("lock-screen"), desc="lock the screen"),
    Key("M-S-w", lazy.spawn("wfi"), desc="wait till I have internet connection and notify me"),
    Key("M-S-b", lazy.spawn("wfib"), desc="wait till I have internet connection and reload focused firefox browser"),
    Key(
        "<XF86MonBrightnessUp>",
        lazy.spawn("brightness up"),
        desc="increase screen brightness",
    ),
    Key(
        "<XF86MonBrightnessDown>",
        lazy.spawn("brightness down"),
        desc="decrease screen brightness",
    ),
    Key(
        "<XF86AudioRaiseVolume>", lazy.spawn("volume up"), desc="increase system volume"
    ),
    Key(
        "<XF86AudioLowerVolume>",
        lazy.spawn("volume down"),
        desc="decrease system volume",
    ),
    Key("<XF86AudioMute>", lazy.spawn("volume mute"), desc="mute system volume"),
    Key("<XF86AudioMicMute>", lazy.spawn("volume micmute"), desc="mute the mic"),
    Key(
        "M-S-e",
        lazy.spawn(f"{terminal} -e refresh-doom"),
        desc="refresh doom bindings/packages and the emacs daemon",
    ),
    Key(
        "<Print>",
        lazy.spawn("screenshot"),
        desc="changes cursor to select a region to take a screenshot",
    ),
    Key(
        "S-<Print>",
        lazy.spawn("screenshot -f"),
        desc="take a screenshot of the entire screen",
    ),
    Key(
        "M-<Print>",
        lazy.spawn("screenshot-to-imgur"),
        desc="uploads most recent screenshot to imgur",
    ),
    # todo management
    Key(
        "M-t",
        lazy.spawn("todo-prompt"),
        desc="rofi interface to mark todos as complete",
    ),
    Key(
        "M-S-t",
        lazy.spawn('alacritty -e sh -c "full_todotxt $HOME/.config/todo/todo.txt"'),
        desc="Interactive terminal interface to create todos",
    ),
    Key("M-g", lazy.spawn("trackpad toggle"), desc="turns the trackpad on/off"),
    Key(
        "M-x",
        lazy.spawn('''alacritty -e sh -c "xmodmap ~/.Xmodmap"'''),
        desc="fix keybinds, for when I plug in my external keyboard",
    ),
    # for switching to different monitors
    BasicKey(
        ["control", alt], "1", lazy.to_screen(0), desc="Keyboard focus to monitor 1"
    ),
    BasicKey(
        ["control", alt], "2", lazy.to_screen(1), desc="Keyboard focus to monitor 2"
    ),
    # general qtile commands
    Key("M-S-<Tab>", lazy.next_layout(), desc="swap to next qtile layout"),
    Key("M-q", lazy.window.kill(), desc="kill the current window"),
    Key("M-S-r", lazy.restart(), desc="restart qtile in place"),
]


def generate_keybind(
    binding: Union[str, Tuple[str, str]], launch_terminal: bool = False
) -> Key:
    """
    Given an application name or a binding ('h', 'htop') describing how to launch an application,
    returns the corresponding qtile Keybind
    """
    # binding like, ('v', 'keyvol'), to bind keyvol to Mod+Ctrl+v
    if isinstance(binding, tuple):
        launch_key, application = binding
    # application name, uses the first letter as the launch binding
    elif isinstance(binding, str):
        launch_key = binding[0]
        application = binding
    else:
        return print(
            f"Expected a binding (an application 'str' or a 'tuple' describing a binding, found {type(binding)}",
            file=sys.stderr,
        )

    # use 'launch' to launch a terminal if this has a TUI
    if launch_terminal:
        description = f"launch {application} in a new terminal"
        application = f"launch {application}"
    else:
        description = f"launch {application}"

    return Key(f"M-C-{launch_key}", lazy.spawn(application), desc=description)


# application launcher
applications: List[Union[str, Tuple[str, str]]] = [
    "thunderbird",
    "emacs",
    "keepassxc",
    "discord",
    "slack",
    "firefox-developer-edition",
    "alacritty",
    ("m", "stream-link")
]
terminal_applications: List[Union[str, Tuple[str, str]]] = [
    "ranger",
    ("v", "keyvol"),
    "htop",
]

# launch applications with Mod+Ctrl+<>
keys.extend([generate_keybind(app) for app in applications])
keys.extend(
    [
        generate_keybind(termapp, launch_terminal=True)
        for termapp in terminal_applications
    ]
)
keys.append(
    Key(
        "M-C-<Tab>",
        lazy.spawn("qtile-notify-bindings"),
        desc="Send a notification with bindings for launching applications",
    )
)

groups: List[Group] = [
    Group("1"),
    Group("2"),
    Group("3"),
    Group("4"),
    Group("5"),
    Group("6"),
    Group("7"),
    Group("8", matches=[Match(wm_class=["slack", "Slack"])]),
    Group("9", matches=[Match(wm_class=["Thunderbird", "Mail"])]),
]

for i, g in enumerate(groups, 1):
    keys.extend(
        [
            # mod1 + group number = switch to group
            BasicKey(
                [mod],
                str(i),
                lazy.group[g.name].toscreen(),
                desc=f"switch to group {i}",
            ),
            # mod1 + shift + group number = move focused window to group
            BasicKey(
                [mod, "shift"],
                str(i),
                lazy.window.togroup(g.name),
                desc=f"move focused window to group {i}",
            ),
        ]
    )

layout_theme: Mapping[str, Any] = {
    "border_width": 2,
    "margin": 3,
    "border_focus": "e1acff",
    "border_normal": "282a36",
}

layouts = [
    layout.MonadTall(**layout_theme),
    layout.Columns(**layout_theme, num_columns=2, insert_position=1),
    layout.Max(),
]

widget_defaults = dict(font="Source Code Pro", fontsize=12, padding=3,)
extension_defaults = widget_defaults.copy()


# shared bar for all screens
def init_bar():
    return bar.Bar(
        [
            widget.GroupBox(),
            widget.Prompt(),
            widget.WindowName(),
            widget.CurrentLayoutIcon(scale=0.6),
            widget.CurrentLayout(),
            widget.sep.Sep(padding=5),
            widget.TextBox("CPU:"),
            widget.CPUGraph(update_interval=3),
            widget.sep.Sep(padding=5),
            widget.TextBox("BAT:"),
            widget.Battery(),
            widget.sep.Sep(padding=5),
            widget.Wlan(interface="wlp4s0", update_interval=5, format="{essid}"),
            widget.sep.Sep(padding=5),
            widget.Clock(format="%b %d (%a) %I:%M%p", update_interval=5.0),
            widget.sep.Sep(padding=5),
            widget.Systray(),
        ],
        30,
    )


screens = [Screen(top=init_bar()) for _ in range(get_num_monitors())]

# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None
follow_mouse_focus = True
bring_front_click = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[{"wmclass": "dragon-drag-and-drop"}, {"wmclass": "megasync"}]
)
auto_fullscreen = True
focus_on_window_activation = "smart"


@hook.subscribe.startup_once
def autostart():
    autostart_script = os.path.join(os.path.dirname(__file__), "autostart.sh")
    subprocess.call([autostart_script])


@hook.subscribe.screen_change
def restart_on_randr(qtile, ev):
    subprocess.call(["autorandr", "-c"])
    qtile.cmd_restart()

# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
