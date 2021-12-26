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
        from seanb.ttally_types import prompt_float_default

        return {"quantity": lambda: prompt_float_default("quantity")}


def edit_in_vim() -> Optional[str]:
    import click

    m = click.edit(text=None, editor="nvim")
    return m if m is None else m.strip()


class Event(NamedTuple):
    event_type: str
    when: datetime
    description: str
    score: Optional[int]
    comments: Optional[str]

    @staticmethod
    def attr_validators() -> dict:
        return {"comments": edit_in_vim}
