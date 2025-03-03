#!/usr/bin/env bash

set -eo pipefail

docker push hanggrian/cimg-multiplatform:openjdk8.0-python3.12
docker push hanggrian/cimg-multiplatform:openjdk8.0-python3.12-node
docker push hanggrian/cimg-multiplatform:openjdk8.0-python3.12-browsers

docker push hanggrian/cimg-multiplatform:openjdk11.0-python3.12
docker push hanggrian/cimg-multiplatform:openjdk11.0-python3.12-node
docker push hanggrian/cimg-multiplatform:openjdk11.0-python3.12-browsers

docker push hanggrian/cimg-multiplatform:openjdk17.0-python3.12
docker push hanggrian/cimg-multiplatform:openjdk17.0-python3.12-node
docker push hanggrian/cimg-multiplatform:openjdk17.0-python3.12-browsers

docker push hanggrian/cimg-multiplatform:openjdk21.0-python3.12
docker push hanggrian/cimg-multiplatform:openjdk21.0-python3.12-node
docker push hanggrian/cimg-multiplatform:openjdk21.0-python3.12-browsers

docker push hanggrian/cimg-multiplatform:openjdk8.0-python3.13
docker push hanggrian/cimg-multiplatform:openjdk8.0-python3.13-node
docker push hanggrian/cimg-multiplatform:openjdk8.0-python3.13-browsers

docker push hanggrian/cimg-multiplatform:openjdk11.0-python3.13
docker push hanggrian/cimg-multiplatform:openjdk11.0-python3.13-node
docker push hanggrian/cimg-multiplatform:openjdk11.0-python3.13-browsers

docker push hanggrian/cimg-multiplatform:openjdk17.0-python3.13
docker push hanggrian/cimg-multiplatform:openjdk17.0-python3.13-node
docker push hanggrian/cimg-multiplatform:openjdk17.0-python3.13-browsers

docker push hanggrian/cimg-multiplatform:openjdk21.0-python3.13
docker push hanggrian/cimg-multiplatform:openjdk21.0-python3.13-node
docker push hanggrian/cimg-multiplatform:openjdk21.0-python3.13-browsers

docker push hanggrian/cimg-multiplatform:android2024.11-python3.12
docker push hanggrian/cimg-multiplatform:android2024.11-python3.12-node
docker push hanggrian/cimg-multiplatform:android2024.11-python3.12-browsers

docker push hanggrian/cimg-multiplatform:android2025.02-python3.12
docker push hanggrian/cimg-multiplatform:android2025.02-python3.12-node
docker push hanggrian/cimg-multiplatform:android2025.02-python3.12-browsers

docker push hanggrian/cimg-multiplatform:android2024.11-python3.13
docker push hanggrian/cimg-multiplatform:android2024.11-python3.13-node
docker push hanggrian/cimg-multiplatform:android2024.11-python3.13-browsers

docker push hanggrian/cimg-multiplatform:android2025.02-python3.13
docker push hanggrian/cimg-multiplatform:android2025.02-python3.13-node
docker push hanggrian/cimg-multiplatform:android2025.02-python3.13-browsers
