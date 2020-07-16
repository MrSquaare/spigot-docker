#!/usr/bin/env bash

# ENVIRONMENT VARIABLES

SPIGOT_FILE="spigot-$MINECRAFT_VERSION.jar"
SPIGOT_URL="https://cdn.getbukkit.org/spigot/spigot-$MINECRAFT_VERSION.jar"

# FUNCTIONS

## ECHO FUNCTIONS

echo_error() {
  echo "[spigot:download] [ERROR] $1"
}

echo_info() {
  echo "[spigot:download] [INFO] $1"
}

echo_success() {
  echo "[spigot:download] [SUCCESS] $1"
}

## PROGRAM FUNCTIONS

download() {
  if [[ ! -f "$SPIGOT_FILE" ]] || [[ "$FORCE_DOWNLOAD" == "true" ]]; then
    echo_info "Downloading $SPIGOT_FILE..."

    if curl --progress-bar "$SPIGOT_URL" -o "$SPIGOT_FILE"; then
      echo_success "Downloaded $SPIGOT_FILE"
    else
      echo_error "Can't download $SPIGOT_FILE" && exit 1
    fi

    FORCE_COPY=true
  fi
}

copy() {
  if [[ ! -f "$SERVER_FILE" ]] || [[ "$FORCE_COPY" == "true" ]]; then
    echo_info "Copying $SPIGOT_FILE to $SERVER_FILE..."

    if cp -f "$SPIGOT_FILE" "$SERVER_FILE"; then
      echo_success "Copied $SPIGOT_FILE"
    else
      echo_error "Can't copy $SPIGOT_FILE" && exit 1
    fi
  fi
}

# PROGRAM

cd "$DOWNLOAD_DIRECTORY" || exit 1

download
copy
