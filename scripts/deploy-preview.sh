#!/bin/bash

echo 
echo "██▄   ▄███▄   █ ▄▄  █    ████▄ ▀▄    ▄     █ ▄▄  █▄▄▄▄ ▄███▄      ▄   ▄█ ▄███▄     ▄ ▄   "
echo "█  █  █▀   ▀  █   █ █    █   █   █  █      █   █ █  ▄▀ █▀   ▀      █  ██ █▀   ▀   █   █  "
echo "█   █ ██▄▄    █▀▀▀  █    █   █    ▀█       █▀▀▀  █▀▀▌  ██▄▄   █     █ ██ ██▄▄    █ ▄   █ "
echo "█  █  █▄   ▄▀ █     ███▄ ▀████    █        █     █  █  █▄   ▄▀ █    █ ▐█ █▄   ▄▀ █  █  █ "
echo "███▀  ▀███▀    █        ▀       ▄▀          █      █   ▀███▀    █  █   ▐ ▀███▀    █ █ █  "
echo "                ▀                            ▀    ▀              █▐                ▀ ▀   "
echo "                                                                 ▐                       "
echo

MODULES=("contacts" "calendars" "mails" "shell" "auth")

function help() {
	echo "deploy-preview help             show this help"
	echo "deploy-preview MODULE           deploy the preview on the selected module"
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

echo "Delopying the preview on $projectPath..."
(cd carbonio-ui-preview && PKG_PATH=../$projectPath/ npm run deploy -u --legacy-peer-deps)
