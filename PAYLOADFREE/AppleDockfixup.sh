#!/bin/sh
# AppleDockfixup : Payload free. Disable dockfixup.
# chris.gerke@gmail.com

ROOT="$3"

# // fix
if [ -z "${ROOT}" ] || [ "${ROOT}" = "/" ]; then ROOT=""; fi

DOCKFIXUP="${ROOT}/Library/Preferences/com.apple.dockfixup.plist"
[ -e "${DOCKFIXUP}" ] && sudo mv "${DOCKFIXUP}" "${DOCKFIXUP}.bak"

exit 0