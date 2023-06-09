
<# Extract Zip files using PowerShell 
-------------------------------------#>

try{

# Zip file path
$Path = "C:\Kapil\Technical\Interview_Files.zip"

# change output path to a folder where you want the extracted
# files to appear
$OutPath = 'C:\Kapil\Technical\ZIPFiles'

# ensure the output folder exists
$exists = Test-Path -Path $OutPath
if ($exists -eq $false)
{
  $null = New-Item -Path $OutPath -ItemType Directory -Force
}

# load ZIP methods
Add-Type -AssemblyName System.IO.Compression.FileSystem

# open ZIP archive for reading
$zip = [System.IO.Compression.ZipFile]::OpenRead($Path)

$zip.Entries |
ForEach-Object { 
    # extract the selected items from the ZIP archive
    # and copy them to the out folder
    $FileName = $_.Name
    [System.IO.Compression.ZipFileExtensions]::ExtractToFile($_, "$OutPath\$FileName", $true)
    }

# close ZIP file
$zip.Dispose()

# open out folder
#explorer $OutPath

<# Search text within extracted files 
-------------------------------------#>

Get-ChildItem `
    -Path $OutPath -recurse | `
    Select-String -pattern "PowerShell Exercise" -List | Select Path

}
  catch [System.Exception]
{
Write-Host "Error in Extract zip file process" $_.Exception.Message e-ForegroundColor Red

}