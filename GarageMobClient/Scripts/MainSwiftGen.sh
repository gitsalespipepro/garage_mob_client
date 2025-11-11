#!/bin/sh

#  MainSwiftGen.sh
#  LibertyMobileBank
#
#  Created by Rezo Joglidze on 11.11.25.

#set -ex

echo "Executing GarageMobClient MainSwiftGen.sh script..."
echo

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Generate Icons.swift
cd "$SCRIPT_DIR/IconsGenerator"
chmod u+x IconsSwiftGen.sh
./IconsSwiftGen.sh
