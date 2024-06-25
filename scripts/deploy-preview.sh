#!/bin/bash

source commons.sh

echo 
echo "██▄   ▄███▄   █ ▄▄  █    ████▄ ▀▄    ▄     █ ▄▄  █▄▄▄▄ ▄███▄      ▄   ▄█ ▄███▄     ▄ ▄   "
echo "█  █  █▀   ▀  █   █ █    █   █   █  █      █   █ █  ▄▀ █▀   ▀      █  ██ █▀   ▀   █   █  "
echo "█   █ ██▄▄    █▀▀▀  █    █   █    ▀█       █▀▀▀  █▀▀▌  ██▄▄   █     █ ██ ██▄▄    █ ▄   █ "
echo "█  █  █▄   ▄▀ █     ███▄ ▀████    █        █     █  █  █▄   ▄▀ █    █ ▐█ █▄   ▄▀ █  █  █ "
echo "███▀  ▀███▀    █        ▀       ▄▀          █      █   ▀███▀    █  █   ▐ ▀███▀    █ █ █  "
echo "                ▀                            ▀    ▀              █▐                ▀ ▀   "
echo "                                                                 ▐                       "
echo

\
function help() {
	echo "deploy-preview.sh help             show this help"
	echo "deploy-preview.sh MODULE_ALIAS     deploy the preview on the selected module"
}

# Arguments check
if [[ " $@ " =~ " help " || $# != 1 ]]; then
    help
    exit 0
fi

# Get the preview project path
coreModulePath=$(getCoreModulePath $CORE_MODULE_PREVIEW)
if [ "$coreModulePath" == "" ]
then
  echo "Error: 'Carbonio Preview UI' core module is not defined" 1>&2;
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

echo "Deploying the 'Carbonio Preview UI' on $destinationProjectPath..."
(eval cd $coreModulePath && PKG_PATH=$destinationProjectPath npm run deploy -u --legacy-peer-deps)
