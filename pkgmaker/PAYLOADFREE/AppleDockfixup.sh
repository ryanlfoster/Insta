#!/bin/sh
# AppleDockfixup : Payload free. Disable dockfixup.
# chris.gerke@gmail.com

PLIST="com.apple.dockfixup.plist"

# // fix
ROOT="$3"; if [ -z "${ROOT}" ] || [ "${ROOT}" = "/" ]; then ROOT=""; fi

# Disable
[ -e "${ROOT}/Library/Preferences/${PLIST}" ] && sudo mv "${ROOT}/Library/Preferences/${PLIST}" "${ROOT}/Library/Preferences/${PLIST}.bak"

exit 0