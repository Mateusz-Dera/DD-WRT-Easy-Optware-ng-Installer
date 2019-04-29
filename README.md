# DD-WRT Easy Optware-ng Installer

# Info
  - This script install Optware-ng, create and mount /opt parttion in /jffs/opt and add mount to autostart
  - Tested on Netgear R6400v2 (DD-WRT v3.0-r37305)

# USB Requirements
 - Mounted JFFS partition
 - Optional SWAP partition

# Installation
 - Run: cd /jffs    
 - Run: curl -kLO https://raw.githubusercontent.com/Mateusz-Dera/DD-WRT-Easy-Optware-ng-Installer/master/install.sh && sh ./install.sh
