#!/bin/bash

bookmarksf="$HOME/.Scripts/bookmarks"


input="$2"
addnew() {
    echo $input >> $bookmarksf
}

duckgo() {
menu="dmenu -i -l 10 -h 24 -p "DuckDuckGo""
items=$($search | $menu )

 [ -n "$items" ] && firefox duckduckgo/"$items" || exit 0
}

yt() {
menu="dmenu -i -l 10 -h 24 -p "YouTube""
items=$($search | $menu )

 [ -n "$items" ] && firefox https://www.youtube.com/results?search_query="$items" || exit 0
}

bookmarks() {
menu="dmenu -i -l 10 -h 24 -p "Bookmarks""
items=$(cat $bookmarksf | awk -F "-" '{print $1}' | $menu )

bms=$(cat $bookmarksf | grep "$items" | awk -F "-" '{print $2}')

[ -n "$items" ] && firefox $bms || exit 0

}

rbookmark() {
menu="dmenu -i -l 10 -p "Remove-a-Bookmarks""
items=$(cat $bookmarksf | awk -F "-" '{print $1}' | $menu )

[ -n "$items" ] && sed -i "/$items/d" "$bookmarksf" || exit 0
echo $items $bookmarksf

}

while getopts a:bdyr option; do
    case "${option}" in
        a) addnew && exit 0 ;;
        b) bookmarks ;;
        d) duckgo ;;
        y) yt ;;
        r) rbookmark && exit 0 ;;
    esac
done

