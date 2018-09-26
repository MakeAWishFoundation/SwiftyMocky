
[[ $# > 0 ]] && VERSION="$1" || VERSION="4.2"
[[ $# > 1 ]] && OUTPUT="$2" || OUTPUT="./Pods/Sourcery/bin"

echo "CLONE SOURCERY FOR $VERSION INTO $OUTPUT"
rm -r -f "$OUTPUT"
git clone -b "swift/$VERSION" --single-branch --depth 1 https://github.com/MakeAWishFoundation/SwiftyMocky.wiki.git "$OUTPUT"
