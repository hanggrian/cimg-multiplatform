#!/usr/bin/env bash

set -eo pipefail

sudo docker build -t hendraanggrian/cimg-multiplatform:node22-openjdk8-python3 node22-openjdk8-python3
sudo docker build -t hendraanggrian/cimg-multiplatform:openjdk8-python3 openjdk8-python3
