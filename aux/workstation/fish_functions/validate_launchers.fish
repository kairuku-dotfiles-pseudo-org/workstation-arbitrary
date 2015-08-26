function validate_launchers -d "self-explanatory?"

    set PWD_CACHE (pwd)
    cd  /home/rigel/.local/share/applications/00_custom_launchers

    desktop-file-validate --warn-kde *.desktop
    cd $PWD_CACHE

end
