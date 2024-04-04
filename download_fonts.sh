#!/bin/bash

set -x

REPO_URL="https://api.github.com/repos/fauxparse/circular-std/contents/fonts"

# Loop through each file in the directory
curl -s "$REPO_URL" | grep -oE '"download_url": "([^"]+\.ttf|[^"]+\.otf)"' | grep -oE 'https://[^"]+' | while read -r DOWNLOAD_URL; do
    FILENAME=$(basename "$DOWNLOAD_URL")
    echo "$FILENAME"
    # Download the font file to /Library/Fonts/
    curl -s -o "/Library/Fonts/$FILENAME" "$DOWNLOAD_URL"
    echo "Downloaded $FILENAME"
done
