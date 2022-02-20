#!/usr/bin/env bash

# Beautify logs
CHECK_MARK="\033[0;32m\u2713"
ERROR_MARK="\033[0;31m\u2717"

[ `whoami` = root ] || { echo -e "$ERROR_MARK Failed to run script as sudo!"; exit; }

FSTAB=/etc/fstab
set -eu
TOPLEVEL=${1:-$(git rev-parse --show-toplevel)}
USER_BAZELRC=$TOPLEVEL/user.bazelrc

echo "Setting ramdisk.." && sudo mkdir /mnt/ramdisk

echo "Creating additional entry for cache in $FSTAB.."
sed -i '/tmpfs/d' $FSTAB
sed -i '/^$/d' $FSTAB
echo -e "tmpfs  /mnt/ramdisk  tmpfs  rw,size=4G  30  0" >> $FSTAB

echo "Mounting ramdisk.." && sudo mount -a

touch $USER_BAZELRC && echo "build --sandbox_base=/mnt/ramdisk" > $USER_BAZELRC
chmod 664 $USER_BAZELRC

echo -e "$CHECK_MARK \e[1mScript execution succeeded!\e[0m\e[32m\e[39m"
