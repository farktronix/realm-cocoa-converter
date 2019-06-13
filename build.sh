#!/bin/bash

# Custom build tool for Realm Converter
# This was taken from the realm-cocoa build.sh script

# Warning: pipefail is not a POSIX compatible option, but on OS X it works just fine.
#          OS X uses a POSIX complain version of bash as /bin/sh, but apparently it does
#          not strip away this feature. Also, this will fail if somebody forces the script
#          to be run with zsh.
set -o pipefail
set -e

CODESIGN_PARAMS="CODE_SIGN_IDENTITY= CODE_SIGNING_REQUIRED=NO"
XCODEBUILD_FLAGS="COMPILER_INDEX_STORE_ENABLE=NO"
DERIVED_DATA_PATH="build/DerivedData"

xcode() {
    local derivedDataPath="${DERIVED_DATA_PATH}"
    rm -rf $derivedDataPath 
    mkdir -p $derivedDataPath

    CMD="xcodebuild clean build -derivedDataPath $derivedDataPath $@ | bundle exec xcpretty -f `xcpretty-travis-formatter`"
    echo "Building with command:" $CMD
    eval "$CMD"
}

workspace="RealmConverter.xcworkspace"
xcode "-scheme 'RealmConverterMacOS' -sdk macosx -workspace $workspace"
xcode "-scheme 'RealmConverteriOS' -sdk iphoneos -destination 'generic/platform=iOS' -workspace $workspace"
xcode "-scheme 'RealmConverteriOS' -sdk iphonesimulator -destination 'generic/platform=iOS Simulator' -workspace $workspace ONLY_ACTIVE_ARCH=NO"

pod lib lint --quick
