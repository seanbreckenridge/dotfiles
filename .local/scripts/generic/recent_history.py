#!/usr/bin/env python3

"""
Copy, open and print url/metadata from
the current firefox database

Used with the recent_history script
"""

import json
from browserexport.browsers.firefox import Firefox
from browserexport.parse import read_visits
from my.core.sqlite import sqlite_copy_and_open
from more_itertools import unique_everseen

conn = sqlite_copy_and_open(Firefox.locate_database())
for visit in unique_everseen(read_visits(conn), key=lambda v: v.url):
    print(
        json.dumps(
            {"url": visit.url, "metadata": getattr(visit.metadata, "description", "")}
        )
    )
