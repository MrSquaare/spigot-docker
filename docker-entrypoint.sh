#!/usr/bin/env sh

. minecraft_setup.sh

spigot_download.sh || exit 1
minecraft_config.sh || exit 1
minecraft_run.sh || exit 1
