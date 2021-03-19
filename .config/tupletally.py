from datetime import datetime
from typing import NamedTuple

# if you define a datetime on a model, the attribute name should be 'when'


class Shower(NamedTuple):
    when: datetime


class Weight(NamedTuple):
    when: datetime
    pounds: float


class Water(NamedTuple):
    when: datetime
    glasses: float

