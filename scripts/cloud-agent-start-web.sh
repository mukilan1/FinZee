#!/usr/bin/env bash
set -euo pipefail

export PATH="/opt/flutter/bin:${PATH}"

cd "$(dirname "$0")/.."

exec flutter run -d web-server \
  --web-hostname=0.0.0.0 \
  --web-port=8080 \
  --dart-define=FLUTTER_WEB_USE_SKIA=true
