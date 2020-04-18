"""
Copyright (c) 2010 Aldo Cortesi
Copyright (c) 2010, 2014 dequis
Copyright (c) 2012 Randall Ma
Copyright (c) 2012-2014 Tycho Andersen
Copyright (c) 2012 Craig Barnes
Copyright (c) 2013 horsik
Copyright (c) 2013 Tao Sauvage

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
"""

# refrences
# https://github.com/qtile/qtile-examples/blob/master/tych0/config.py
# https://github.com/qtile/qtile-examples/blob/master/sweenu/keys.py
# https://github.com/qtile/qtile/wiki/app-launchers
# https://github.com/qtile/qtile-examples/blob/master/rxcomm/config.py.eee

import os
import subprocess
from typing import List

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
from libqtile import layout, bar, widget, hook

from server_monitor_widget import monitor_widget


mod = "mod4"  # windows key
terminal = os.environ.get("TERMINAL", "urxvt")

# Keysym List:
# https://github.com/qtile/qtile/blob/master/libqtile/xkeysyms.py
keys = [
    # layout specific (MonadTall)
    Key("M-h", lazy.layout.left()),
    Key("M-l", lazy.layout.right()),
    Key("M-j", lazy.layout.down()),
    Key("M-k", lazy.layout.up()),
    Key("M-S-h", lazy.layout.swap_left()),
    Key("M-S-l", lazy.layout.swap_right()),
    Key("M-S-j", lazy.layout.shuffle_down()),
    Key("M-S-k", lazy.layout.shuffle_up()),
    Key("M-i", lazy.layout.grow()),
    Key("M-m", lazy.layout.shrink()),
    Key("M-n", lazy.layout.normalize()),
    Key("M-o", lazy.layout.maximize()),
    Key("M-S-<space>", lazy.layout.flip()),
    # window
    Key("M-S-f", lazy.window.toggle_floating()),
    Key("M-f", lazy.window.toggle_fullscreen()),
    # run commands
    Key("M-<Return>", lazy.spawn(terminal)),
    Key("M-r", lazy.spawn('rofi -show run -display-run "run > "')),
    Key("M-<Tab>", lazy.spawn('rofi -show window -display-window "window > "')),
    Key("<XF86Display>", lazy.spawn("randomize_wallpaper")),
    Key("M-S-<Escape>", lazy.spawn("lock_screen")),
    Key("M-S-w", lazy.spawn("wfi")),
    Key("<XF86MonBrightnessUp>", lazy.spawn("brightness up")),
    Key("<XF86MonBrightnessDown>", lazy.spawn("brightness down")),
    Key("<XF86AudioRaiseVolume>", lazy.spawn("volume up")),
    Key("<XF86AudioLowerVolume>", lazy.spawn("volume down")),
    Key("<XF86AudioMute>", lazy.spawn("volume mute")),
    Key("<XF86AudioMicMute>", lazy.spawn("volume micmute")),
    Key("M-S-e", lazy.spawn(f"{terminal} -e refresh-doom")),
    Key("<Print>", lazy.spawn("screenshot")),
    Key("M-<Print>", lazy.spawn("screenshot-to-imgur")),
    # general qtile commands
    Key("M-S-<Tab>", lazy.next_layout()),
    Key("M-q", lazy.window.kill()),
    Key("M-S-r", lazy.restart()),
]


# application launcher
applications = [
    "thunderbird",
    "emacs",
    "slack",
    "keepassxc",
    "discord",
    "firefox-developer-edition",
]
terminal_applications = [
    "ranger",
    "keyvol",
]
keys.extend([])

groups = [
    Group("1"),
    Group("2"),
    Group("3"),
    Group("4"),
    Group("5"),
    Group("6"),
    Group("7"),
    Group("8", layout="max", matches=[Match(wm_class=["slack", "Slack"])]),
    Group("9", layout="max", matches=[Match(wm_class=["Thunderbird", "Mail"])],),
]

for i, g in enumerate(groups, 1):
    keys.extend(
        [
            # mod1 + group number = switch to group
            BasicKey([mod], str(i), lazy.group[g.name].toscreen()),
            # mod1 + shift + group number = move focused window to group
            BasicKey(
                [mod, "shift"], str(i), lazy.window.togroup(g.name, switch_group=False)
            ),
        ]
    )

layouts = [
    layout.MonadTall(),
    layout.Max(),
]

widget_defaults = dict(font="Source Code Pro", fontsize=12, padding=3,)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(),
                widget.Prompt(),
                widget.WindowName(),
                widget.GenPollText(func=monitor_widget, update_interval=600),
                widget.sep.Sep(padding=5),
                widget.CurrentLayoutIcon(scale=0.6),
                widget.CurrentLayout(),
                widget.sep.Sep(padding=5),
                widget.TextBox("CPU:"),
                widget.CPUGraph(update_interval=3),
                widget.ThermalSensor(update_interval=3),
                widget.sep.Sep(padding=5),
                widget.TextBox("BAT:"),
                widget.Battery(),
                widget.sep.Sep(padding=5),
                widget.Wlan(
                    interface="wlp4s0",
                    update_interval=5,
                    format="{essid}",
                ),
                widget.sep.Sep(padding=5),
                widget.Clock(format="%b %d (%a) %I:%M%p", update_interval=5.0),
                widget.sep.Sep(padding=5),
                widget.Systray(),
            ],
            30,
        ),
    ),
]

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
floating_layout = layout.Floating(float_rules=[{"wmclass": "dragon-drag-and-drop"}])
auto_fullscreen = True
focus_on_window_activation = "smart"


@hook.subscribe.startup_once
def autostart():
    autostart_script = os.path.join(os.path.dirname(__file__), "autostart.sh")
    subprocess.call([autostart_script])
