#!/usr/bin/env python3

import shlex
import subprocess


def notify_send(message: str, critical: bool = False):
    """Helper message to send notifications with notify-send"""
    critical_str = "-u critical" if critical else ""
    subprocess.run(shlex.split('notify-send {} "{}"'.format(critical_str, message)))
