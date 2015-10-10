#!/bin/bash
#
# GET /list     List all curl commands
#
set -eu

here=$(dirname $(readlink -f $0))
dir="_static/curl"

main() {
    c=
    echo '['
    while read category; do
        while read cmd; do
            echo $c'"'$category'/'$cmd'"'
            c=,
        done < <(ls $here/$dir/$category)
    done < <(ls $here/$dir)
    echo ']'
}

main
