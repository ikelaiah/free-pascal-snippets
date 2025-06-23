#!/bin/bash
# Build all Lazarus projects (.lpi) recursively
# Usage: Run this script from the repo root

if ! command -v lazbuild &> /dev/null; then
    echo "❌ 'lazbuild' not found in PATH. Please install Lazarus or add lazbuild to your PATH. 🛑"
    exit 1
fi

find . -name "*.lpi" -print0 | while IFS= read -r -d '' file; do
    echo "🔨 Building $file"
    lazbuild "$file" --build-mode=Release
done
echo "✅ All projects built!"
