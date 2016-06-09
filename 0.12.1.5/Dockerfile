FROM tomcat:8.0.35
MAINTAINER Rex Tsai "https://about.me/chihchun"

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
 && apt-get dist-upgrade -y \
 && apt-get install -y exuberant-ctags \
    git subversion mercurial bzr cvs rcs cssc monotone \
    wget inotify-tools ant openjdk-7-jdk

ENV OPENGROK_VERSION=0.12.1.5
# Build from source, https://github.com/OpenGrok/OpenGrok/wiki/How-to-build-OpenGrok-from-source
RUN cd / \
 && git clone --depth 1 --branch $OPENGROK_VERSION https://github.com/OpenGrok/OpenGrok.git \
 && cd OpenGrok \
 && ant

RUN apt-get remove --purge -y --auto-remove ant openjdk-7-jdk \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

ENV PATH=/OpenGrok:$CATALINA_HOME/bin:$PATH \
    OPENGROK_TOMCAT_BASE=/usr/local/tomcat \
    OPENGROK_VERBOSE=true

WORKDIR $OPENGROK_TOMCAT_BASE
RUN /OpenGrok/OpenGrok deploy

RUN mkdir /src \
 && mkdir /data \
 && ln -s /data /var/opengrok \
 && ln -s /src /var/opengrok/src

EXPOSE 8080
ADD entry.sh /entry.sh
CMD ["/entry.sh"]
