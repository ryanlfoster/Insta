#!/bin/sh
# AppleDockfixup : Payload free. Disable dockfixup.
# chris.gerke@gmail.com

ME=$0
RES="$1/Contents/Resources"
ROOT="$3"

# // fix
if [ -z "${ROOT}" ] || [ "${ROOT}" = "/" ]; then ROOT=""; fi

# Disable dockfixup
DOCKFIXUP="${ROOT}/Library/Preferences/com.apple.dockfixup.plist"
[ -e "${DOCKFIXUP}" ] && sudo /bin/mv "${DOCKFIXUP}" "${DOCKFIXUP}.bak"

exit 0