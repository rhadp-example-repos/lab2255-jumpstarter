#!/bin/bash

set -e

source jumpstarter/.venv/bin/activate

jmp admin create exporter outpost-mock -l shadowcar/board mock --save --out ./outpost-mock-exporter.yaml

jmp admin create client outpost-mock --save --unsafe