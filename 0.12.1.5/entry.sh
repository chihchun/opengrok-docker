#!/bin/bash

function opengrok-reindex () {
    # wait for tomcat to be ready.
    while ! (ss -tln '( sport = :2424 )'|grep ^LISTEN); do
        sleep 1
    done
    echo "*** Updating index"
    OpenGrok index

    while ! [ -z $OPENGROK_REINDEX ] ; do
        inotifywait -mr -e CLOSE_WRITE /src | while read dir mode file; do
            echo "$dir/$file upadted"
            echo "*** Updating index"
            OpenGrok index
        done
    done
}
ln -fs /src /var/opengrok/src
opengrok-reindex &
exec catalina.sh run
