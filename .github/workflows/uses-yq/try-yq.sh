#!/usr/bin/env bash

script_d="$(dirname "$0")"

file="${script_d}/../uses-yq.yml"

yq '.on' "${file}"
