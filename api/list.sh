#!/bin/bash
#
# GET /list     List all curl commands
#
set -eu

here=$(dirname $(readlink -f $0))
dir="_static/curl"

curl="curl -s"
prefix="| bash"
urlPath="s/curl"

main() {
    c1=
    echo '['
    while read category; do
        c2=
        echo $c1'{
            "category":"'$category'",
            "curls": [
        ' 
        while read cmd; do
            file=$here/$dir/$category/$cmd
            param=
            if [[ $(grep -c '^# @param' $file) -ne 0 ]]; then
                param=" -s $(grep '^# @param' $file | sed "s|# @param ||")"
            fi
            url="$CPL_API/$urlPath/$category/$cmd"
            echo $c2'{
                "name": "'$cmd'",
                "url": "'$url'",
                "curl": "'$curl $url $prefix$param'"
            }'
            c2=,
        done < <(ls $here/$dir/$category)
        c1=,
        echo ']}'
    done < <(ls $here/$dir)
    echo ']'
}

main
