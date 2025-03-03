#!/usr/bin/env bash

set -eo pipefail

docker build --file openjdk8.0-python3.12/Dockerfile -t hanggrian/cimg-multiplatform:openjdk8.0-python3.12 --platform linux/amd64 .
docker build --file openjdk8.0-python3.12/node/Dockerfile -t hanggrian/cimg-multiplatform:openjdk8.0-python3.12-node --platform linux/amd64 .
docker build --file openjdk8.0-python3.12/browsers/Dockerfile -t hanggrian/cimg-multiplatform:openjdk8.0-python3.12-browsers --platform linux/amd64 .

docker build --file openjdk11.0-python3.12/Dockerfile -t hanggrian/cimg-multiplatform:openjdk11.0-python3.12 --platform linux/amd64 .
docker build --file openjdk11.0-python3.12/node/Dockerfile -t hanggrian/cimg-multiplatform:openjdk11.0-python3.12-node --platform linux/amd64 .
docker build --file openjdk11.0-python3.12/browsers/Dockerfile -t hanggrian/cimg-multiplatform:openjdk11.0-python3.12-browsers --platform linux/amd64 .

docker build --file openjdk17.0-python3.12/Dockerfile -t hanggrian/cimg-multiplatform:openjdk17.0-python3.12 --platform linux/amd64 .
docker build --file openjdk17.0-python3.12/node/Dockerfile -t hanggrian/cimg-multiplatform:openjdk17.0-python3.12-node --platform linux/amd64 .
docker build --file openjdk17.0-python3.12/browsers/Dockerfile -t hanggrian/cimg-multiplatform:openjdk17.0-python3.12-browsers --platform linux/amd64 .

docker build --file openjdk21.0-python3.12/Dockerfile -t hanggrian/cimg-multiplatform:openjdk21.0-python3.12 --platform linux/amd64 .
docker build --file openjdk21.0-python3.12/node/Dockerfile -t hanggrian/cimg-multiplatform:openjdk21.0-python3.12-node --platform linux/amd64 .
docker build --file openjdk21.0-python3.12/browsers/Dockerfile -t hanggrian/cimg-multiplatform:openjdk21.0-python3.12-browsers --platform linux/amd64 .

docker build --file openjdk8.0-python3.13/Dockerfile -t hanggrian/cimg-multiplatform:openjdk8.0-python3.13 --platform linux/amd64 .
docker build --file openjdk8.0-python3.13/node/Dockerfile -t hanggrian/cimg-multiplatform:openjdk8.0-python3.13-node --platform linux/amd64 .
docker build --file openjdk8.0-python3.13/browsers/Dockerfile -t hanggrian/cimg-multiplatform:openjdk8.0-python3.13-browsers --platform linux/amd64 .

docker build --file openjdk11.0-python3.13/Dockerfile -t hanggrian/cimg-multiplatform:openjdk11.0-python3.13 --platform linux/amd64 .
docker build --file openjdk11.0-python3.13/node/Dockerfile -t hanggrian/cimg-multiplatform:openjdk11.0-python3.13-node --platform linux/amd64 .
docker build --file openjdk11.0-python3.13/browsers/Dockerfile -t hanggrian/cimg-multiplatform:openjdk11.0-python3.13-browsers --platform linux/amd64 .

docker build --file openjdk17.0-python3.13/Dockerfile -t hanggrian/cimg-multiplatform:openjdk17.0-python3.13 --platform linux/amd64 .
docker build --file openjdk17.0-python3.13/node/Dockerfile -t hanggrian/cimg-multiplatform:openjdk17.0-python3.13-node --platform linux/amd64 .
docker build --file openjdk17.0-python3.13/browsers/Dockerfile -t hanggrian/cimg-multiplatform:openjdk17.0-python3.13-browsers --platform linux/amd64 .

docker build --file openjdk21.0-python3.13/Dockerfile -t hanggrian/cimg-multiplatform:openjdk21.0-python3.13 --platform linux/amd64 .
docker build --file openjdk21.0-python3.13/node/Dockerfile -t hanggrian/cimg-multiplatform:openjdk21.0-python3.13-node --platform linux/amd64 .
docker build --file openjdk21.0-python3.13/browsers/Dockerfile -t hanggrian/cimg-multiplatform:openjdk21.0-python3.13-browsers --platform linux/amd64 .

docker build --file android2024.11-python3.12/Dockerfile -t hanggrian/cimg-multiplatform:android2024.11-python3.12 --platform linux/amd64 .
docker build --file android2024.11-python3.12/node/Dockerfile -t hanggrian/cimg-multiplatform:android2024.11-python3.12-node --platform linux/amd64 .
docker build --file android2024.11-python3.12/browsers/Dockerfile -t hanggrian/cimg-multiplatform:android2024.11-python3.12-browsers --platform linux/amd64 .

docker build --file android2025.02-python3.12/Dockerfile -t hanggrian/cimg-multiplatform:android2025.02-python3.12 --platform linux/amd64 .
docker build --file android2025.02-python3.12/node/Dockerfile -t hanggrian/cimg-multiplatform:android2025.02-python3.12-node --platform linux/amd64 .
docker build --file android2025.02-python3.12/browsers/Dockerfile -t hanggrian/cimg-multiplatform:android2025.02-python3.12-browsers --platform linux/amd64 .

docker build --file android2024.11-python3.13/Dockerfile -t hanggrian/cimg-multiplatform:android2024.11-python3.13 --platform linux/amd64 .
docker build --file android2024.11-python3.13/node/Dockerfile -t hanggrian/cimg-multiplatform:android2024.11-python3.13-node --platform linux/amd64 .
docker build --file android2024.11-python3.13/browsers/Dockerfile -t hanggrian/cimg-multiplatform:android2024.11-python3.13-browsers --platform linux/amd64 .

docker build --file android2025.02-python3.13/Dockerfile -t hanggrian/cimg-multiplatform:android2025.02-python3.13 --platform linux/amd64 .
docker build --file android2025.02-python3.13/node/Dockerfile -t hanggrian/cimg-multiplatform:android2025.02-python3.13-node --platform linux/amd64 .
docker build --file android2025.02-python3.13/browsers/Dockerfile -t hanggrian/cimg-multiplatform:android2025.02-python3.13-browsers --platform linux/amd64 .
