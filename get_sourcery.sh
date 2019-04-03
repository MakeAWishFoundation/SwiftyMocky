
[[ $# > 0 ]] && VERSION="$1" || VERSION="5.0"
[[ $# > 1 ]] && OUTPUT="$2" || OUTPUT="./Pods/Sourcery/bin"
SOURCERY_VERSION="0.16.0" # The version of Sourcery that is associated with this SwiftyMocky version

echo "CLONE SOURCERY $SOURCERY_VERSION FOR Swift $VERSION INTO $OUTPUT"
rm -r -f "$OUTPUT"
git clone -b "sourcery/$SOURCERY_VERSION-swift$VERSION" --single-branch --depth 1 https://github.com/MakeAWishFoundation/SwiftyMocky.wiki.git "$OUTPUT"
