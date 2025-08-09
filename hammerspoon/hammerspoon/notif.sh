#!/usr/bin/env bash

screencapture -x -R"1152,40,480,100" "$HOME/banner.png"

# Run tesseract and capture output
ocr_text=$(/opt/homebrew/bin/tesseract "$HOME/banner.png" - 2>/dev/null)
echo "OCR result: $ocr_text"

# Extract 4-8 digit code
otp=$(echo "$ocr_text" | grep -Eo '\b[0-9]{4,8}\b' | head -n1)
if [[ -n "$otp" ]]; then
	echo -n "$otp" | pbcopy
	echo "OTP copied to clipboard: $otp"
else
	echo -n "$ocr_text" | pbcopy
	echo "No OTP found, copied full text to clipboard."
fi
rm "$HOME/banner.png"
