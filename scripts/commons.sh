#!/bin/sh

#
# Common functions for Carbonio frontend development utility commands
#
CARBONIO_UTILS_HOME=~/.carbonio-dev-utils
MODULES_ALIAS_FILENAME=$CARBONIO_UTILS_HOME/modules-alias
HOSTS_ALIAS_FILENAME=$CARBONIO_UTILS_HOME/hosts-alias
CORE_MODULES_ALIAS_FILENAME=$CARBONIO_UTILS_HOME/core-modules-alias


# Available core modules
CORE_MODULE_DS="ds"
CORE_MODULE_SHELL="shell"
CORE_MODULE_PREVIEW="preview"
CORE_MODULES=($CORE_MODULE_SHELL $CORE_MODULE_DS $CORE_MODULE_PREVIEW)

# Checks home and creates it if not exists
mkdir -p $CARBONIO_UTILS_HOME

# Available modules
MODULES=("contacts" "calendars" "mails" "addressbook" "shell" "design-system" "auth" "preview" "files")

# Print a list of the names of the available modules
function getModulesListDescription() {
    echo -n "[contacts|calendars|mails|addressbook|shell|design-system|auth|preview|files]"
}

# Print the path of the given core module alias
# param 1 = module alias
function getCoreModulePath() {
    if [ ! -f $CORE_MODULES_ALIAS_FILENAME ]
    then
        return 1
    fi
    alias=$1
    sedScript="s/^$alias[[:space:]]+(.*)$/\1/p"
    echo -n $(sed -Ern $sedScript < $CORE_MODULES_ALIAS_FILENAME)
} 

# Print the path of the given module alias
# param 1 = module alias
function getModulePath() {
    if [ ! -f $MODULES_ALIAS_FILENAME ]
    then
        return 1
    fi
    alias=$1
    sedScript="s/^$alias[[:space:]]+(.*)$/\1/p"
    echo -n $(sed -Ern $sedScript < $MODULES_ALIAS_FILENAME)
} 

# Print the hostname of the given host alias
# param 1 = host alias
function getHostname() {
    if [ ! -f $HOSTS_ALIAS_FILENAME ]
    then
        return 1
    fi

    alias=$1
    sedScript="s/^$alias[[:space:]]+(.*)$/\1/p"
    echo -n $(sed -Ern $sedScript < $HOSTS_ALIAS_FILENAME)
} 