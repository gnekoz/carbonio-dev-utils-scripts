#!/bin/bash

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
source "$SCRIPT_DIR/commons.sh"

projectsPaths=()
for index in "${!CORE_MODULES[@]}"
do
    coreModule=${CORE_MODULES[$index]}
    read -p "Enter path for '$coreModule' project (empty string to skip): " projectPath
    projectsPaths[$index]=$projectPath
done

if  [ ${#projectsPaths[@]} == 0 ]
then
    exit 1
fi

# Resets the file
echo "" > $CORE_MODULES_ALIAS_FILENAME

# Appends lines
for index in "${!CORE_MODULES[@]}"
do
    alias=${CORE_MODULES[$index]}
    projectPath=${projectsPaths[$index]}
    if [ "$projectPath" != "" ]
    then
        echo -e "$alias\t\t$projectPath" >> $CORE_MODULES_ALIAS_FILENAME 
    fi
done


