#!/bin/bash

# VS Code is kinda busted in WSL these days?
# This ensures calling code from WSL will work if there's an exec format error

PLATFORM=$(uname -r)
if [[ $PLATFORM =~ [Ww][Ss][Ll]2 ]]; then
    sudo sh -c 'echo :WSLInterop:M::MZ::/init:PF > /usr/lib/binfmt.d/WSLInterop.conf'
    sudo systemctl unmask systemd-binfmt.service
    sudo systemctl restart systemd-binfmt
    sudo systemctl mask systemd-binfmt.service
fi