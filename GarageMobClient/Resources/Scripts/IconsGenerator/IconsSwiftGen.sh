#!/bin/sh

#  IconsSwiftGen.sh
#  LibertyMobileBank
#
#  Created by Rezo Joglidze on 11.11.25.

#set -ex

echo "Executing GarageMobClient IconsSwiftGen.sh script..."
echo

# Resolve paths
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_PATH="$SCRIPT_DIR/swiftgen.yml"

# Locate SwiftGen binary (support common Homebrew prefixes)
SWIFTGEN_BIN="$(command -v swiftgen 2>/dev/null)"
if [ -z "$SWIFTGEN_BIN" ]; then
  for candidate in "/opt/homebrew/bin/swiftgen" "/usr/local/bin/swiftgen"; do
    if [ -x "$candidate" ]; then
      SWIFTGEN_BIN="$candidate"
      break
    fi
  done
fi

if [ -z "$SWIFTGEN_BIN" ]; then
  echo "SwiftGen is not installed or not found in PATH."
  echo "Install it via Homebrew: brew install swiftgen"
  exit 1
fi

if [ ! -f "$CONFIG_PATH" ]; then
  echo "SwiftGen config not found at $CONFIG_PATH. Skipping icons generation."
  exit 1
fi

RESOURCES_DIR="$(cd "$SCRIPT_DIR/../.." 2>/dev/null && pwd)"
ICON_ASSETS_DIR="$RESOURCES_DIR/Icons/Icons.xcassets"
if [ ! -d "$ICON_ASSETS_DIR" ]; then
  echo "Icon asset catalogue not found at $ICON_ASSETS_DIR. Skipping icons generation."
  exit 0
fi

OUTPUT_DIR="$RESOURCES_DIR/Icons"
mkdir -p "$OUTPUT_DIR"

echo "Using SwiftGen at $SWIFTGEN_BIN"
echo "Generating Icons.swift from $ICON_ASSETS_DIR..."

(cd "$SCRIPT_DIR" && "$SWIFTGEN_BIN" config run --config "$CONFIG_PATH")

echo "SwiftGen icons generation completed."

# Mark generated Icons.swift as unchanged to not track it in git
#git update-index --skip-worktree ../../Resources/Icons/Icons.swift
#git update-index --no-skip-worktree ../../Resources/Icons/Icons.swift
