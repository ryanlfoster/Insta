#!/bin/bash

sudo systemsetup -setcomputersleep "60"
sudo systemsetup -setdisplaysleep "15"
sudo systemsetup -setharddisksleep off

sudo srm "$0"