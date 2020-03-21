Add-Type -AssemblyName System.IO.Compression.FileSystem

$sdl_devel  = "SDL2-devel.zip"
$sdl_rel64  = "SDL2-reles_x64.zip"
$sdl_rel86  = "SDL2-reles_x86.zip"
$sdl_home   = "SDL2"
$sdl_dist86 = Join-Path (Join-Path $sdl_home "dist") "x86"
$sdl_dist64 = Join-Path (Join-Path $sdl_home "dist") "x64"

function Unzip
{
    param([string]$zipFile, [string]$outpath)

    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipFile, $outpath)
}

If(!(Test-Path $sdl_devel) -and !(Test-Path $sdl_home))
{
    Invoke-WebRequest "https://www.libsdl.org/release/SDL2-devel-2.0.9-VC.zip" -OutFile $sdl_devel
}

If(!(Test-Path $sdl_rel64) -and !(Test-Path $sdl_dist64))
{
    Invoke-WebRequest "https://www.libsdl.org/release/SDL2-2.0.9-win32-x64.zip" -OutFile $sdl_rel64
}

If(!(Test-Path $sdl_rel86) -and !(Test-Path $sdl_dist86))
{
    Invoke-WebRequest "https://www.libsdl.org/release/SDL2-2.0.9-win32-x86.zip" -OutFile $sdl_rel86
}

If(!(Test-Path $sdl_home))
{
    Unzip $sdl_devel (Get-Location)
    Remove-Item -Path $sdl_devel
    Rename-Item -Path "SDL2-2.0.9" -NewName $sdl_home
}

If(!(Test-Path (Join-Path $sdl_dist64 "SDL2.dll")))
{
    Unzip $sdl_rel64 (Get-Location)
    Remove-Item -Path $sdl_rel64
    New-Item -ItemType Directory -Path $sdl_dist64
    Move-Item -Path "README-SDL.txt" -Destination $sdl_dist64
    Move-Item -Path "SDL2.dll" -Destination $sdl_dist64
}

If(!(Test-Path (Join-Path $sdl_dist86 "SDL2.dll")))
{
    Unzip $sdl_rel86 (Get-Location)
    Remove-Item -Path $sdl_rel86
    New-Item -ItemType Directory -Path $sdl_dist86
    Move-Item -Path "README-SDL.txt" -Destination $sdl_dist86
    Move-Item -Path "SDL2.dll" -Destination $sdl_dist86
}
