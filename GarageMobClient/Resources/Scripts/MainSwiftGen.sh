#!/bin/sh

#  MainSwiftGen.sh
#  GarageMobClient
#
#  Created by Rezo Joglidze on 11.11.25.

#set -ex

echo "Executing GarageMobClient MainSwiftGen.sh script..."
echo

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Generate Icons.swift
ICON_SCRIPT="$SCRIPT_DIR/IconsGenerator/IconsSwiftGen.sh"
if [ ! -f "$ICON_SCRIPT" ]; then
  echo "IconsSwiftGen script not found at $ICON_SCRIPT"
  exit 1
fi

chmod u+x "$ICON_SCRIPT"
"$ICON_SCRIPT"
