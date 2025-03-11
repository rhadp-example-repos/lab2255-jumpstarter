#!/bin/bash

set -e

# unique job ID (required)
JOB_NAME=${JOB_NAME:="`head -c 8 /dev/urandom | od -An -tx1 | tr -d ' \n'`"}
# name of the manifest (required)
MANIFEST=${MANIFEST:=basic}

# the manifest and its location
MANIFEST_EXT=${MANIFEST_EXT:=mpp.yml}
MANIFEST_LOCATION=${MANIFEST_LOCATION:=manifests}
MANIFEST_FILE="$MANIFEST_LOCATION/$MANIFEST.$MANIFEST_EXT"

# build locations
BUILD_NAME="output"
BUILD_LOCATION="builds/$JOB_NAME"

# build args with defaults
DISTRO=${DISTRO:=autosd9-sig} # autosd cs9
ARCH=${ARCH:=aarch64}  # aarch64 x86_64
TARGET=${TARGET:=qemu}   # rpi4 qemu
MODE=${MODE:=image}  # package image
EXPORT_FORMAT=${EXPORT_FORMAT:=qcow2}  # image qcow2 container

# osbuild args
CACHESIZE="10GB"

# podman args
PULL_ARG="--pull=newer"
BUILDER_IMAGE="quay.io/centos-sig-automotive/automotive-osbuild:latest"

# computed args
CANONICAL_BUILD_NAME="$JOB_NAME-$DISTRO-$TARGET-$MANIFEST.$ARCH"

OSBUILD_CMD="automotive-image-builder/automotive-image-builder build \
    --distro "$DISTRO" --arch "$ARCH" --target "$TARGET" --mode "$MODE" --export "$EXPORT_FORMAT" \
    --build-dir="$BUILD_LOCATION" \
    --cache=".mpp-cache" --cache-max-size="$CACHESIZE" \
    --osbuild-manifest="$BUILD_LOCATION/$BUILD_NAME".json \
    "$MANIFEST_FILE" "$BUILD_NAME.$EXPORT_FORMAT""

# make sure BUILD_LOCATION exists
mkdir -p $BUILD_LOCATION

# build the image in a container
podman run --rm --privileged $PULL_ARG --security-opt label=type:unconfined_t \
  -v /dev:/dev -v "$PWD":"$PWD" \
  $BUILDER_IMAGE \
  /bin/bash -c "cd $PWD/; $OSBUILD_CMD" \
  && mv "$BUILD_NAME.$EXPORT_FORMAT" "builds/$CANONICAL_BUILD_NAME.$EXPORT_FORMAT"

# cleanup
mv "$BUILD_LOCATION/output.json" "builds/$JOB_NAME-output.json"
rm -rf "$BUILD_LOCATION"
