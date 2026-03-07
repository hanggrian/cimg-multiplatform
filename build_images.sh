#!/usr/bin/env bash

set -eo pipefail

docker build --file openjdk17.0-python3.13/Dockerfile -t hanggrian/cimg-multiplatform:openjdk17.0-python3.13 --platform linux/amd64 .
docker build --file openjdk17.0-python3.13/node/Dockerfile -t hanggrian/cimg-multiplatform:openjdk17.0-python3.13-node --platform linux/amd64 .
docker build --file openjdk17.0-python3.13/browsers/Dockerfile -t hanggrian/cimg-multiplatform:openjdk17.0-python3.13-browsers --platform linux/amd64 .

docker build --file openjdk21.0-python3.13/Dockerfile -t hanggrian/cimg-multiplatform:openjdk21.0-python3.13 --platform linux/amd64 .
docker build --file openjdk21.0-python3.13/node/Dockerfile -t hanggrian/cimg-multiplatform:openjdk21.0-python3.13-node --platform linux/amd64 .
docker build --file openjdk21.0-python3.13/browsers/Dockerfile -t hanggrian/cimg-multiplatform:openjdk21.0-python3.13-browsers --platform linux/amd64 .

docker build --file openjdk25.0-python3.13/Dockerfile -t hanggrian/cimg-multiplatform:openjdk25.0-python3.13 --platform linux/amd64 .
docker build --file openjdk25.0-python3.13/node/Dockerfile -t hanggrian/cimg-multiplatform:openjdk25.0-python3.13-node --platform linux/amd64 .
docker build --file openjdk25.0-python3.13/browsers/Dockerfile -t hanggrian/cimg-multiplatform:openjdk25.0-python3.13-browsers --platform linux/amd64 .

docker build --file openjdk17.0-python3.14/Dockerfile -t hanggrian/cimg-multiplatform:openjdk17.0-python3.14 --platform linux/amd64 .
docker build --file openjdk17.0-python3.14/node/Dockerfile -t hanggrian/cimg-multiplatform:openjdk17.0-python3.14-node --platform linux/amd64 .
docker build --file openjdk17.0-python3.14/browsers/Dockerfile -t hanggrian/cimg-multiplatform:openjdk17.0-python3.14-browsers --platform linux/amd64 .

docker build --file openjdk21.0-python3.14/Dockerfile -t hanggrian/cimg-multiplatform:openjdk21.0-python3.14 --platform linux/amd64 .
docker build --file openjdk21.0-python3.14/node/Dockerfile -t hanggrian/cimg-multiplatform:openjdk21.0-python3.14-node --platform linux/amd64 .
docker build --file openjdk21.0-python3.14/browsers/Dockerfile -t hanggrian/cimg-multiplatform:openjdk21.0-python3.14-browsers --platform linux/amd64 .

docker build --file openjdk25.0-python3.14/Dockerfile -t hanggrian/cimg-multiplatform:openjdk25.0-python3.14 --platform linux/amd64 .
docker build --file openjdk25.0-python3.14/node/Dockerfile -t hanggrian/cimg-multiplatform:openjdk25.0-python3.14-node --platform linux/amd64 .
docker build --file openjdk25.0-python3.14/browsers/Dockerfile -t hanggrian/cimg-multiplatform:openjdk25.0-python3.14-browsers --platform linux/amd64 .

docker build --file android2024.04-python3.13/Dockerfile -t hanggrian/cimg-multiplatform:android2024.04-python3.13 --platform linux/amd64 .
docker build --file android2024.04-python3.13/node/Dockerfile -t hanggrian/cimg-multiplatform:android2024.04-python3.13-node --platform linux/amd64 .
docker build --file android2024.04-python3.13/browsers/Dockerfile -t hanggrian/cimg-multiplatform:android2024.04-python3.13-browsers --platform linux/amd64 .

docker build --file android2025.03-python3.13/Dockerfile -t hanggrian/cimg-multiplatform:android2025.03-python3.13 --platform linux/amd64 .
docker build --file android2025.03-python3.13/node/Dockerfile -t hanggrian/cimg-multiplatform:android2025.03-python3.13-node --platform linux/amd64 .
docker build --file android2025.03-python3.13/browsers/Dockerfile -t hanggrian/cimg-multiplatform:android2025.03-python3.13-browsers --platform linux/amd64 .

docker build --file android2026.03-python3.13/Dockerfile -t hanggrian/cimg-multiplatform:android2026.03-python3.13 --platform linux/amd64 .
docker build --file android2026.03-python3.13/node/Dockerfile -t hanggrian/cimg-multiplatform:android2026.03-python3.13-node --platform linux/amd64 .
docker build --file android2026.03-python3.13/browsers/Dockerfile -t hanggrian/cimg-multiplatform:android2026.03-python3.13-browsers --platform linux/amd64 .

docker build --file android2024.04-python3.14/Dockerfile -t hanggrian/cimg-multiplatform:android2024.04-python3.14 --platform linux/amd64 .
docker build --file android2024.04-python3.14/node/Dockerfile -t hanggrian/cimg-multiplatform:android2024.04-python3.14-node --platform linux/amd64 .
docker build --file android2024.04-python3.14/browsers/Dockerfile -t hanggrian/cimg-multiplatform:android2024.04-python3.14-browsers --platform linux/amd64 .

docker build --file android2025.03-python3.14/Dockerfile -t hanggrian/cimg-multiplatform:android2025.03-python3.14 --platform linux/amd64 .
docker build --file android2025.03-python3.14/node/Dockerfile -t hanggrian/cimg-multiplatform:android2025.03-python3.14-node --platform linux/amd64 .
docker build --file android2025.03-python3.14/browsers/Dockerfile -t hanggrian/cimg-multiplatform:android2025.03-python3.14-browsers --platform linux/amd64 .

docker build --file android2026.03-python3.14/Dockerfile -t hanggrian/cimg-multiplatform:android2026.03-python3.14 --platform linux/amd64 .
docker build --file android2026.03-python3.14/node/Dockerfile -t hanggrian/cimg-multiplatform:android2026.03-python3.14-node --platform linux/amd64 .
docker build --file android2026.03-python3.14/browsers/Dockerfile -t hanggrian/cimg-multiplatform:android2026.03-python3.14-browsers --platform linux/amd64 .

