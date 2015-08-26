#!/usr/bin/bash

# depends on "lnif" function (which depends on explicit $HOME paths); 
# see separate bash repo
source $BASH_CUSTOM_FUNCTIONS_FILE

CURRENT_DIR=$(pwd)

#···············································································
#   SETUP DESKTOP ENTRIES AND ICONS
#···············································································

LAUNCH_BASE_DIR='/z/750/dot/repos/workstation-arbitrary/config/generic/freedesktop/desktop_entries'
LAUNCH_EDIT="$LAUNCH_BASE_DIR/launchers_editable"

SRC_LAUNCH="$LAUNCH_BASE_DIR/src_launch"
TGT_LAUNCH='/home/rigel/.local/share/applications/00_custom_launchers'
# hard-code the above path in the "validate_launchers" fish function as well

SRC_ICON="$LAUNCH_BASE_DIR/src_icons"
TGT_ICON='/home/rigel/.local/share/icons/00_custom_launcher_icons'

cd $LAUNCH_EDIT
echo "Looping through desktop entries ..."
for ENTRY_EDIT in *.ini; do
    ENTRY_BASE=$(basename -s .ini "$ENTRY_EDIT")
    lnif "$LAUNCH_EDIT/$ENTRY_EDIT" "$SRC_LAUNCH/$ENTRY_BASE.desktop"
done

cd $SRC_LAUNCH
echo "Validating launchers ..."
desktop-file-validate --warn-kde *.desktop

# look for any new options if the utility gets updated
# could be interesting to have a way to ping the spec page to check for updates to the standard
echo "Checking if the validator has been updated with additional flags ..."
desktop-file-validate --help

lnif "$SRC_LAUNCH"  "$TGT_LAUNCH"
lnif "$SRC_ICON"    "$TGT_ICON"

#···············································································
#   SETUP XDG_DIRS
#···············································································

XDG_DIRS_BASE='/z/750/dot/repos/workstation-arbitrary/config/generic/freedesktop/directories'

lnif "$XDG_DIRS_BASE/user_dirs_file.bash" '/home/rigel/.config/user-dirs.dirs'

XDG_CLOSED='/z/750/home_xdg_src'

cd $XDG_CLOSED
echo "Looping through closed xdg directories ..."
for XDG_DIR in *; do
    # add .rsyncignore for system backup function
    lnif "$XDG_CLOSED/$XDG_DIR" "/home/rigel/$XDG_DIR"
done

lnif "$LAUNCH_BASE_DIR/template.desktop_actions.ini" "$XDG_DIRS_BASE/Templates/quasi_active/desktop_actions.ini"

# add .rsyncignore for system backup function
lnif "$XDG_DIRS_BASE/Templates" '/home/rigel/Templates'

#···············································································
#   SETUP GTK DIRS
#···············································································

lnif '/z/750/dot/repos/workstation-arbitrary/config/generic/gtk/gtk3_conf' '/home/rigel/.config/gtk-3.0'

#···············································································
#   SETUP AUX ITEMS
#···············································································

lnif '/z/750/dot/repos/workstation-arbitrary/aux/workstation/fish_functions/validate_launchers.fish' \
'/z/750/dot/repos/shell-fish/config/workstation/generic/ln_src_func_shared/functions/open/misc/validate_launchers.fish'

#···············································································
cd $CURRENT_DIR

