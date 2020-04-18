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

from typing import Tuple

import httpx
import toml

from util import notify_send

# for https://github.com/seanbreckenridge/foreverjs-list

conf = toml.load(open(os.path.join(os.environ["HOME"], ".config/zsh/secrets"), "r"))


def monitor_server() -> Tuple[str, str]:

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
        return ("❌", str(http_error))

    try:
        resp_json = resp.json()
    except json.decoder.JSONDecodeError:
        return ("❌", "Issue parsing response as JSON")

    # make sure the expected number of forever processes are running
    if len(resp_json) != conf["FOREVER_LIST_COUNT"]:
        return (
            "❌",
            f"Expected to find {conf['FOREVER_LIST_COUNT']} processes, found {len(resp_json)}",
        )

    # make sure all returned processes are running
    for proc in resp_json:
        # explicity not running
        if not proc["running"]:
            return ("❌", "{} is not running".format(proc["uid"]))
        # if it was started recently and has more than one restart, warn me
        if (time.time() - (proc["ctime"] / 1000) < 60 * 10) and proc["restarts"] > 0:
            return (
                "❌",
                "Warning: {} was restarted in the last few minutes and has restarted {} times, could signify crashed process".format(
                    proc["uid"], proc["restarts"]
                ),
            )

    return ("✅", None)


def monitor_widget() -> str:
    icon, error_message = monitor_server()
    if error_message is not None:
        notify_send(error_message)
    return "🖵" + icon


if __name__ == "__main__":
    print(monitor_widget())
