#!/bin/bash

echo
echo "██▄   ▄███▄   █ ▄▄  █    ████▄ ▀▄    ▄        ▄▄▄▄▄    ▄  █ ▄███▄   █    █     "
echo "█  █  █▀   ▀  █   █ █    █   █   █  █        █     ▀▄ █   █ █▀   ▀  █    █     "
echo "█   █ ██▄▄    █▀▀▀  █    █   █    ▀█       ▄  ▀▀▀▀▄   ██▀▀█ ██▄▄    █    █     "
echo "█  █  █▄   ▄▀ █     ███▄ ▀████    █         ▀▄▄▄▄▀    █   █ █▄   ▄▀ ███▄ ███▄  "
echo "███▀  ▀███▀    █        ▀       ▄▀                       █  ▀███▀       ▀    ▀ "
echo "                ▀                                       ▀                      "
echo
                                                                               


MODULES=("contacts" "calendars" "mails" "auth" "files" "preview")

function help() {
	echo "deploy-shell help             show this help"
	echo "deploy-shell MODULE           deploy the design system on the selected module"
	echo 
	echo "  MODULE        [contacts|calendars|mails|auth|files|preview]"
}


# Arguments check
if [[ " $@ " =~ " help " ]]; then
    help
    exit 0
fi


if [[ $# > 0 ]]; then
  module=$1
else
  help
  exit 1
fi


# Check module argumnent
if [[ ! " ${MODULES[*]} " =~ " ${module} " ]]; then
    echo "Wrong module"
    help
    exit 2
fi

# Get project path
if [[ "$module" = "preview" ]]; then
  projectPath="carbonio-ui-${module}"
else
  projectPath="carbonio-${module}-ui"
fi


echo "Delopying the design system on $projectPath..."
(cd carbonio-shell-ui && PKG_PATH=../$projectPath/ npm run deploy-on-module -u --legacy-peer-deps)
