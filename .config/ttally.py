# This defines some models for things I want to log often
# which then generate into TUIs using:
# https://github.com/seanbreckenridge/ttally

from datetime import datetime
from typing import NamedTuple, Optional


class Shower(NamedTuple):
    when: datetime


class Weight(NamedTuple):
    when: datetime
    pounds: float


# this also tracks water, either by attaching it
# to the corresponding food, or by just adding
# something with the text 'water'
class Food(NamedTuple):
    when: datetime
    calories: int
    food: str
    quantity: float
    water: int  # ml

    # if I don't supply a quantity, default to 1
    @staticmethod
    def attr_validators() -> dict:
        # https://sean.fish/d/ttally_types.py?dark
        from seanb.ttally_types import prompt_float_default

        return {"quantity": lambda: prompt_float_default("quantity")}


# e.g. a concert or something
class Event(NamedTuple):
    event_type: str
    when: datetime
    description: str
    score: int | None
    comments: str | None

    @staticmethod
    def attr_validators() -> dict:
        # https://sean.fish/d/ttally_types.py?dark
        from seanb.ttally_types import edit_in_vim

        return {"comments": edit_in_vim}
