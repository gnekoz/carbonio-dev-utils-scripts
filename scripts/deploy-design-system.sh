#!/bin/bash

echo 
echo "██▄   ▄███▄   █ ▄▄  █    ████▄ ▀▄    ▄     ██▄      ▄▄▄▄▄   "
echo "█  █  █▀   ▀  █   █ █    █   █   █  █      █  █    █     ▀▄ "
echo "█   █ ██▄▄    █▀▀▀  █    █   █    ▀█       █   █ ▄  ▀▀▀▀▄   "
echo "█  █  █▄   ▄▀ █     ███▄ ▀████    █        █  █   ▀▄▄▄▄▀    "
echo "███▀  ▀███▀    █        ▀       ▄▀         ███▀             "
echo "                ▀                                           "
echo
                                                            

function help() {
	echo "deploy-design-system.sh help             show this help"
	echo "deploy-design-system.sh MODULE_ALIAS     deploy the design system on the selected module"
}


SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
source "$SCRIPT_DIR/commons.sh"

# Arguments check
if [[ " $@ " =~ " help " || $# != 1 ]]; then
    help
    exit 0
fi

# Get the DS project path
dsPath=$(getCoreModulePath $CORE_MODULE_DS)
if [ "$dsPath" == "" ]
then
  echo "Error: Carbonio design system core module is not defined" 1>&2;
  echo "Run setup-core-modules-alias.sh" 1>&2;
  exit 1
fi

# Get the destination module project path
alias=$1
destinationProjectPath=$(getModulePath $alias)
if [[ "X$destinationProjectPath" == "X" ]]; then
    echo "Error: Module alias '$alias' not recognized"  1>&2;
    echo "Run add-module-alias.sh $alias PROJECT_PATH"  1>&2;
    exit 2
fi

echo "Deploying the design system on $destinationProjectPath..."
(eval cd $dsPath && PKG_PATH=$destinationProjectPath npm run deploy -u --legacy-peer-deps)
