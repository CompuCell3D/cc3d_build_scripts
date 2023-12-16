#!/bin/bash
# save as ./build.sh

echo "all args are $@"
if [ -z "$1" ]; then
  DEFAULT_VRSN='4.5.0'
else
  DEFAULT_VRSN=$1
fi


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
        cat decompress payload.tar.gz > cc3d-installer-osx.sh
        # restore original decompress
        mv decompress.bak decompress
        chmod 755 cc3d-installer-osx.sh
    else
        echo "payload.tar.gz does not exist"
        exit 1
    fi
else
    echo "payload.tar does not exist"
    exit 1
fi

rm -f payload.tar.gz
echo "cc3d-installer-osx created"
exit 0
