# build arguments to set
# example: `docker build --build-arg AGDA_VERSION=2.6.2.2`
ARG AGDA_VERSION=2.6.2.2
ARG CABAL_VERSION=recommended
ARG GHC_VERSION=9.2.2

# build container
FROM debian:buster-slim

# reclaim arguments inside `FROM` because the weird syntax of dockerfile
# https://docs.docker.com/engine/reference/builder/#understand-how-arg-and-from-interact
ARG AGDA_VERSION
ARG CABAL_VERSION
ARG GHC_VERSION

# install Agda build dependencies
RUN apt update &&\
    apt install -y --no-install-recommends zlib1g-dev build-essential curl wget libffi-dev libffi6 libgmp-dev libgmp10 libncurses-dev libncurses5 libtinfo5 ca-certificates locales git &&\
    rm -rf /var/lib/apt/lists/*

# set locale to UTF-8
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen &&\
    locale-gen

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# install Haskell
RUN curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | BOOTSTRAP_HASKELL_NONINTERACTIVE=1 BOOTSTRAP_HASKELL_MINIMAL=1 sh

ENV PATH=/root/.ghcup/bin:/root/.cabal/bin:${PATH}

RUN ghcup install ghc ${GHC_VERSION} --set &&\
    ghcup install cabal ${CABAL_VERSION} --set

# install Agda
RUN cabal update &&\
    cabal install Agda-${AGDA_VERSION}

# install PLFA and the Agda stdlib
WORKDIR /root
RUN git clone --depth 1 --recurse-submodules --shallow-submodules https://github.com/plfa/plfa.github.io plfa &&\
    mkdir -p /root/.agda &&\
    cp plfa/data/dotagda/* /root/.agda

# test file
COPY hello-world.agda /root