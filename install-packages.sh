#!/usr/bin/env bash

set -e

PLATFORM_NAME=$(uname)

platform='unknown'
if [[ $PLATFORM_NAME == 'Linux' ]]; then
  platform='linux'
elif [[ $PLATFORM_NAME == 'Darwin' ]]; then
  platform='macos'
fi

CONFIG="packages-linux.conf.yaml"
if [[ $platform == 'macos' ]]; then
    CONFIG="packages-brew.conf.yaml"
fi

DOTBOT_DIR="dotbot"

DOTBOT_BIN="bin/dotbot"
BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
P="${BASEDIR}/plugins"

cd "${BASEDIR}"
git -C "${DOTBOT_DIR}" submodule sync --quiet --recursive
git submodule update --init --recursive

"${BASEDIR}/${DOTBOT_DIR}/${DOTBOT_BIN}" \
    -d "${BASEDIR}" \
    -c "${CONFIG}" \
    -p "${P}/dotbot-apt/apt.py" \
    -p "${P}/dotbot-brew/brew.py" \
    -p "${P}/dotbot-snap/snap.py" \
    "${@}"
