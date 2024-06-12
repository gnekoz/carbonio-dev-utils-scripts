#!/bin/bash

echo 
echo "██▄   ▄███▄   █ ▄▄  █    ████▄ ▀▄    ▄     ██▄      ▄▄▄▄▄   "
echo "█  █  █▀   ▀  █   █ █    █   █   █  █      █  █    █     ▀▄ "
echo "█   █ ██▄▄    █▀▀▀  █    █   █    ▀█       █   █ ▄  ▀▀▀▀▄   "
echo "█  █  █▄   ▄▀ █     ███▄ ▀████    █        █  █   ▀▄▄▄▄▀    "
echo "███▀  ▀███▀    █        ▀       ▄▀         ███▀             "
echo "                ▀                                           "
echo
                                                            


MODULES=("contacts" "calendars" "mails" "shell" "auth")

function help() {
	echo "deploy-design-system help             show this help"
	echo "deploy-design-system MODULE           deploy the design system on the selected module"
	echo 
	echo "  MODULE        [contacts|calendars|mails|shell|auth]"
}


# Arguments check
if [[ " $@ " =~ " help " ]]; then
    help
    exit 0
fi


if [[ $# > 0 ]]; then
  module=$1
else
  module="shell"
fi


# Check module argumnent
if [[ ! " ${MODULES[*]} " =~ " ${module} " ]]; then
    echo "Wrong module"
    help
    exit 2
fi

# Get project path
projectPath="carbonio-${module}-ui"

echo "Delopying the design system on $projectPath..."
(cd carbonio-design-system && PKG_PATH=../$projectPath/ npm run deploy -u --legacy-peer-deps)
