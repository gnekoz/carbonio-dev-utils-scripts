#!/bin/bash

echo 
echo "██▄   ▄███▄   █ ▄▄  █    ████▄ ▀▄    ▄     █▀▄▀█ ████▄ ██▄     ▄   █     ▄███▄"   
echo "█  █  █▀   ▀  █   █ █    █   █   █  █      █ █ █ █   █ █  █     █  █     █▀   ▀"  
echo "█   █ ██▄▄    █▀▀▀  █    █   █    ▀█       █ ▄ █ █   █ █   █ █   █ █     ██▄▄"    
echo "█  █  █▄   ▄▀ █     ███▄ ▀████    █        █   █ ▀████ █  █  █   █ ███▄  █▄   ▄▀" 
echo "███▀  ▀███▀    █        ▀       ▄▀            █        ███▀  █▄ ▄█     ▀ ▀███▀ "
echo "                ▀                            ▀                ▀▀▀"
echo

# Default destination pod of the local k3d cluster
DEFAULT_POD="carbonio-composed-ui-0"

function help() {
	echo "deploy-module-k3d.sh help                 show this help"
	echo "deploy-module-k3d.sh MODULE_ALIAS [POD]   deploy the module on the given pod of carbonio-k3d"
	echo "                                          (default pod: $DEFAULT_POD)"
}


SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
source "$SCRIPT_DIR/commons.sh"

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

# Get the destination pod
pod=${2:-$DEFAULT_POD}

# Deploy
(eval cd $moduleProjectPath && pnpm run deploy -k $pod)

exit 0



