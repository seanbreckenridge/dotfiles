# This defines some models for things I want to log often
# which then generate into TUIs using:
# https://github.com/seanbreckenridge/ttally

from datetime import datetime
from typing import NamedTuple
from functools import lru_cache

# behind a func and cached so this doesn't
# take ages to import when its not needed
#
# this defines a prompt which returns an float
# but also has a default value, so I can just hit
# enter and speed through prompts with common value
@lru_cache(maxsize=1)
def return_prompt_float_default():
    from autotui.prompts import create_repl_prompt_str
    from prompt_toolkit import prompt
    from prompt_toolkit.validation import Validator, Document, ValidationError

    class FloatValidatorAcceptEmpty(Validator):
        def validate(self, document: Document) -> None:
            text = document.text
            try:
                float(text)
            except ValueError as ve:
                # allow nothing to pass, means 'default' to whatever
                if text.strip() == "":
                    pass
                else:
                    raise ValidationError(message=str(ve))

    def prompt_float_default(attr: str, default: float = 1.0) -> float:
        m: str = create_repl_prompt_str(f"{attr} (default {default})")
        resp = prompt(m, validator=FloatValidatorAcceptEmpty())
        if resp.strip() == "":
            return default
        else:
            return float(resp)

    return prompt_float_default


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
        return {"quantity": lambda: return_prompt_float_default()("quantity")}
