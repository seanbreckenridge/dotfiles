# load modules that I use in testing things automatically
import os

if "PIPENV_ACTIVE" not in os.environ:
    import json  # noqa
    import tempfile  # noqa
    from pathlib import Path  # noqa
    from datetime import datetime, timedelta, timezone  # noqa
    from collections import Counter  # noqa
    from glob import glob  # noqa
    from pprint import pprint  # noqa
    from itertools import chain  # noqa
    from more_itertools import ilen, last  # noqa
