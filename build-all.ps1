# Build all Lazarus projects (.lpi) recursively
# Usage: Run this script from the repo root

if (-not (Get-Command lazbuild -ErrorAction SilentlyContinue)) {
    Write-Host "❌ 'lazbuild' not found in PATH. Please install Lazarus or add lazbuild to your PATH. 🛑"
    exit 1
}

Get-ChildItem -Path . -Filter *.lpi -Recurse | ForEach-Object {
    Write-Host "🔨 Building $($_.FullName)"
    & lazbuild $_.FullName --build-mode=Release
}
Write-Host "✅ All projects built!"
