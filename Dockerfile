FROM ubuntu:22.04

RUN apt-get update && apt-get upgrade

RUN apt-get install -y \
    curl \
    wget \
    jq \
    make \
    git

COPY . /collection

WORKDIR /collection

ENTRYPOINT ["/bin/bash"]
