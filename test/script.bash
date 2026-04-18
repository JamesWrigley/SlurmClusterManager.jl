#!/usr/bin/env bash

set -euf -o pipefail

set -x

pwd

julia --startup-file=no --code-coverage=user script.jl
