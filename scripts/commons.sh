#!/bin/sh

#
# Common functions for Carbonio frontent development utility commands
#

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