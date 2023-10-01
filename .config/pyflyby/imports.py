# flake8: noqa
# this lists a bunch of imports as 'patterns' that pyflyby can use to
# automatically import things
from collections import Counter, defaultdict
from pathlib import Path
from datetime import datetime, timedelta, timezone
from glob import glob
from pprint import pprint
from itertools import chain, combinations, groupby, islice, product
from more_itertools import (
    ilen,
    last,
    first,
    nth,
    take,
    seekable,
    tail,
    unique_everseen,
    unique_justseen,
)
from functools import partial, reduce
from operator import itemgetter, attrgetter, methodcaller
from typing import (
    Any,
    Callable,
    Dict,
    Iterable,
    Iterator,
    List,
    Optional,
    Sequence,
    Set,
    Tuple,
    TypeVar,
    Union,
    cast,
)
from urllib.parse import (
    urlparse,
    urljoin,
    parse_qs,
    urlencode,
    quote,
    unquote,
    urlsplit,
    urlunsplit,
    urlunparse,
)

import os
import sys
import re
import json
import csv
import math
import random
import time
import logging
import logging.config
import logging.handlers

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import scipy.stats as stats

from bs4 import BeautifulSoup, Tag, NavigableString, Comment, Doctype
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.wait import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

from tqdm import tqdm, trange
from tqdm.contrib.concurrent import process_map, thread_map

from PIL import Image
from PIL.ExifTags import TAGS, GPSTAGS
