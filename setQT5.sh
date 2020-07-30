#!/bin/bash

cd /home/deploy/qt5
X1=$(git rev-parse --abbrev-ref HEAD)
if [[ $# -eq 0 ]]; then
    echo -e "No parameters found. "
    exit 1
fi
if [[ $1 -ne $X1 ]] then
	git checkout $1
	perl init-repository -f --branch
fi



