import sys
import shlex
import shutil
import subprocess
from typing import List

from Xlib import display as xdisplay


def notify_send(message: str, critical: bool = False) -> None:
    """Helper message to send notifications with notify-send"""
    critical_str = "-u critical" if critical else ""
    subprocess.run(shlex.split('notify-send {} "{}"'.format(critical_str, message)))


def get_num_monitors() -> int:
    num_monitors: int = 0
    try:
        display = xdisplay.Display()
        screen = display.screen()
        resources = screen.root.xrandr_get_screen_resources()

        for output in resources.outputs:
            monitor = display.xrandr_get_output_info(output, resources.config_timestamp)
            preferred = False
            if hasattr(monitor, "preferred"):
                preferred = monitor.preferred
            elif hasattr(monitor, "num_preferred"):
                preferred = monitor.num_preferred
            if preferred:
                num_monitors += 1
    except Exception as e:
        # always setup at least one monitor
        print(f"Error getting screen count: {e}", file=sys.stderr)
        return 1
    else:
        return num_monitors


def get_default_terminal(terminals: List[str]):
    trm, *trx_s = terminals
    if shutil.which(trm) is not None:
        return trm
    if trx_s:  # recursive call
        return get_default_terminal(trx_s)
    else:
        return trm  # return the last element in the list as the default
