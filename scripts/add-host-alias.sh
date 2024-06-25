#!/bin/bash

source commons.sh

function help() {
	echo "add-host-alias.sh help               show this help"
	echo "add-host-alias.sh ALIAS HOSTNAME     add the alias for the given host"
	echo 
	echo "  Examples:"
    echo "    add-host-alias.sh crb2 crb2.zimbraopen.com" 
    echo "    add-host-alias.sh vm5 co-dev-pry5.demo.zextras.io" 
}


# Arguments check
if [[ " $@ " =~ " help " ]]
then
    help
    exit 0
fi

if [[ $# < 1 || $# > 2 ]]
then
    echo "Wrong number of arguments" 1>&2;
    help
    exit 1
fi

alias=$1
hostname=$2

# Check if alias already exists
if [ "$(getHostname $alias)" != "" ]
then
  echo "Alias already exists" 1>&2;
  exit 2
fi

echo -e "$alias\t\t$hostname" >> $HOSTS_ALIAS_FILENAME
