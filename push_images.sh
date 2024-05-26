#!/usr/bin/env bash

set -eo pipefail

sudo docker push hendraanggrian/cimg-multiplatform:node22-openjdk8-python3
sudo docker push hendraanggrian/cimg-multiplatform:openjdk8-python3
