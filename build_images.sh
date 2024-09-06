#!/usr/bin/env bash

set -eo pipefail

sudo docker build -t hanggrian/cimg-multiplatform:android2024-python3 android2024-python3
sudo docker build -t hanggrian/cimg-multiplatform:android2024-python3-browsers android2024-python3-browsers
sudo docker build -t hanggrian/cimg-multiplatform:android2024-python3-node android2024-python3-node
sudo docker build -t hanggrian/cimg-multiplatform:openjdk17-python3 openjdk17-python3
sudo docker build -t hanggrian/cimg-multiplatform:openjdk17-python3-browsers openjdk17-python3-browsers
sudo docker build -t hanggrian/cimg-multiplatform:openjdk17-python3-node openjdk17-python3-node
sudo docker build -t hanggrian/cimg-multiplatform:openjdk21-python3 openjdk21-python3
sudo docker build -t hanggrian/cimg-multiplatform:openjdk21-python3-browsers openjdk21-python3-browsers
sudo docker build -t hanggrian/cimg-multiplatform:openjdk21-python3-node openjdk21-python3-node
