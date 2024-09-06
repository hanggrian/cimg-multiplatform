#!/usr/bin/env bash

set -eo pipefail

sudo docker push hanggrian/cimg-multiplatform:android2024-python3
sudo docker push hanggrian/cimg-multiplatform:android2024-python3-browsers
sudo docker push hanggrian/cimg-multiplatform:android2024-python3-node
sudo docker push hanggrian/cimg-multiplatform:openjdk17-python3
sudo docker push hanggrian/cimg-multiplatform:openjdk17-python3-browsers
sudo docker push hanggrian/cimg-multiplatform:openjdk17-python3-node
sudo docker push hanggrian/cimg-multiplatform:openjdk21-python3
sudo docker push hanggrian/cimg-multiplatform:openjdk21-python3-browsers
sudo docker push hanggrian/cimg-multiplatform:openjdk21-python3-node
