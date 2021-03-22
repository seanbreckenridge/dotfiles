from datetime import datetime
from typing import NamedTuple


class Shower(NamedTuple):
    when: datetime


class Weight(NamedTuple):
    when: datetime
    pounds: float


class Water(NamedTuple):
    when: datetime
    glasses: float
