#!/usr/bin/env sh

# ENVIRONMENT VARIABLES

SPIGOT_FILE="spigot-$MINECRAFT_VERSION.jar"
SPIGOT_URL="https://cdn.getbukkit.org/spigot/spigot-$MINECRAFT_VERSION.jar"

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
  if [ ! -f "$SPIGOT_FILE" ]; then
    echo_info "Downloading $SPIGOT_FILE..."
    curl --progress-bar "$SPIGOT_URL" -o "$SPIGOT_FILE" &&
      echo_success "Downloaded $SPIGOT_FILE" ||
      (echo_error "Can't download $SPIGOT_FILE" && exit 1)
  fi
}

copy() {
  echo_info "Copying $SPIGOT_FILE to $SERVER_FILE..."
  cp -f "$SPIGOT_FILE" "$SERVER_FILE" && \
    echo_success "Copied $SPIGOT_FILE" ||
    (echo_error "Can't copy $SPIGOT_FILE" && exit 1)
}

# PROGRAM

cd "$BUILD_DIRECTORY" || exit 1

download
copy
