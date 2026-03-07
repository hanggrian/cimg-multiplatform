# A combination of:
#
# - https://github.com/CircleCI-Public/cimg-android/raw/main/2024.04/Dockerfile
# - https://github.com/CircleCI-Public/cimg-python/raw/main/3.14/Dockerfile

FROM hanggrian/cimg-multiplatform:android2024.04-python3.14

LABEL maintainer="Hendra Anggrian <hanggrian@proton.me>"

# Dockerfile will pull the latest LTS release from cimg-node.
RUN curl -sSL "https://raw.githubusercontent.com/CircleCI-Public/cimg-node/main/ALIASES" -o nodeAliases.txt && \
  NODE_VERSION=$(grep "lts" ./nodeAliases.txt | cut -d "=" -f 2-) && \
  [[ $(uname -m) == "x86_64" ]] && ARCH="x64" || ARCH="arm64" && \
  curl -L -o node.tar.xz "https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-${ARCH}.tar.xz" && \
  sudo tar -xJf node.tar.xz -C /usr/local --strip-components=1 && \
  rm node.tar.xz nodeAliases.txt && \
  sudo ln -s /usr/local/bin/node /usr/local/bin/nodejs

RUN sudo npm install -g yarn pnpm
