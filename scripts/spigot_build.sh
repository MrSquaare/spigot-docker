#!/usr/bin/env sh

# ENVIRONMENT VARIABLES

SPIGOT_FILE="spigot-$MINECRAFT_VERSION.jar"
SPIGOT_BUILDTOOLS_FILE="BuildTools.jar"
SPIGOT_BUILDTOOLS_URL="https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar"

# FUNCTIONS

## ECHO FUNCTIONS

echo_error() {
  echo "[spigot:build] [ERROR] $1"
}

echo_info() {
  echo "[spigot:build] [INFO] $1"
}

echo_success() {
  echo "[spigot:build] [SUCCESS] $1"
}

## PROGRAM FUNCTIONS

download() {
  if [ ! -f "$SPIGOT_BUILDTOOLS_FILE" ] || [ "$FORCE_DOWNLOAD" = "true" ]; then
    echo_info "Downloading $SPIGOT_BUILDTOOLS_FILE..."
    curl --progress-bar "$SPIGOT_BUILDTOOLS_URL" -o "$SPIGOT_BUILDTOOLS_FILE" &&
      echo_success "Downloaded $SPIGOT_BUILDTOOLS_FILE" ||
      (echo_error "Can't download $SPIGOT_BUILDTOOLS_FILE" && exit 1)
  fi
}

build() {
  if [ ! -f "$SPIGOT_FILE" ] || [ "$FORCE_BUILD" = "true" ]; then
    echo_info "Building $SPIGOT_FILE..."
    (java -jar "$SPIGOT_BUILDTOOLS_FILE" --rev "$MINECRAFT_VERSION" >/dev/null) &&
      echo_success "Built $SPIGOT_FILE" ||
      (echo_error "Can't build $SPIGOT_FILE" && exit 1)

    FORCE_COPY=true
  fi
}

copy() {
  if [ ! -f "$SERVER_FILE" ] || [ "$FORCE_COPY" = "true" ]; then
    echo_info "Copying $SPIGOT_FILE to $SERVER_FILE..."
    cp -f "$SPIGOT_FILE" "$SERVER_FILE" &&
      echo_success "Copied $SPIGOT_FILE" ||
      (echo_error "Can't copy $SPIGOT_FILE" && exit 1)
  fi
}

# PROGRAM

cd "$BUILD_DIRECTORY" || exit 1

download
build
copy
