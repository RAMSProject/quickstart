#!/bin/bash
CWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

docker run --name uberapp -p 8282:8282 -v "$CWD/dev:/mnt/dev" -it magfest/uber $1
