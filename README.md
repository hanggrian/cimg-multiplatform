[![Docker Hub](https://img.shields.io/docker/v/hanggrian/cimg-multiplatform)](https://hub.docker.com/r/hanggrian/cimg-multiplatform/)

# CircleCI Multiplatform Images

This repository combines the Dockerfiles from the official CircleCI convenient
images with no customizations.

Build matrix | Versions | Variants
--- |--- | ---
Java | All LTS versions (8, 11, 17, 21) | Node, browsers
Android | 2024 and 2025 | Node, browsers
Python | 3.12 and 3.13 | Node, browsers

## Building

Generate Docker files and shell scripts with `generate.py`.

```sh
python generate.py
sudo ./build_images.sh
sudo ./push_images.sh
```
