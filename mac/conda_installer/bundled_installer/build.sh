#!/bin/bash
# save as ./build.sh

cd payload
tar cf ../payload.tar ./*
cd ..

if [ -e "payload.tar" ]; then
    gzip payload.tar

    if [ -e "payload.tar.gz" ]; then
        cat decompress payload.tar.gz > cc3d-installer-osx.sh
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
