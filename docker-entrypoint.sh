#!/usr/bin/env sh

# IMPORTS

. minecraft_setup.sh
. spigot_setup.sh

# PROGRAM

if [ "$MODE" = "build" ]; then
  spigot_build.sh || exit 1
else
  spigot_download.sh || exit 1
fi

minecraft_config.sh || exit 1
minecraft_run.sh || exit 1
