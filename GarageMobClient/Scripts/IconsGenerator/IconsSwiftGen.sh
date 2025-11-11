#!/bin/sh

#  IconsSwiftGen.sh
#  LibertyMobileBank
#
#  Created by Rezo Joglidze on 11.11.25.

#set -ex

echo "Executing GarageMobClient IconsSwiftGen.sh script..."
echo

# Generate Icons.swift
swiftgen

# Mark generated Icons.swift as unchanged to not track it in git
#git update-index --skip-worktree ../../Resources/Icons/Icons.swift
#git update-index --no-skip-worktree ../../Resources/Icons/Icons.swift
