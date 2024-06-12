#!/bin/bash

source commons.sh

echo 
echo "█▄▄▄▄  ▄      ▄       █▀▄▀█ ████▄ ██▄     ▄   █     ▄███▄   "
echo "█  ▄▀   █      █      █ █ █ █   █ █  █     █  █     █▀   ▀  "
echo "█▀▀▌ █   █ ██   █     █ ▄ █ █   █ █   █ █   █ █     ██▄▄    "
echo "█  █ █   █ █ █  █     █   █ ▀████ █  █  █   █ ███▄  █▄   ▄▀ "
echo "  █  █▄ ▄█ █  █ █        █        ███▀  █▄ ▄█     ▀ ▀███▀   "
echo " ▀    ▀▀▀  █   ██       ▀                ▀▀▀                "
echo

DESTINATIONS=("crb1" "crb2" "vm")
DEFAULT_VM_NUMBER="5"
PORT="9000"

function help() {
	echo "run-module help                               show this help"
	echo "run-module MODULE DESTINATION [VM_NUMBER]     run the module on the selected server"
	echo 
	echo "  MODULE        $(getModulesListDescription)" 
	echo "  DESTINATION   [crb1|crb2|vm]"
	echo "  VM_NUMBER     number of the vm. E.g. 5 corresponds to co-dev-pry"
}


# Arguments check
if [[ " $@ " =~ " help " ]]; then
    help
    exit 0
fi

if [[ $# < 2 ]]; then
    echo "Too few parameters"
    help
    exit 1
fi

module=$1
destination=$2
vm=$3

# Check module argument
if [[ ! " ${MODULES[*]} " =~ " ${module} " ]]; then
    echo "Wrong module"
    help
    exit 2
fi


# Check destination argument
if [[ ! " ${DESTINATIONS[*]} " =~ " ${destination} " ]]; then
    echo "Wrong destination"
    help
    exit 3
fi


# Check virtual machine number
if [[ "x${vm}x" = "xx" ]]; then
  vm=$DEFAULT_VM_NUMBER
fi


projectPath=$(getModulePath $module)


server=""

case "$destination" in 
	"crb1" | "crb2")
		server="${destination}.zimbraopen.com"
		;;

	"vm")
		server="co-dev-pry${vm}.demo.zextras.io"
		;;

esac

(cd "$projectPath" && npm run start -- -h $server -p $PORT)

exit 0



