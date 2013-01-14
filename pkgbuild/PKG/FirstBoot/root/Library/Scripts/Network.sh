#!/bin/bash
# chris.gerke@gmail.com

# Network, booted volume only
sudo networksetup -ordernetworkservices "Ethernet" "Wi-Fi" "FireWire"
sudo networksetup -ordernetworkservices "Ethernet" "Wi-Fi" "FireWire" "Bluetooth DUN"
sudo networksetup -ordernetworkservices "Ethernet" "Wi-Fi" "FireWire" "Bluetooth DUN" "Bluetooth PAN"
sudo networksetup -ordernetworkservices "Ethernet" "Airport" "FireWire"
sudo networksetup -ordernetworkservices "Ethernet" "Airport" "FireWire" "Bluetooth DUN"
sudo networksetup -ordernetworkservices "Ethernet" "Airport" "FireWire" "Bluetooth DUN" "Bluetooth PAN"
sudo networksetup -setv6off "Airport"
sudo networksetup -setv6off "Bluetooth Dun"
sudo networksetup -setv6off "Bluetooth Pan"
sudo networksetup -setv6off "Ethernet"
sudo networksetup -setv6off "FireWire"
sudo networksetup -setv6off "Wi-Fi"
sudo networksetup -setnetworkserviceenabled "Bluetooth DUN" "off"
sudo networksetup -setnetworkserviceenabled "Bluetooth PAN" "off"
sudo networksetup -setnetworkserviceenabled "FireWire" "off"
sudo networksetup -setairportpower "en1" "off"

# Self destruct?
sudo srm "$0"