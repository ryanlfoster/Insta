#!/bin/sh
# AppleWizards : Payload free. Disable Apple Setup Wizard, Disable Registration Wizard.
# chris.gerke@gmail.com

ROOT="$3"

# // fix
if [ -z "${ROOT}" ] || [ "${ROOT}" = "/" ]; then ROOT=""; fi

# Disable Apple Setup Wizard
sudo /usr/bin/touch "${ROOT}/private/var/db/.AppleSetupDone"
sudo /usr/sbin/chown root:wheel "${ROOT}/private/var/db/.AppleSetupDone"

# Disable Registration Wizard
sudo /usr/bin/touch "${ROOT}/Library/Receipts/.SetupRegComplete"
sudo /usr/sbin/chown root:wheel "${ROOT}/Library/Receipts/.SetupRegComplete"

exit 0
