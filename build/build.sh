#!/bin/bash

# master build file, do everything

set -e
. build/include.sh

cd $CWD

./build-base.sh
./build-app.sh
./build-dev.sh
