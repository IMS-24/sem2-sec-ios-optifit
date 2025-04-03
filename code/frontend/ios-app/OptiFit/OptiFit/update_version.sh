#!/bin/bash
# This script retrieves the current FullSemVer, Git branch, and Git hash from GitVersion,
# then replaces the matching lines in multiple configuration files.
# Each file should have lines starting with "GIT_HASH =", "FULL_SEMVER =", and "GIT_BRANCH =".

# Run GitVersion to get version information in JSON format.
VERSION_INFO=$(gitversion /output json)
if [ $? -ne 0 ]; then
  echo "Error: GitVersion command failed."
  exit 1
fi

# Parse the JSON to extract FullSemVer, BranchName, and ShortSha using jq.
FULL_SEMVER=$(echo "$VERSION_INFO" | jq -r '.FullSemVer')
BRANCH_NAME=$(echo "$VERSION_INFO" | jq -r '.BranchName')
SHORT_SHA=$(echo "$VERSION_INFO" | jq -r '.ShortSha')

# Check that both values were successfully retrieved.
if [ -z "$FULL_SEMVER" ] || [ -z "$BRANCH_NAME" ]; then
  echo "Error: Could not retrieve FullSemVer or BranchName from GitVersion output."
  exit 1
fi

# List of target configuration files.
TARGET_FILES=(
  "configs/Development.xcconfig"
  "configs/Production.xcconfig"
  "configs/Staging.xcconfig"
  "configs/Testing.xcconfig"
)

# Loop through each file and update the versioning information.
for TARGET_FILE in "${TARGET_FILES[@]}"; do
  if [ ! -f "$TARGET_FILE" ]; then
    echo "Warning: File '$TARGET_FILE' not found. Skipping."
    continue
  fi

  # Replace the entire line that starts with "GIT_HASH =" with the new ShortSha.
  sed -i '' '/^GIT_HASH =/c\
GIT_HASH = '"${SHORT_SHA}" "$TARGET_FILE"

  # Replace the entire line that starts with "FULL_SEMVER =" with the new FullSemVer.
  sed -i '' '/^FULL_SEMVER =/c\
FULL_SEMVER = '"${FULL_SEMVER}" "$TARGET_FILE"

  # Replace the entire line that starts with "GIT_BRANCH =" with the new branch name.
  sed -i '' '/^GIT_BRANCH =/c\
GIT_BRANCH = '"${BRANCH_NAME}" "$TARGET_FILE"

  echo "Updated '$TARGET_FILE' with FullSemVer: ${FULL_SEMVER}, GIT_BRANCH: ${BRANCH_NAME}, and GIT_HASH: ${SHORT_SHA}"
done
