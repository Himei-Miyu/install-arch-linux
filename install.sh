#!/bin/bash

declare -A DATA

logInfo() { echo -e "[\e[92mINFO\e[0m] \e[92m$@\e[0m"; }
logWarn() { echo -e "[\e[93mWARN\e[0m] \e[93m$@\e[0m"; }
logError() { echo -e "[\e[91mERROR\e[0m] \e[91m$@\e[0m"; }
logLoop() {
  while true; do
    read -p "`logInfo \"$@\"`" DATA[isYes]
    case "${DATA[isYes]}" in
      [Yy]) break ;;
      [Nn]) exit 1 ;;
      *) logWarn "Please enter y or n" ;;
    esac
  done
}
lsblk
read -p "`logInfo \"Location disk: \"`" DATA[DISK]
logWarn "This will erase ${DATA[DISK]} !!!"
logLoop "Do you want to continue? [y/N]: "
timedatectl set-ntp true;
parted -s "${DATA[DISK]}" \
  mklabel gpt \
  mkpart ESP fat32 1MiB 513MiB \
  set 1 esp on \
  mkpart primary linux-swap 513MiB 4.5GiB \
  mkpart primary ext4 4.5GiB 100%
[[ "${DATA[DISK]}" =~ [0-9]$ ]] && DATA[DISK_PART]="${DATA[DISK]}p" || DATA[DISK_PART]="${DATA[DISK]}"
mkfs.fat -F32 "${DATA[DISK_PART]}1"
mkswap "${DATA[DISK_PART]}2"
mkfs.ext4 "${DATA[DISK_PART]}3"
swapon "${DATA[DISK_PART]}2"
mount "${DATA[DISK_PART]}3" /mnt
mkdir -p /mnt/boot/efi
mount "${DATA[DISK_PART]}1" /mnt/boot/efi
