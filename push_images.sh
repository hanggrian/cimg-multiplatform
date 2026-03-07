#!/usr/bin/env bash

set -eo pipefail

docker push hanggrian/cimg-multiplatform:openjdk17.0-python3.13
docker push hanggrian/cimg-multiplatform:openjdk17.0-python3.13-node
docker push hanggrian/cimg-multiplatform:openjdk17.0-python3.13-browsers

docker push hanggrian/cimg-multiplatform:openjdk21.0-python3.13
docker push hanggrian/cimg-multiplatform:openjdk21.0-python3.13-node
docker push hanggrian/cimg-multiplatform:openjdk21.0-python3.13-browsers

docker push hanggrian/cimg-multiplatform:openjdk25.0-python3.13
docker push hanggrian/cimg-multiplatform:openjdk25.0-python3.13-node
docker push hanggrian/cimg-multiplatform:openjdk25.0-python3.13-browsers

docker push hanggrian/cimg-multiplatform:openjdk17.0-python3.14
docker push hanggrian/cimg-multiplatform:openjdk17.0-python3.14-node
docker push hanggrian/cimg-multiplatform:openjdk17.0-python3.14-browsers

docker push hanggrian/cimg-multiplatform:openjdk21.0-python3.14
docker push hanggrian/cimg-multiplatform:openjdk21.0-python3.14-node
docker push hanggrian/cimg-multiplatform:openjdk21.0-python3.14-browsers

docker push hanggrian/cimg-multiplatform:openjdk25.0-python3.14
docker push hanggrian/cimg-multiplatform:openjdk25.0-python3.14-node
docker push hanggrian/cimg-multiplatform:openjdk25.0-python3.14-browsers

docker push hanggrian/cimg-multiplatform:android2024.04-python3.13
docker push hanggrian/cimg-multiplatform:android2024.04-python3.13-node
docker push hanggrian/cimg-multiplatform:android2024.04-python3.13-browsers

docker push hanggrian/cimg-multiplatform:android2025.03-python3.13
docker push hanggrian/cimg-multiplatform:android2025.03-python3.13-node
docker push hanggrian/cimg-multiplatform:android2025.03-python3.13-browsers

docker push hanggrian/cimg-multiplatform:android2026.03-python3.13
docker push hanggrian/cimg-multiplatform:android2026.03-python3.13-node
docker push hanggrian/cimg-multiplatform:android2026.03-python3.13-browsers

docker push hanggrian/cimg-multiplatform:android2024.04-python3.14
docker push hanggrian/cimg-multiplatform:android2024.04-python3.14-node
docker push hanggrian/cimg-multiplatform:android2024.04-python3.14-browsers

docker push hanggrian/cimg-multiplatform:android2025.03-python3.14
docker push hanggrian/cimg-multiplatform:android2025.03-python3.14-node
docker push hanggrian/cimg-multiplatform:android2025.03-python3.14-browsers

docker push hanggrian/cimg-multiplatform:android2026.03-python3.14
docker push hanggrian/cimg-multiplatform:android2026.03-python3.14-node
docker push hanggrian/cimg-multiplatform:android2026.03-python3.14-browsers

