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
        # https://sean.fish/d/ttally_types.py?dark
        from seanb.ttally_types import prompt_float_default

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
        # https://sean.fish/d/ttally_types.py?redirect
        from seanb.ttally_types import edit_in_vim

        return {"comments": edit_in_vim}


from seanb.ttally_self import SelfTypes


class Self(NamedTuple):
    when: datetime
    what: SelfTypes
