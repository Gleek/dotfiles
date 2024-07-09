#!/usr/bin/env bash
set -euo pipefail
source ~/.zshenv

# Check if ZOOM_LINK is set
if [ -z "$ZOOM_LINK" ]; then
  echo "Please set the ZOOM_LINK environment variable."
  exit 1
fi
open "$ZOOM_LINK"
echo -n "$ZOOM_LINK
Passcode: $ZOOM_PASS" | pbcopy
