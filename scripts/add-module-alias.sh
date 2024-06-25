#!/bin/bash

source commons.sh

function help() {
	echo "add-module-alias.sh help         show this help"
	echo "add-module-alias.sh ALIAS PATH   add the alias for the given module path"
	echo 
	echo "  Example:        add-module-alias.sh mails ~/development/carbonio/carbonio-mails-ui" 
}


# Arguments check
if [[ " $@ " =~ " help " ]]; then
    help
    exit 0
fi

if [[ $# < 1 || $# > 2 ]]; then
   echo "Wrong number of arguments" 1>&2;
    help
    exit 1
fi

alias=$1
modulePath=$2

# Check if alias already exists
if [ "$(getModulePath $alias)" != "" ]
then
  echo "Alias already exists" 1>&2;
  exit 2
fi

echo -e "$alias\t\t$modulePath" >> $MODULES_ALIAS_FILENAME
