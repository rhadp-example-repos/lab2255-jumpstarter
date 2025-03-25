#!/bin/bash

set -e

rm .python-version
rm  uv.lock

python -m venv .venv

source .venv/bin/activate

pip install uv

make && make sync