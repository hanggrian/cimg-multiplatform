# A combination of:
#
# - https://github.com/CircleCI-Public/cimg-node/raw/main/22.5/Dockerfile
# - https://github.com/CircleCI-Public/cimg-python/raw/main/3.12/Dockerfile

FROM cimg/base:2024.02

LABEL maintainer="Hendra Anggrian <hanggrian@proton.me>"

ENV NODE_VERSION 22.5.1

RUN [[ $(uname -m) == "x86_64" ]] && ARCH="x64" || ARCH="arm64" && \
   curl -L -o node.tar.xz "https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-${ARCH}.tar.xz" && \
  sudo tar -xJf node.tar.xz -C /usr/local --strip-components=1 && \
  rm node.tar.xz && \
  sudo ln -s /usr/local/bin/node /usr/local/bin/nodejs

ENV PATH /home/circleci/.yarn/bin:$PATH

ENV YARN_VERSION 1.22.22
RUN curl -L -o yarn.tar.gz "https://yarnpkg.com/downloads/${YARN_VERSION}/yarn-v${YARN_VERSION}.tar.gz" && \
  sudo tar -xzf yarn.tar.gz -C /opt/ && \
  rm yarn.tar.gz && \
  sudo ln -s /opt/yarn-v${YARN_VERSION}/bin/yarn /usr/local/bin/yarn && \
  sudo ln -s /opt/yarn-v${YARN_VERSION}/bin/yarnpkg /usr/local/bin/yarnpkg

# Install an alternative, but growing in popularity Node.js package manager
RUN sudo npm install -g pnpm

ENV PYENV_ROOT=/home/circleci/.pyenv \
  PATH=/home/circleci/.pyenv/shims:/home/circleci/.pyenv/bin:/home/circleci/.poetry/bin:$PATH \
  PYTHON_VERSION=3.12.4 \
  PIPENV_DEFAULT_PYTHON_VERSION=3.12.4

RUN sudo apt-get update && sudo apt-get install -y \
    build-essential \
    ca-certificates \
    curl \
    git \
    libbz2-dev \
    liblzma-dev \
    libncurses5-dev \
    libncursesw5-dev \
    libreadline-dev \
    libffi-dev \
    libsqlite3-dev \
    libssl-dev \
    libxml2-dev \
    libxmlsec1-dev \
    llvm \
    make \
    python3-openssl \
    tk-dev \
    wget \
    xz-utils \
    zlib1g-dev && \
  curl -sSL "https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer" | bash && \
  sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN env PYTHON_CONFIGURE_OPTS="--enable-shared --enable-optimizations" pyenv install 3.12.4 && pyenv global 3.12.4

RUN python --version && \
  pip --version && \
  pip install --upgrade pip && \
  pip --version && \
  # This installs pipenv at the latest version
  pip install pipenv wheel && \
  pipenv --version && \
  # Install pipx
  pip install --user pipx

# This installs version poetry at the latest version. poetry is updated about twice a month.
RUN curl -sSL https://install.python-poetry.org | python -
