$root_cache_paths = @(
    ".\site"
)
foreach ($path in $root_cache_paths) {
    if (Test-Path $path) {
        Remove-Item $path -Recurse -Force
    }
}

$recurse_cache_paths = @(
    # "*.lib"
    # "*.a"
    # "*.obj"
    "tempCodeRunnerFile.*"
)
foreach ($path in $recurse_cache_paths) {
    Remove-Item * -Include $path -Recurse -Force
}
