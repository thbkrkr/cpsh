#!/bin/bash
#
# GET /ls  List all sh snippets names
#
set -eu

here=$(dirname $(readlink -f $0))

main() {
  local c= dir="_static/curl"
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
