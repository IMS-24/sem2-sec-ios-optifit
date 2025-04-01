#!/bin/bash
# This script retrieves the current FullSemVer and branch name from GitVersion
# and replaces the entire line in the specified file where the placeholders are defined.
# The file should contain lines starting with "FULL_SEMVER =" and "GIT_BRANCH =".

# Set the path to your target file
TARGET_FILE="configs/STAGING.xcconfig"

# Run GitVersion to get version information in JSON format.
VERSION_INFO=$(gitversion /output json)
if [ $? -ne 0 ]; then
  echo "Error: GitVersion command failed."
  exit 1
fi

# Parse the JSON to extract FullSemVer and BranchName using jq.
FULL_SEMVER=$(echo "$VERSION_INFO" | jq -r '.FullSemVer')
BRANCH_NAME=$(echo "$VERSION_INFO" | jq -r '.BranchName')
SHORT_SHA=$(echo "$VERSION_INFO" | jq -r '.ShortSha')

# Check that both values were successfully retrieved.
if [ -z "$FULL_SEMVER" ] || [ -z "$BRANCH_NAME" ]; then
  echo "Error: Could not retrieve FullSemVer or BranchName from GitVersion output."
  exit 1
fi

# Check if the target file exists.
if [ ! -f "$TARGET_FILE" ]; then
  echo "Error: File '$TARGET_FILE' not found."
  exit 1
fi

# Replace the entire line that starts with "GIT_HASH =" with the new ShortSHA.
sed -i '' '/^GIT_HASH =/c\
GIT_HASH = '"${SHORT_SHA}" "$TARGET_FILE"

# Replace the entire line that starts with "FULL_SEMVER =" with the new FullSemVer.
sed -i '' '/^FULL_SEMVER =/c\
FULL_SEMVER = '"${FULL_SEMVER}" "$TARGET_FILE"

# Replace the entire line that starts with "GIT_BRANCH =" with the new branch name.
sed -i '' '/^GIT_BRANCH =/c\
GIT_BRANCH = '"${BRANCH_NAME}" "$TARGET_FILE"

echo "Updated '$TARGET_FILE' with FullSemVer: ${FULL_SEMVER} and GIT_BRANCH: ${BRANCH_NAME}"
