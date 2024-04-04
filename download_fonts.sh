#!/bin/bash

set -x

REPO_URL="$1"
FILE_EXTENSION="$2"
DOWNLOAD_LOCATION="$3"

if [ -z "$REPO_URL" ]; then
    echo "Usage: $0 REPO_URL [FILE_EXTENSION]"
    exit 1
fi

if [ -z "$FILE_EXTENSION" ]; then
    FILE_EXTENSION=".ttf"
fi

# If DOWNLOAD_LOCATION is not provided, default to "/Library/Fonts/" - Installs font directly so you don't have to install manually with font book
if [ -z "$DOWNLOAD_LOCATION" ]; then
    DOWNLOAD_LOCATION="/Library/Fonts/"
fi

curl -s "$REPO_URL" | grep -oE '"download_url": "([^"]+\'$FILE_EXTENSION')"' | grep -oE 'https://[^"]+' | while read -r DOWNLOAD_URL; do
    FILENAME=$(basename "$DOWNLOAD_URL")

    curl -s -o "${DOWNLOAD_LOCATION}${FILENAME}" "$DOWNLOAD_URL"
    echo "Downloaded $FILENAME"
done