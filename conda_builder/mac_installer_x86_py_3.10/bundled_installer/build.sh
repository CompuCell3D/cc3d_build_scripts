#!/bin/bash
# save as ./build.sh

echo "all args are $@"
if [ -z "$1" ]; then
  DEFAULT_VRSN='4.8.0'
else
  DEFAULT_VRSN=$1
fi

installer_name="cc3d-installer-osx-${DEFAULT_VRSN}-x86.sh"

# building latest version of demos
demos_symlink_path="Demos"
# Check if the symlink exists
if [ -L "$demos_symlink_path" ]; then
    # Check if the symlink points to a directory
    if [ -d "$demos_symlink_path" ]; then
      echo "OK"
    else
        echo "Error: The symlink does not point to a directory."
        exit 1
    fi
else
    echo "Error: Symlink ${demos_symlink_path} does not exist."
    exit 1
fi
zip -vr ./payload/Demos.zip Demos/ -x "*.DS_Store"


cd payload
tar cf ../payload.tar ./*
cd ..



if [ -e "payload.tar" ]; then
    gzip payload.tar

    if [ -e "payload.tar.gz" ]; then
        # replacing DEFAULT_VERSION in decompress with actual version for which we build installer
        # using portable solution from
        # https://stackoverflow.com/questions/16745988/sed-command-with-i-option-in-place-editing-works-fine-on-ubuntu-but-not-mac
        echo "WILL USE DEFAULT VERSION OF ${DEFAULT_VRSN}"
        # keeps the original decompress, file, as backup file decompress.bak
        sed -i.bak "s/DEFAULT_VERSION=.*/DEFAULT_VERSION=${DEFAULT_VRSN}/" decompress
        cat decompress payload.tar.gz > "${installer_name}"
        # restore original decompress
        mv decompress.bak decompress
        chmod 755 "${installer_name}"
    else
        echo "payload.tar.gz does not exist"
        exit 1
    fi
else
    echo "payload.tar does not exist"
    exit 1
fi

rm -f payload.tar.gz
echo "${installer_name} created"
exit 0
