#!/bin/bash

declare -A DATA

logInfo() { echo -e "[\e[92mINFO\e[0m] \e[92m$@\e[0m"; }
logWarn() { echo -e "[\e[93mWARN\e[0m] \e[93m$@\e[0m"; }
logError() { echo -e "[\e[91mERROR\e[0m] \e[91m$@\e[0m"; }
logLoop() {
  while true; do
    case "$1" in
      [Yy]) break;;
      [Nn]) exit 1;;
      *) continue;;
    esac
  done
}
lsblk
read -p "Location disk: " DATA[DISK]
logWarn "This will erase ${DATA[DISK]} !!!"
read -p "`logInfo \"Do you want to continue? [y/N]: \"`" DATA[isYes]
logLoop ${DATA[isYes]}
logInfo "processing..."
