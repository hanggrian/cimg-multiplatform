[![CircleCI](https://img.shields.io/circleci/build/gh/hanggrian/cimg-multiplatform)](https://app.circleci.com/pipelines/gh/hanggrian/cimg-multiplatform/)
[![Codecov](https://img.shields.io/codecov/c/gh/hanggrian/cimg-multiplatform)](https://app.codecov.io/gh/hanggrian/cimg-multiplatform/)
[![Docker Hub](https://img.shields.io/docker/v/hanggrian/cimg-multiplatform)](https://hub.docker.com/r/hanggrian/cimg-multiplatform/)

# CircleCI Multiplatform Images

This repository combines the Dockerfiles from the official CircleCI convenient
images with no customizations. All images have `node` and `browsers` variants.

- **OpenJDK:** [LTS versions](https://www.oracle.com/java/technologies/java-se-support-roadmap.html) with premier support
- **Android:** [Supported versions](https://en.wikipedia.org/wiki/Android_version_history)
- **Python:** [Versions](https://devguide.python.org/versions/) in bugfix window

## Building

Generate Docker files and shell scripts with `generate.py`.

```sh
uv run generate.py
sudo ./build_images.sh
sudo ./push_images.sh
```
