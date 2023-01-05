# https://github.com/seanbreckenridge/ttally

from datetime import datetime
from typing import NamedTuple, Optional


class Weight(NamedTuple):
    when: datetime
    pounds: float


class Food(NamedTuple):
    when: datetime
    calories: int
    food: str
    quantity: float
    water: int  # how much ml of water was in this

    @staticmethod
    def attr_validators() -> dict:
        # https://sean.fish/d/ttally_types.py?redirect
        from my.config.seanb.ttally_types import prompt_float_default  # type: ignore

        # if I don't supply a quantity, default to 1
        return {"quantity": lambda: prompt_float_default("quantity")}


class Event(NamedTuple):
    """e.g. a concert or something"""

    event_type: str
    when: datetime
    description: str
    score: Optional[int]
    comments: Optional[str]

    @staticmethod
    def attr_validators() -> dict:
        from my.config.seanb.ttally_types import edit_in_vim  # type: ignore

        return {"comments": edit_in_vim}


import os
from enum import Enum


SelfTypes = Enum(
    "SelfTypes",
    [
        s.rstrip().upper()
        for s in open(os.path.join(os.environ["HPIDATA"], "self_types.txt"))
    ],
)


class Self(NamedTuple):
    when: datetime
    what: SelfTypes  # type: ignore
