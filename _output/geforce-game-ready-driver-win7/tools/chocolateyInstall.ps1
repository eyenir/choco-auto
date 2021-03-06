$packageName = 'geforce-game-ready-driver-win7'
$version = '373.06'
$fileType = 'exe'
$silentArgs = '-s -noreboot'
$unpackDir = New-Item "${ENV:TEMP}\nvidiadriver" -ItemType Directory -Force
$unpackFile = "${ENV:TEMP}\nvidiadriver.zip"
$setupFile = Join-Path "$unpackDir" "setup.exe"

$url = "http://us.download.nvidia.com/Windows/$version/$version-desktop-win8-win7-32bit-international-whql.exe"
$url64 = "http://us.download.nvidia.com/Windows/$version/$version-desktop-win8-win7-64bit-international-whql.exe"


Get-ChocolateyWebFile $packageName $unpackFile $url $url64 -Checksum 4d919089dddfef6448c8764784c53970c6fb84383ca093ff25fec6bb988553ca -ChecksumType 'sha256' -Checksum64 327355c60c182a685b1e40875827ea3d2d3e898f3306303886325574a5564a1a -ChecksumType64 'sha256'
Get-ChocolateyUnzip $unpackFile $unpackDir
Remove-Item $unpackDir\Update.Core -Recurse -Force
Remove-Item $unpackDir\Display.Update -Recurse -Force
Remove-Item $unpackDir\ShadowPlay -Recurse -Force
Install-ChocolateyInstallPackage $packageName $fileType $silentArgs $setupFile
Remove-Item $unpackDir -Recurse -Force
