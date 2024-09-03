#!/usr/bin/env bash
set -ex
sudo apt-get update && sudo apt-get install -y pipx
pipx install --include-deps ansible