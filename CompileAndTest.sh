#!/usr/bin/env bash
set -euo pipefail

DEVICE="${1:-macos}"

clear
flutter pub get
flutter test
flutter run -d "$DEVICE"
