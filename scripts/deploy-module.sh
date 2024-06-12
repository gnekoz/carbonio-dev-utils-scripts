#!/bin/bash

source commons.sh

echo 
echo "██▄   ▄███▄   █ ▄▄  █    ████▄ ▀▄    ▄     █▀▄▀█ ████▄ ██▄     ▄   █     ▄███▄"   
echo "█  █  █▀   ▀  █   █ █    █   █   █  █      █ █ █ █   █ █  █     █  █     █▀   ▀"  
echo "█   █ ██▄▄    █▀▀▀  █    █   █    ▀█       █ ▄ █ █   █ █   █ █   █ █     ██▄▄"    
echo "█  █  █▄   ▄▀ █     ███▄ ▀████    █        █   █ ▀████ █  █  █   █ ███▄  █▄   ▄▀" 
echo "███▀  ▀███▀    █        ▀       ▄▀            █        ███▀  █▄ ▄█     ▀ ▀███▀ "
echo "                ▀                            ▀                ▀▀▀"
echo

function help() {
	echo "deploy-module help                  show this help"
	echo "deploy-module MODULE [VMNUMBER]     run the module on the selected VM"
	echo 
	echo "  MODULE        $(getModulesListDescription)" 
	echo "  VMNUMBER      (dafault 5) eg. 5 for co-dev-pry5.demo.zextras.io"
}


# Arguments check
if [[ " $@ " =~ " help " ]]; then
    help
    exit 0
fi

if [[ $# < 1 && $# > 2 ]]; then
    help
    exit 1
fi

module=$1

if [[ $# -eq 2 ]]; then
  destination=$2
else
  destination=5
fi


# Check module argumnent
if [[ ! " ${MODULES[*]} " =~ " ${module} " ]]; then
    echo "Wrong module"
    help
    exit 2
fi

# Get project path
projectPath=$(getModulePath $module)

# Compose server name
server="co-dev-pry${destination}.demo.zextras.io"



(cd $projectPath && npm run deploy -- -h $server)

exit 0



