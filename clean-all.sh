#!/bin/bash
# Clean up all Lazarus build output recursively
# Usage: Run this script from the repo root

patterns=("*.ppu" "*.o" "*.or" "*.rst" "*.compiled" "*.rsj" "*.s" "*.a" "*.ppl" "*.bak" "*.dcu" "*.dcp" "*.dres" "*.drc" "*.dsk" "*.map" "*.dbg" "*.dmp" "*.exe" "*.dll" "*.so" "*.dylib" "*.app" "*.out" "*.log" "*.lps" "*.lpsbackup" "*.lps~")

for pattern in "${patterns[@]}"; do
    find . -type f -name "$pattern" -delete
done

# Remove bin/ folder if exists
if [ -d ./bin ]; then
    rm -rf ./bin
fi

echo "🧹 Clean up complete!"
