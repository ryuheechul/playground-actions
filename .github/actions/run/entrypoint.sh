#!/bin/bash -l

echo -n "::set-output name=result::"
bash -c "$1"
