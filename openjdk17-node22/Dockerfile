# A combination of:
#
# - https://github.com/CircleCI-Public/cimg-openjdk/raw/main/17.0/Dockerfile
# - https://github.com/CircleCI-Public/cimg-node/raw/main/22.5/Dockerfile

FROM cimg/base:2024.02

LABEL maintainer="Hendra Anggrian <hanggrian@proton.me>"

ENV JAVA_VERSION 17.0.11
ENV JAVA_HOME /usr/local/jdk-${JAVA_VERSION}

RUN [[ $(uname -m) == "x86_64" ]] && ARCH="x64" || ARCH="aarch64" && \
  JAVA_MAJOR_VERSION=$(echo "$JAVA_VERSION" | cut -d '.' -f 1) && \
  JAVA_PATCH_VERSION=$(echo "$JAVA_VERSION" | cut -d '.' -f 3) && \
  if [ "$JAVA_MAJOR_VERSION" = "8" ]; then \
    JAVA_BUILD=$(curl -s "https://api.github.com/repos/adoptium/temurin8-binaries/releases" | jq ".[] | select(.tag_name | startswith(\"jdk8u${JAVA_PATCH_VERSION}\")) | .tag_name" | tr -d '"'); \
    JAVA_BUILD="${JAVA_BUILD/jdk8u/}"; \
    JAVA_BUILD_SANITISED="${JAVA_BUILD//-/}"; \
    URL="https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u${JAVA_BUILD}/OpenJDK8U-jdk_${ARCH}_linux_hotspot_8u${JAVA_BUILD_SANITISED}.tar.gz"; \
  else \
    JAVA_BUILD=$(curl -s "https://api.github.com/repos/adoptium/temurin${JAVA_MAJOR_VERSION}-binaries/releases" | jq "limit(1; .[] | select(.tag_name | startswith(\"jdk-${JAVA_VERSION}+\"))) | .tag_name | split(\"+\")[1]" | tr -d '"'); \
    URL="https://github.com/adoptium/temurin${JAVA_MAJOR_VERSION}-binaries/releases/download/jdk-${JAVA_VERSION}%2B${JAVA_BUILD%.*}/OpenJDK${JAVA_MAJOR_VERSION}U-jdk_${ARCH}_linux_hotspot_${JAVA_VERSION}_${JAVA_BUILD%.*}.tar.gz"; \
  fi && \
  curl -sSL -o java.tar.gz "${URL}" && \
  sudo mkdir /usr/local/jdk-${JAVA_VERSION} && \
  sudo tar -xzf java.tar.gz --strip-components=1 -C /usr/local/jdk-${JAVA_VERSION} && \
  rm java.tar.gz && \
  if [[ "$JAVA_VERSION" == *"0.0"* ]]; then \
    sudo ln -s /usr/local/jdk-${JAVA_VERSION} /usr/local/jdk-17; \
  fi && \
  sudo ln -s /usr/local/jdk-${JAVA_VERSION}/bin/* /usr/bin/ && \
  sudo mkdir -p /etc/ssl/certs/java/cacerts && \
  sudo ln -s ${JAVA_HOME}/lib/security/cacerts /etc/ssl/certs/java/cacerts && \
  # Install packages to help with legacy image migration
  sudo apt-get update && sudo apt-get install -y \
    fontconfig \
  && \
  sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
  # The dual version command is to support OpenJDK 8
  java --version || java -version && \
  javac --version || javac -version

ENV MAVEN_VERSION=3.9.6 \
  PATH=/opt/apache-maven/bin:$PATH
RUN dl_URL="https://dlcdn.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz" && \
  curl -sSL --fail --retry 3 $dl_URL -o apache-maven.tar.gz && \
  sudo tar -xzf apache-maven.tar.gz -C /opt/ && \
  rm apache-maven.tar.gz && \
  sudo ln -s /opt/apache-maven-* /opt/apache-maven && \
  mvn --version

ENV GRADLE_VERSION=8.7 \
  PATH=/opt/gradle/bin:$PATH
RUN dl_URL="https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip" && \
  curl -sSL --fail --retry 3 $dl_URL -o gradle.zip && \
  sudo unzip -d /opt gradle.zip && \
  rm gradle.zip && \
  sudo ln -s /opt/gradle-* /opt/gradle && \
  gradle --version

ENV SBT_VERSION=1.9.9 \
  PATH=/opt/sbt/bin:$PATH
ENV MILL_VERSION=0.11.7
RUN dl_URL="https://github.com/sbt/sbt/releases/download/v${SBT_VERSION}/sbt-${SBT_VERSION}.tgz" && \
  curl -sSL --fail --retry 3 $dl_URL -o sbt.tar.gz && \
  sudo tar -xzf sbt.tar.gz -C /opt/ && \
  sudo ln -s /opt/sbt-* /opt/sbt && \
  sbt about && \
  rm -rf sbt.tar.gz ~/project/project ~/project/target && \
  # install mill docs: http://mill-build.com/mill/Installation_IDE_Support.html#_mills_bootstrap_script_linuxos_x_only
  mill_URL="https://github.com/com-lihaoyi/mill/releases/download/${MILL_VERSION}/${MILL_VERSION}" && \
  curl -sSL --fail --retry 3 $mill_URL > mill && \
  sudo mv mill /usr/local/bin/mill && chmod +x /usr/local/bin/mill

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
