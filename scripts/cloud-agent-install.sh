#!/usr/bin/env bash
set -euo pipefail

export PATH="/opt/flutter/bin:${PATH}"

cd "$(dirname "$0")/.."

flutter pub get
dart run build_runner build
