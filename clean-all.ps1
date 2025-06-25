# Clean up all Lazarus build output recursively
# Usage: Run this script from the repo root

# Remove all .ppu, .o, .or, .rst, .compiled, .rsj, .s, .a, .ppl, .bak, .dcu, .dcp, .dres, .drc, .dsk, .map, .dbg, .dmp, .exe, .dll, .so, .dylib, .app, .out, .log, .lps, .lpsbackup, .lps~ files
$patterns = @('*.ppu','*.o','*.or','*.rst','*.compiled','*.rsj','*.s','*.a','*.ppl','*.bak','*.dcu','*.dcp','*.dres','*.drc','*.dsk','*.map','*.dbg','*.dmp','*.exe','*.dll','*.so','*.dylib','*.app','*.out','*.log','*.lps','*.lpsbackup','*.lps~')
foreach ($pattern in $patterns) {
    Get-ChildItem -Path . -Recurse -Include $pattern -File | Remove-Item -Force -ErrorAction SilentlyContinue
}

# Remove bin/ folder if exists
if (Test-Path ./bin) {
    Remove-Item ./bin -Recurse -Force
}

Write-Host "🧹 Clean up complete!"
