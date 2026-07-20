FROM docker.m.daocloud.io/library/golang:1.24-bookworm

RUN apt update && apt install -y \
    git \
    curl \
    xz-utils

# Download aarch64 musl cross compiler (musl-based libc, compatible with HarmonyOS)
RUN curl -L https://musl.cc/aarch64-linux-musl-cross.tgz -o /tmp/musl-cross.tgz && \
    tar xzf /tmp/musl-cross.tgz -C /usr/local && \
    rm /tmp/musl-cross.tgz

ENV GOOS=linux
ENV GOARCH=arm64
ENV CGO_ENABLED=1
ENV CC=/usr/local/aarch64-linux-musl-cross/bin/aarch64-linux-musl-gcc
ENV CXX=/usr/local/aarch64-linux-musl-cross/bin/aarch64-linux-musl-g++
ENV CGO_LDFLAGS="-static"

WORKDIR /build

CMD ["bash"]
