#!/bin/sh

#
# Common functions for Carbonio frontend development utility commands
#
CARBONIO_UTILS_HOME=~/.carbonio-dev-utils
MODULES_ALIAS_FILENAME=modules-alias
HOSTS_ALIAS_FILENAME=hosts-alias

# Checks home and creates it if not exists
mkdir -p $CARBONIO_UTILS_HOME

# Available modules
MODULES=("contacts" "calendars" "mails" "addressbook" "shell" "design-system" "auth" "preview" "files")

# Print a list of the names of the available modules
function getModulesListDescription() {
    echo -n "[contacts|calendars|mails|addressbook|shell|design-system|auth|preview|files]"
}

# Print the path of the given module
# param 1 = module name
function getModulePath() {
    module=$1
    if [[ " ${module} " == " design-system " ]]; then
	    echo -n "carbonio-design-system"
    elif [[ " ${module} " == " preview " ]]; then
        echo -n "carbonio-ui-preview"
    else
	    echo -n "carbonio-${module}-ui"
    fi
} 