## DD-WRT Easy Optware-ng Installer

### Info:
  - This script install Optware-ng create and mount **/opt** parttion in **/jffs/opt** 
  - NVRAM script mount **/opt** on start
  - Tested on Netgear R6400v2 (DD-WRT v3.0-r46772 std)

### USB Requirements:
 - Mounted JFFS partition
 - Optional SWAP partition

### Installation:
```sh
cd /jffs
curl -kLO https://raw.githubusercontent.com/Mateusz-Dera/DD-WRT-Easy-Optware-ng-Installer/master/install.sh
sh ./install.sh
reboot
```

### Test:
```sh
/opt/bin/ipkg update
/opt/bin/ipkg install nano
```