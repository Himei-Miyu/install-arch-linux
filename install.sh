#!/bin/bash

declare -A DATA

logInfo() { echo -e "[\e[92mINFO\e[0m] \e[92m$@\e[0m"; }
logWarn() { echo -e "[\e[93mWARN\e[0m] \e[93m$@\e[0m"; }
logError() { echo -e "[\e[91mERROR\e[0m] \e[91m$@\e[0m"; }

read -p "Location disk: " DATA[DISK]
logWarn "This will erase $DISK !!!"
read -p "`logInfo \"Do you want to continue? [y/N]: \"`"
read -p "`logWarn \"Do you want to continue? [y/N]: \"`"
read -p "`logError \"Do you want to continue? [y/N]: \"`"
