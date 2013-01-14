#!/bin/bash
# chris.gerke@gmail.com

# Power Management, booted volume only
sudo systemsetup -setcomputersleep "60"
sudo systemsetup -setdisplaysleep "15"
sudo systemsetup -setharddisksleep off

# Self destruct?
sudo srm "$0"