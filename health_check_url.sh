#!/bin/bash

function check {
    if [ $1 -ne 0 ] ; then
        echo "Error occurred getting URL $url:"
        case $1 in
            6)
            echo "Unable to resolve host"
            ;;
            7)
            echo "Unable to connect to host"
            ;;
            *)
            echo "Unknown error $1"
        esac
        return 1
    else
        echo "All correct!"
    fi
}

[ ! -z $1 ] && url="$1" || { echo "No url supplied"; exit 2; }
[ ! -z $2 ] && email="$2"
tmpfile=$(mktemp /tmp/health_check_url.XXXXXX)  # must use this to save output of check function
exec 3>"$tmpfile"
rm "$tmpfile"
curl -LsSf -o "/dev/null" "$url" 2>"/dev/null"
check $? >&3 || exit 1  # should email when failing

exit 0
