openssl aes-256-cbc -k "$SECURITY_PASSWORD" -in certs/swifty-mocky-mac-dev.enc -d -a -out certs/swifty-mocky-mac-dev.p12
security create-keychain -p $SECURITY_PASSWORD mac-build.keychain
security default-keychain -s mac-build.keychain
security unlock-keychain -p $SECURITY_PASSWORD mac-build.keychain
security set-keychain-settings -t 600 -l ~/Library/Keychains/mac-build.keychain
security import ./certs/swifty-mocky-mac-dev.p12 -k mac-build.keychain -P $SECURITY_PASSWORD -A
security set-key-partition-list -S apple-tool:,apple: -s -k $SECURITY_PASSWORD mac-build.keychain > /dev/null
