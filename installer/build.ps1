$ErrorActionPreference = "Stop"

# clean
@(
    'output'
    'directory.wxs'
) |
Where-Object { Test-Path $_ } |
ForEach-Object { Remove-Item $_ -Recurse -Force -ErrorAction Stop }

# create output dir
mkdir output

# get source dir
$source_dir = "..\"

# get package version number
$pkgversion = (Get-Content "$source_dir\package.json" | ConvertFrom-Json).version

$full_path = get-location

# this is your upgrade code and you should keep it for all builds
$guid = New-Guid

if([System.IO.File]::Exists("$full_path\guid.txt")) {
  $guid = Get-Content guid.txt -First 1
}
else {
  Add-Content guid.txt $guid
}

# generate the installer
$wix_dir="c:\Program Files (x86)\WiX Toolset v3.11\bin"

. "$wix_dir\heat.exe" dir $source_dir -srd -dr INSTALLDIR -cg MainComponentGroup -out directory.wxs -ke -sfrag -gg -var var.SourceDir -sreg -scom -t exclude_files.xslt
. "$wix_dir\candle.exe" -dSourceDir="$source_dir" *.wxs -o output\ -ext WiXUtilExtension -dPKGVERSION_NUMBER="$pkgversion" -dGUID="$guid"
. "$wix_dir\light.exe" -o output\installer.msi output\*.wixobj -cultures:en-us -loc en-us.wxl -ext WixUIExtension.dll -ext WiXUtilExtension

# optional digital sign the certificate. 
# you have to previously import it.
#. "C:\Program Files (x86)\Microsoft SDKs\Windows\v7.1A\Bin\signtool.exe" sign /n "Auth10" .\output\installer.msi