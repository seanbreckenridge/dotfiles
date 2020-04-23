#!/usr/bin/python3
"""
This is a pretty personal script, it uses my dev environment
requires:
python packages:
    httpx
    toml
commands:
    notify-send
    wait-for-internet (https://github.com/seanbreckenridge/wait-for-internet)

Waits till I have an internet connection, and then
checks whether the the server and the correct
amount of processes are running (and dont seem to be
stuck restarting)

Expects a toml file at $ZDOTDIR/secrets that contains:

FOREVER_LIST_TOKEN # token to communicate with the HTTP server
FOREVER_LIST_COUNT # number of expected running processes
"""

import os
import time
import json

from typing import Tuple, Optional

import httpx
import toml

from util import notify_send

# modified from https://github.com/seanbreckenridge/foreverjs-list

conf = toml.load(
    open(os.path.join(os.environ["HOME"], ".config/zsh/secrets"), "r"))


def monitor_server() -> Tuple[Optional[int], Optional[str]]:

    #  does what it sounds like
    os.system("wait-for-internet >/dev/null")

    # make the request to the API
    resp = httpx.get(
        "https://seanbr.com/forever-list/",
        headers={"token": conf["FOREVER_LIST_TOKEN"]},
    )

    # if we couldnt connect to the remote api, notify me
    # this also checks for 403 HTTP errors (wrong token)
    try:
        resp.raise_for_status()
    except httpx._exceptions.HTTPError as http_error:
        return (None, str(http_error))

    try:
        resp_json = resp.json()
    except json.decoder.JSONDecodeError:
        return (None, "Issue parsing response as JSON")

    actual_process_count = len(resp_json)

    # make sure the expected number of forever processes are running
    if actual_process_count != conf["FOREVER_LIST_COUNT"]:
        return (
            actual_process_count,
            f"Expected to find {conf['FOREVER_LIST_COUNT']} processes, found {actual_process_count}",
        )

    # make sure all returned processes are running
    for proc in resp_json:
        # explicity not running
        if not proc["running"]:
            return (actual_process_count,
                    "{} is not running".format(proc["uid"]))
        # if it was started recently and has more than one restart, warn me
        if (time.time() -
            (proc["ctime"] / 1000) < 60 * 10) and proc["restarts"] > 0:
            return (
                actual_process_count,
                "Warning: {} was restarted in the last few minutes and has restarted {} times, could signify crashed process"
                .format(proc["uid"], proc["restarts"]),
            )

    return (int(conf["FOREVER_LIST_COUNT"]), None)


def monitor_widget() -> str:
    proc_count, error_message = monitor_server()
    if error_message is not None:
        notify_send("VPS\n" + error_message)
    return f"VPS: {proc_count or ''}"


if __name__ == "__main__":
    print(monitor_widget())
