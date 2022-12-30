import os
from enum import Enum

self_types_file = os.path.join(os.environ["HPIDATA"], "self_types.txt")
with open(self_types_file, "r") as f:
    self_types = f.read().upper().splitlines()

SelfTypes = Enum("SelfTypes", self_types)
