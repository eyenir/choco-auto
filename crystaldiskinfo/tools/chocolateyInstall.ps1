$packageName = '{{PackageName}}'
$forward = 'http://crystalmark.info/redirect.php?product=CrystalDiskInfo'
$fileName = "DiskInfo.exe"
$linkName = "CrystalDiskInfo.lnk"
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url = ((Invoke-WebRequest -Uri $forward -UseBasicParsing).Links | Where-Object {$_.href -like "/frs/redir.php*"} ).href[0] -replace 'amp;', ''
$url = 'http://osdn.jp' + $url

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'zip'
  url           = $url
  softwareName  = $packageName
  checksum      = '{{Checksum}}'
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

#install start menu shortcut
$programs = [environment]::GetFolderPath([environment+specialfolder]::Programs)
$shortcutFilePath = Join-Path $programs $linkName 
$targetPath = Join-Path $toolsDir $fileName
Install-ChocolateyShortcut -shortcutFilePath $shortcutFilePath -targetPath $targetPath