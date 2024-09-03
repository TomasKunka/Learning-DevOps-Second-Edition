#!/usr/bin/env bash
set -ex
sudo apt-get update && apt-get install -y pipx
pipx install --include-deps ansible