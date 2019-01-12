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

url="$1"
tmpfile=$(mktemp /tmp/health_check_url.XXXXXX)
exec 3>"$tmpfile"
rm "$tmpfile"
curl -LsSf -o "/dev/null" "$url" 2>"/dev/null"
check $? >&3 || exit 1

exit 0
