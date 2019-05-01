#!/bin/sh

# DD-WRT DD-WRT Easy Optware-ng Installer
# Copyright © 2019 Mateusz Dera

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

echo -e "\e[92;1;48;5;239m ====================================== \e[0m"
echo -e "\e[92;1;48;5;240m |  DD-WRT EASY OPTWARE-NG INSTALLER  | \e[0m"
echo -e "\e[92;1;48;5;241m |  \e[94;1;48;5;241mMateusz Dera  \e[92;1;48;5;241m                    | \e[0m"
echo -e "\e[92;1;48;5;240m | \e[94;1;48;5;240m Version:\e[92;1;48;5;240m 1.0                      | \e[0m"
echo -e "\e[92;1;48;5;239m ====================================== \e[0m"

echo

cd /jffs || exit 1

if ! [ -d "/jffs/opt" ]; then
   mkdir /jffs/opt || exit 1
fi

if ! [ -d "/jffs/etc" ]; then
   mkdir /jffs/etc || exit 1
fi

if ! [ -d "/jffs/etc/config" ]; then
   mkdir /jffs/etc/config || exit 1
fi

mount -o bind /jffs/opt/ /opt/ || exit 1

if ! [ -x "$(command -v /opt/bin/ipkg update)" ]; then
   echo -e "\e[92;1;48;5;239m ================================ \e[0m"
   echo -e "\e[92;1;48;5;240m |  SELECT ROUTER ARCHITECTURE  | \e[0m"
   echo -e "\e[92;1;48;5;242m | \e[94;1;48;5;242m 0\e[92;1;48;5;242m ARMv7 EABI hardfloat      | \e[0m"
   echo -e "\e[92;1;48;5;243m | \e[94;1;48;5;243m 1\e[92;1;48;5;243m ARMv7 EABI softfloat      | \e[0m"
   echo -e "\e[92;1;48;5;244m | \e[94;1;48;5;244m 2\e[92;1;48;5;244m ARMv5 EABI                | \e[0m"
   echo -e "\e[92;1;48;5;245m | \e[94;1;48;5;245m 3\e[92;1;48;5;245m ARMv5 EABI legacy         | \e[0m"
   echo -e "\e[92;1;48;5;244m | \e[94;1;48;5;244m 4\e[92;1;48;5;244m MIPSEL                    | \e[0m"
   echo -e "\e[92;1;48;5;243m | \e[94;1;48;5;243m 5\e[92;1;48;5;243m PowerPC 603e              | \e[0m"
   echo -e "\e[92;1;48;5;242m | \e[94;1;48;5;242m 6\e[92;1;48;5;242m PowerPC e500v2            | \e[0m"
   echo -e "\e[92;1;48;5;241m | \e[94;1;48;5;241m 7\e[92;1;48;5;241m PowerPC I686              | \e[0m"
   echo -e "\e[92;1;48;5;240m | \e[94;1;48;5;240m 8\e[92;1;48;5;240m PowerPC x86_64            | \e[0m"
   echo -e "\e[92;1;48;5;239m ================================ \e[0m\n"
   read -p $'Number (Default 0): ' arch

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

export PATH=$PATH:/opt/bin:/opt/sbin || exit 1
/opt/bin/ipkg update || exit 1

[ -f ./automatic_opt_mount.startup ] && rm automatic_opt_mount.startup
[ -f ./automatic_opt_mount.startup ] && exit 1

cd /jffs/etc/config || exit 1
echo -e "#!/bin/sh\nmount -o bind /jffs/opt/ /opt/" > automatic_opt_mount.startup || exit 1
chmod 700 automatic_opt_mount.startup || exit 1

echo -e "\nInstallation complete!\n"

case $1 in
   "-s") exit 0;;
   *) while true; do
       read -p $'Do you want to reboot your device? (y/n): ' yn
       case $yn in
           [Yy]* ) reboot;;
           [Nn]* ) exit 0;;
           * ) echo -e "Please answer \e[31myes \e[0mor \e[31mno\e[0m.";;
       esac
   done
esac
