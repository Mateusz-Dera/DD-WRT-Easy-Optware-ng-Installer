#!/bin/sh

# DD-WRT DD-WRT Easy Optware-ng Installer
# Copyright © 2019-2021 Mateusz Dera

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>

cd /jffs

if ! [ -d "/jffs/opt" ]; then
   mkdir /jffs/opt
fi

mount -o bind /jffs/opt /opt

echo -e "\033[0;32mDD-WRT Easy Optware-ng Installer"
echo -e "Copyright © 2019-2021 Mateusz Dera"
echo -e "\033[1;33m"
echo -e "Detected architecture:"
uname -m
echo -e "\033[0;32m"

if ! [ -x "$(command -v /opt/bin/ipkg update)" ]; then
   echo -e "0 ARMv7 EABI hardfloat"
   echo -e "1 ARMv7 EABI softfloat"
   echo -e "2 ARMv5 EABI"
   echo -e "3 ARMv5 EABI legacy"
   echo -e "4 MIPSEL"
   echo -e "5 PowerPC 603e"
   echo -e "6 PowerPC e500v2"
   echo -e "7 PowerPC I686"
   echo -e "8 PowerPC x86_64"
   read -p $'Number (Default 0): ' arch
   echo -e "\033[0m"

   case $arch in
   "1") link="http://ipkg.nslu2-linux.org/optware-ng/bootstrap/buildroot-armeabi-ng-bootstrap.sh" ;;
   "2") link="http://ipkg.nslu2-linux.org/optware-ng/bootstrap/buildroot-armv5eabi-ng-bootstrap.sh" ;;
   "3") link="http://ipkg.nslu2-linux.org/optware-ng/bootstrap/buildroot-armv5eabi-ng-legacy-bootstrap.sh" ;;
   "4") link="http://ipkg.nslu2-linux.org/optware-ng/bootstrap/buildroot-mipsel-ng-bootstrap.sh" ;;
   "5") link="http://ipkg.nslu2-linux.org/optware-ng/bootstrap/buildroot-ppc-603e-bootstrap.sh" ;;
   "6") link="http://ipkg.nslu2-linux.org/optware-ng/bootstrap/ct-ng-ppc-e500v2-bootstrap.sh" ;;
   "7") link="http://ipkg.nslu2-linux.org/optware-ng/bootstrap/buildroot-i686-bootstrap.sh" ;;
   "8") link="http://ipkg.nslu2-linux.org/optware-ng/bootstrap/buildroot-x86_64-bootstrap.sh" ;;
   *) link="http://ipkg.nslu2-linux.org/optware-ng/bootstrap/buildroot-armeabihf-bootstrap.sh"
   esac
  
   wget -O - $link | sh || exit 1
fi

export PATH=$PATH:/opt/bin:/opt/sbin
/opt/bin/ipkg update

nvram set rc_startup="mount -o bind /jffs/opt /opt"
nvram commit