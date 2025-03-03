# A combination of:
#
# - https://github.com/CircleCI-Public/cimg-android/raw/main/2024.11/Dockerfile
# - https://github.com/CircleCI-Public/cimg-python/raw/main/3.13/Dockerfile

FROM hanggrian/cimg-multiplatform:android2024.11-python3.13

LABEL maintainer="Hendra Anggrian <hanggrian@proton.me>"

# Dockerfile will pull the latest LTS release from cimg-node.
RUN curl -sSL "https://raw.githubusercontent.com/CircleCI-Public/cimg-node/main/ALIASES" -o nodeAliases.txt && \
  NODE_VERSION=$(grep "lts" ./nodeAliases.txt | cut -d "=" -f 2-) && \
  [[ $(uname -m) == "x86_64" ]] && ARCH="x64" || ARCH="arm64" && \
  curl -L -o node.tar.xz "https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-${ARCH}.tar.xz" && \
  sudo tar -xJf node.tar.xz -C /usr/local --strip-components=1 && \
  rm node.tar.xz nodeAliases.txt && \
  sudo ln -s /usr/local/bin/node /usr/local/bin/nodejs

ENV YARN_VERSION="1.22.19"
RUN curl -L -o yarn.tar.gz "https://yarnpkg.com/downloads/${YARN_VERSION}/yarn-v${YARN_VERSION}.tar.gz" && \
  sudo tar -xzf yarn.tar.gz -C /opt/ && \
  rm yarn.tar.gz && \
  sudo ln -s /opt/yarn-v${YARN_VERSION}/bin/yarn /usr/local/bin/yarn && \
  sudo ln -s /opt/yarn-v${YARN_VERSION}/bin/yarnpkg /usr/local/bin/yarnpkg
