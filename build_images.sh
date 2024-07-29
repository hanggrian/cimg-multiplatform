#!/usr/bin/env bash

set -eo pipefail
sudo docker build -t hanggrian/cimg-multiplatform:node22-python3 node22-python3
sudo docker build -t hanggrian/cimg-multiplatform:openjdk8-node22 openjdk8-node22
sudo docker build -t hanggrian/cimg-multiplatform:openjdk8-python3 openjdk8-python3
sudo docker build -t hanggrian/cimg-multiplatform:openjdk8-node22-python3 openjdk8-node22-python3
sudo docker build -t hanggrian/cimg-multiplatform:openjdk11-node22 openjdk11-node22
sudo docker build -t hanggrian/cimg-multiplatform:openjdk11-python3 openjdk11-python3
sudo docker build -t hanggrian/cimg-multiplatform:openjdk11-node22-python3 openjdk11-node22-python3
sudo docker build -t hanggrian/cimg-multiplatform:openjdk17-node22 openjdk17-node22
sudo docker build -t hanggrian/cimg-multiplatform:openjdk17-python3 openjdk17-python3
sudo docker build -t hanggrian/cimg-multiplatform:openjdk17-node22-python3 openjdk17-node22-python3
