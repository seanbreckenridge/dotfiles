"""
Used for https://github.com/seanbreckenridge/ttally
"""

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
