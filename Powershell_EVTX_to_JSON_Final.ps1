<#
.SYNOPSIS

This is a powershell script to interate through a user provided directory and parse EVTX files to JSON then output JSON files to a user provided directory
.DESCRIPTION

I felt like doing this

#>

$inputLoc = Read-Host -Prompt 'Input Full Directory Path of EVTX Files to be parsed'
$outputLoc = Read-Host -Prompt 'Input Full Directory Path where you would like you Parsed JSON Files'
$ErrorActionPreference = "Stop"

If (Test-Path $inputLoc) {
    Write-Host "Analyzing $intputLoc"
}
Else{
    Write-Warning "Failed to find or verify $intputLoc" -ErrorAction Stop 
    Break
}


If (Test-Path $outputLoc) {
    Write-Host "Analyzing $outputLoc"
}
Else {
  Write-Warning "Failed to find or verify $outputLoc"
  Write-Warning "Creating $outputLoc"
  New-Item -ItemType directory -Path $outputLoc
}

foreach ($i in gci -Path "$InputLoc" -filter "*.evtx")
        {
            Write-Host -ForegroundColor Yellow "Parsing $sname!"
            $name = ($inputLoc +'\'+ $i)
            $sname = "$i"
            Get-WinEvent -PATH "$name"|ConvertTo-JSON |Out-File ("$outputLoc"+"\"+"$sname"+".json")
        }
        Write-Output 'Done Processing Files'


