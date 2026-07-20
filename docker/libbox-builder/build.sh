#!/bin/bash
set -e

# Switch to the Go module directory (project root is mounted at /build)
cd /build/entry/src/main/go

echo "=== Resolving Go dependencies ==="
export GOPROXY=https://goproxy.cn,direct
export GOFLAGS=-mod=mod
go mod tidy
go mod download

echo "=== Building libbox.so (musl, static) ==="
cd libbox

CGO_ENABLED=1 go build \
  -buildmode=c-shared \
  -tags "netgo" \
  -ldflags "-linkmode external -extldflags -static" \
  -o /build/entry/src/main/libs/arm64-v8a/libbox.so

# Copy the generated C header for NAPI usage
cp /build/entry/src/main/libs/arm64-v8a/libbox.h /build/entry/src/main/cpp/include/libbox.h

ls -lh /build/entry/src/main/libs/arm64-v8a/libbox.so

echo "=== Build complete ==="
