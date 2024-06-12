#!/bin/bash

if [[ $# < 1 ]]; then
    echo "Destination path is missing" >&2
    echo "Usage: install-scripts.sh DESTINATIONPATH"
    exit 1
fi

cp -R ./scripts/*.sh $1