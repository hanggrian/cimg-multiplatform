#!/usr/bin/env bash

set -eo pipefail

sudo docker push hanggrian/cimg-multiplatform:node22-python3
sudo docker push hanggrian/cimg-multiplatform:openjdk8-node22
sudo docker push hanggrian/cimg-multiplatform:openjdk8-python3
sudo docker push hanggrian/cimg-multiplatform:openjdk8-node22-python3
sudo docker push hanggrian/cimg-multiplatform:openjdk11-node22
sudo docker push hanggrian/cimg-multiplatform:openjdk11-python3
sudo docker push hanggrian/cimg-multiplatform:openjdk11-node22-python3
sudo docker push hanggrian/cimg-multiplatform:openjdk17-node22
sudo docker push hanggrian/cimg-multiplatform:openjdk17-python3
sudo docker push hanggrian/cimg-multiplatform:openjdk17-node22-python3
