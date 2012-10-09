#!/bin/sh
# AppleWizards : Payload free. Disable Apple Setup Wizard, Disable Registration Wizard.
# chris.gerke@gmail.com

ROOT="$3"

# // fix
if [ -z "${ROOT}" ] || [ "${ROOT}" = "/" ]; then ROOT=""; fi

# Disable Apple Setup Wizard
sudo touch "${ROOT}/private/var/db/.AppleSetupDone"
sudo chown root:wheel "${ROOT}/private/var/db/.AppleSetupDone"

# Disable Registration Wizard
sudo touch "${ROOT}/Library/Receipts/.SetupRegComplete"
sudo chown root:wheel "${ROOT}/Library/Receipts/.SetupRegComplete"

exit 0
