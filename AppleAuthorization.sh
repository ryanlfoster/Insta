#!/bin/sh
# AppleAuthorization : Payload free. Auth tweaks for 10.7 (and previous OS versions)
# chris.gerke@gmail.com

ME=$0
RES="$1/Contents/Resources"
ROOT="$3"

# // fix
if [ -z "${ROOT}" ] || [ "${ROOT}" = "/" ]; then ROOT=""; fi

# Backup Original
sudo /bin/cp -f "${ROOT}/etc/authorization" "${ROOT}/etc/authorization.original"

# Allow date & time preference pane access.
sudo /usr/libexec/PlistBuddy -c "set rights:system.preferences.datetime:class allow" "${ROOT}/etc/authorization"
sudo /usr/libexec/PlistBuddy -c "delete rights:system.preferences.datetime:shared" "${ROOT}/etc/authorization"
sudo /usr/libexec/PlistBuddy -c "delete rights:system.preferences.datetime:group" "${ROOT}/etc/authorization"

# Allow DVD region setting rights
sudo /usr/libexec/PlistBuddy -c "add rights:system.device.dvd.setregion.change dict" "${ROOT}/etc/authorization"
sudo /usr/libexec/PlistBuddy -c "add rights:system.device.dvd.setregion.change:class string" "${ROOT}/etc/authorization"
sudo /usr/libexec/PlistBuddy -c "set rights:system.device.dvd.setregion.change:class allow" "${ROOT}/etc/authorization"
sudo /usr/libexec/PlistBuddy -c "delete rights:system.device.dvd.setregion.change:shared" "${ROOT}/etc/authorization"
sudo /usr/libexec/PlistBuddy -c "delete rights:system.device.dvd.setregion.change:group" "${ROOT}/etc/authorization"

# Allow DVD region initial setting rights
sudo /usr/libexec/PlistBuddy -c "set rights:system.device.dvd.setregion.initial:class allow" "${ROOT}/etc/authorization"
sudo /usr/libexec/PlistBuddy -c "delete rights:system.device.dvd.setregion.initial:shared" "${ROOT}/etc/authorization"
sudo /usr/libexec/PlistBuddy -c "delete rights:system.device.dvd.setregion.initial:group" "${ROOT}/etc/authorization"

# Allow network preference pane access
sudo /usr/libexec/PlistBuddy -c "set rights:system.preferences.network:class allow" "${ROOT}/etc/authorization"
sudo /usr/libexec/PlistBuddy -c "delete rights:system.preferences.network:shared" "${ROOT}/etc/authorization"
sudo /usr/libexec/PlistBuddy -c "delete rights:system.preferences.network:group" "${ROOT}/etc/authorization"

# Change ${ROOT}/etc/authorization to allow all users to open preference panes
sudo /usr/libexec/PlistBuddy -c "set rights:system.preferences.printing:class allow" "${ROOT}/etc/authorization"
sudo /usr/libexec/PlistBuddy -c "delete rights:system.preferences.printing:shared" "${ROOT}/etc/authorization"
sudo /usr/libexec/PlistBuddy -c "delete rights:system.preferences.printing:group" "${ROOT}/etc/authorization"

# Allow preference panes
sudo /usr/libexec/PlistBuddy -c "set rights:system.preferences:class allow" "${ROOT}/etc/authorization"
sudo /usr/libexec/PlistBuddy -c "delete rights:system.preferences:shared" "${ROOT}/etc/authorization"
sudo /usr/libexec/PlistBuddy -c "delete rights:system.preferences:group" "${ROOT}/etc/authorization"

# Allow print admin rights
sudo /usr/libexec/PlistBuddy -c "set rights:system.print.admin:class allow" "${ROOT}/etc/authorization"
sudo /usr/libexec/PlistBuddy -c "delete rights:system.print.admin:group" "${ROOT}/etc/authorization"
sudo /usr/libexec/PlistBuddy -c "delete rights:system.print.admin:shared" "${ROOT}/etc/authorization"

# Allow printing manager rights
sudo /usr/libexec/PlistBuddy -c "set rights:system.printingmanager:class allow" "${ROOT}/etc/authorization"
sudo /usr/libexec/PlistBuddy -c "delete rights:system.printingmanager:rule" "${ROOT}/etc/authorization"

# Allow admin to unlock screensaver, test this... changed in 10.7
sudo /usr/libexec/PlistBuddy -c "set :rights:system.login.screensaver:comment \"(Use SecurityAgent.) The owner or any administrator can unlock the screensaver.\"" "${ROOT}/etc/authorization"

# Permissions
sudo chown root:wheel "${ROOT}/etc/authorization"
sudo chmod 644 "${ROOT}/etc/authorization"

exit 0