#
# pckushan@gmail.com
#

FROM openjdk:8

LABEL MAINTAINER=pckushan@gmail.com

ARG PRESTO_VERSION=0.230

ENV PRESTO_HOME=/home/presto
ENV PRESTO_BUILD_DIR=/home/presto/build
RUN echo "Trying to build Presto image into [ ${PRESTO_HOME} ] ]"

# extra dependency for running launcher
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    vim wget curl git sudo && \
    rm -rf /var/lib/apt/lists/*

#RUN groupadd -g 999 presto && \
#    useradd -r -u 999 -g presto --create-home --shell /bin/bash presto
#USER presto

#COPY presto-server-${PRESTO_VERSION}.tar.gz ${PRESTO_HOME}/

RUN echo [Trying to get presto version ${PRESTO_VERSION} binary and install into ${PRESTO_HOME}] && \
    cd ${PRESTO_HOME} && \
    wget -c https://repo1.maven.org/maven2/com/facebook/presto/presto-server/${PRESTO_VERSION}/presto-server-${PRESTO_VERSION}.tar.gz && \
    chmod +x presto-server-${PRESTO_VERSION}.tar.gz && \
    tar -xvf ${PRESTO_HOME}/presto-server-${PRESTO_VERSION}.tar.gz && \
    rm -rf ${PRESTO_HOME}/presto-server-${PRESTO_VERSION}.tar.gz && \ 
    echo OK

COPY etc ${PRESTO_HOME}/presto-server-${PRESTO_VERSION}/etc
EXPOSE 8085

VOLUME ["${PRESTO_HOME}/etc", "${PRESTO_HOME}/data"]

WORKDIR ${PRESTO_HOME}/presto-server-${PRESTO_VERSION}

CMD ["./bin/launcher", "run"]
