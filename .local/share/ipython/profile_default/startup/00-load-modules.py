# load modules that I use in testing things automatically
import os

if "PIPENV_ACTIVE" not in os.environ:
    import json
    import tempfile
    from pathlib import Path
    from datetime import datetime, timedelta, timezone
    from collections import Counter
    from glob import glob
    from pprint import pprint
    from itertools import chain
    from more_itertools import ilen, last
