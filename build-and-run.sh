#!/bin/bash
set -e

# Configuration
APP_NAME="PomodoroApp"
BUNDLE_ID="com.example.PomodoroApp"
SIMULATOR_NAME="iPhone 17 Pro"

echo "Finding simulator..."
SIMULATOR_ID=$(xcrun simctl list devices available | grep "$SIMULATOR_NAME" | head -n 1 | grep -oE "[0-9A-F-]{36}")

if [ -z "$SIMULATOR_ID" ]; then
    echo "Simulator $SIMULATOR_NAME not found. Using first available."
    SIMULATOR_ID=$(xcrun simctl list devices available | grep "iPhone" | head -n 1 | grep -oE "[0-9A-F-]{36}")
fi

if [ -z "$SIMULATOR_ID" ]; then
    echo "No iPhone simulator found."
    exit 1
fi

echo "Using Simulator ID: $SIMULATOR_ID"

echo "Booting simulator..."
xcrun simctl boot "$SIMULATOR_ID" || true

echo "Building for iOS Simulator..."
# Note: We use swift build to get the binary, but we need to specify the SDK and target
SDK_PATH=$(xcrun --sdk iphonesimulator --show-sdk-path)
TARGET="arm64-apple-ios17.0-simulator"

# Build specifically for the simulator
swift build -c debug --triple "$TARGET" --sdk "$SDK_PATH" -Xswiftc "-sdk" -Xswiftc "$SDK_PATH" -Xswiftc "-target" -Xswiftc "$TARGET"

# Locate the binary
BIN_PATH=$(swift build -c debug --triple "$TARGET" --sdk "$SDK_PATH" --show-bin-path)/$APP_NAME

echo "Creating App Bundle..."
APP_BUNDLE="$APP_NAME.app"
rm -rf "$APP_BUNDLE"
mkdir -p "$APP_BUNDLE"

# Copy binary
cp "$BIN_PATH" "$APP_BUNDLE/$APP_NAME"

# Copy Info.plist
cp "Info.plist" "$APP_BUNDLE/Info.plist"

# Create PkgInfo
echo "APPL????" > "$APP_BUNDLE/PkgInfo"

# Sign the bundle (required for simulator)
codesign --force --sign - --timestamp=none "$APP_BUNDLE"

echo "Installing on simulator..."
xcrun simctl install "$SIMULATOR_ID" "$APP_BUNDLE"

echo "Launching app..."
xcrun simctl launch "$SIMULATOR_ID" "$BUNDLE_ID"

echo "Done! App launched on simulator $SIMULATOR_ID"
