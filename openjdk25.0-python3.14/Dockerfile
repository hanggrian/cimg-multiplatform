# A combination of:
#
# - https://github.com/CircleCI-Public/cimg-openjdk/raw/main/25.0/Dockerfile
# - https://github.com/CircleCI-Public/cimg-python/raw/main/3.14/Dockerfile

FROM cimg/base:2026.03

LABEL maintainer="Hendra Anggrian <hanggrian@proton.me>"

ENV JAVA_VERSION=25.0.1
ENV JAVA_HOME=/usr/local/jdk-${JAVA_VERSION}

RUN [[ $(uname -m) == "x86_64" ]] && ARCH="x64" || ARCH="aarch64" && \
  JAVA_MAJOR_VERSION=$(echo "$JAVA_VERSION" | cut -d '.' -f 1) && \
  JAVA_PATCH_VERSION=$(echo "$JAVA_VERSION" | cut -d '.' -f 3) && \
  if [ "$JAVA_MAJOR_VERSION" = "8" ]; then \
    JAVA_BUILD=$(curl -s "https://api.github.com/repos/adoptium/temurin8-binaries/releases" | jq ".[] | select(.tag_name | startswith(\"jdk8u${JAVA_PATCH_VERSION}\")) | select(.tag_name | contains(\"-beta\") | not) | .tag_name" | tr -d '"'); \
    JAVA_BUILD="${JAVA_BUILD/jdk8u/}"; \
    JAVA_BUILD_SANITISED="${JAVA_BUILD//-/}"; \
    URL="https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u${JAVA_BUILD}/OpenJDK8U-jdk_${ARCH}_linux_hotspot_8u${JAVA_BUILD_SANITISED}.tar.gz"; \
  else \
    if [ "$JAVA_VERSION" = "$JAVA_MAJOR_VERSION".0 ]; then \
      START_WITH_VERSION=${JAVA_MAJOR_VERSION}; \
      JAVA_SEARCH=${JAVA_MAJOR_VERSION}; \
    else \
      START_WITH_VERSION=${JAVA_VERSION}; \
      JAVA_SEARCH=${JAVA_VERSION}; \
    fi && \
    JAVA_BUILD=$(curl -s "https://api.github.com/repos/adoptium/temurin${JAVA_MAJOR_VERSION}-binaries/releases" | jq "limit(1; .[] | select(.tag_name | startswith(\"jdk-${START_WITH_VERSION}+\"))) | .tag_name | split(\"+\")[1]" | tr -d '"'); \
    URL="https://github.com/adoptium/temurin${JAVA_MAJOR_VERSION}-binaries/releases/download/jdk-${JAVA_SEARCH}%2B${JAVA_BUILD%.*}/OpenJDK${JAVA_MAJOR_VERSION}U-jdk_${ARCH}_linux_hotspot_${JAVA_SEARCH}_${JAVA_BUILD%.*}.tar.gz"; \
  fi && \
  curl -sSL -o java.tar.gz "${URL}" && \
  sudo mkdir /usr/local/jdk-${JAVA_VERSION} && \
  sudo tar -xzf java.tar.gz --strip-components=1 -C /usr/local/jdk-${JAVA_VERSION} && \
  rm java.tar.gz && \
  if [[ "$JAVA_VERSION" == *"0.0"* ]]; then \
    sudo ln -s /usr/local/jdk-${JAVA_VERSION} /usr/local/jdk-25; \
  fi && \
  sudo ln -s /usr/local/jdk-${JAVA_VERSION}/bin/* /usr/bin/ && \
  sudo mkdir -p /etc/ssl/certs/java/cacerts && \
  sudo ln -s ${JAVA_HOME}/lib/security/cacerts /etc/ssl/certs/java/cacerts && \
  # Install packages to help with legacy image migration
  sudo apt-get update && sudo apt-get install -y fontconfig && \
  sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
  # The dual version command is to support OpenJDK 8
  java --version || java -version && \
  javac --version || javac -version

ENV MAVEN_VERSION=3.9.11 \
  PATH=/opt/apache-maven/bin:$PATH
RUN dl_URL="https://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz" && \
  curl -sSL --fail --retry 3 $dl_URL -o apache-maven.tar.gz && \
  sudo tar -xzf apache-maven.tar.gz -C /opt/ && \
  rm apache-maven.tar.gz && \
  sudo ln -s /opt/apache-maven-* /opt/apache-maven && \
  mvn --version

ENV GRADLE_VERSION=9.2.0 \
  PATH=/opt/gradle/bin:$PATH
RUN dl_URL="https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip" && \
  curl -sSL --fail --retry 3 $dl_URL -o gradle.zip && \
  sudo unzip -d /opt gradle.zip && \
  rm gradle.zip && \
  sudo ln -s /opt/gradle-* /opt/gradle && \
  gradle --version

ENV SBT_VERSION=1.11.7 \
  PATH=/opt/sbt/bin:$PATH
ENV MILL_VERSION=1.0.6
RUN dl_URL="https://github.com/sbt/sbt/releases/download/v${SBT_VERSION}/sbt-${SBT_VERSION}.tgz" && \
  curl -sSL --fail --retry 3 $dl_URL -o sbt.tar.gz && \
  sudo tar -xzf sbt.tar.gz -C /opt/ && \
  sudo ln -s /opt/sbt-* /opt/sbt && \
  sbt about --allow-empty && \
  rm -rf sbt.tar.gz ~/project/project ~/project/target && \
  # install mill docs: http://mill-build.com/mill/Installation_IDE_Support.html#_mills_bootstrap_script_linuxos_x_only
  sudo curl -L https://repo1.maven.org/maven2/com/lihaoyi/mill-dist/${MILL_VERSION}/mill-dist-${MILL_VERSION}-mill.sh -o /usr/local/bin/mill && \
  sudo chmod +x /usr/local/bin/mill

ENV PYENV_ROOT=/home/circleci/.pyenv \
  PATH=/home/circleci/.pyenv/shims:/home/circleci/.pyenv/bin:/home/circleci/.poetry/bin:$PATH \
  PYTHON_VERSION=3.14.3 \
  PIPENV_DEFAULT_PYTHON_VERSION=3.14.3

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
    zlib1g-dev \
    zstd \
    libzstd-dev && \
  curl -sSL "https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer" | bash && \
  sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN env PYTHON_CONFIGURE_OPTS="--enable-shared --enable-optimizations" pyenv install 3.14.3 && pyenv global 3.14.3

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

# This installs uv at the latest version.
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
