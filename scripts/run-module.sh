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


function help() {
	echo "run-module.sh help                          show this help"
	echo "run-module.sh MODULE_ALIAS HOST_ALIAS       run the module on the selected server"
}

# Arguments check
if [[ " $@ " =~ " help " ]]; then
    help
    exit 0
fi

if [[ $# < 1 || $# > 2 ]]; then
    help
    exit 1
fi

# Get the module project path
moduleAlias=$1
moduleProjectPath=$(getModulePath $moduleAlias)
if [[ "X$moduleProjectPath" == "X" ]]; then
    echo "Error: Module alias '$moduleAlias' not recognized"  1>&2;
    echo "Run add-module-alias.sh $moduleAlias PROJECT_PATH"  1>&2;
    exit 2
fi

# Get the destination hostname
hostAlias=$2
hostname=$(getHostname $hostAlias)
if [[ "X$hostname" == "X" ]]; then
    echo "Error: Host alias '$hostAlias' not recognized"  1>&2;
    echo "Run add-host-alias.sh $hostAlias HOSTNAME"  1>&2;
    exit 2
fi

(eval cd $moduleProjectPath && npm run start -- -h $hostname)

exit 0



