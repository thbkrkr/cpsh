#!/bin/bash
#
# GET /list  List all sh snippets
#
set -eu

here=$(dirname $(readlink -f $0))
dir="_static/curl"


main() {
  local c1=
  local c1= curl="curl -s" prefix="| bash" urlPath="s/curl"
  echo '['
  while read category; do
    local c2=
    echo $c1'{
      "category":"'$category'",
      "curls": [
    '
    while read cmd; do
      local file=$here/$dir/$category/$cmd
      local param=
      if [[ $(grep -c '^# @param' $file) -ne 0 ]]; then
        param=" -s $(grep '^# @param' $file | sed "s|# @param ||")"
      fi
      local url="$CPL_API/$urlPath/$category/$cmd"
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
