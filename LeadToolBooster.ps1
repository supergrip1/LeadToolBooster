$loc = Get-Location
$dirs = Get-ChildItem -Path .\Bilder -Directory
foreach ($dir in $dirs)
{
    $dir = $dir.Name
    $in = "Bilder\$dir\*.jpg"
    $out = "$loc\Bilder"
    #Write-Host $dir
    Write-Host "$in -> $out"
    Start-Process -FilePath ".\LeadTool\LFC.exe" -ArgumentList "$in $out /S /NOUI /EM /F=FILE_JFIF /Q2 /Lconv_jpg-$dir.log"
}
Write-Host ""
$count =  $dirs | Measure-Object | Select-Object Count
Write-Host $count.Count "Lead Tool Prozesse gestartet"

while ($true)
{
    $procCount = Get-Process -Name "LFC" | Measure-Object
    Write-Host $procCount.Count "LeadTool Prozesse noch aktiv"
    Start-Sleep -Seconds 60
    if ($procCount.Count -lt 1)
    {
    break
    }
}