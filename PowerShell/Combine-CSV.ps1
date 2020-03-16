 <#
    .SYNOPSIS
        A simple script that combines CSV in a given directory

    .EXAMPLE
        .\Combine-CSV.ps1 -SourceDirectory "E:\AI VIDEOS\OUTPUT" -Destination "Delizo" -RemoveFirstLine $true

    .NOTES
        https://github.com/johndelizo/Bunch-of-scripts

    #>

param([string] $SourceDirectory = "", [string] $Destination = "Combined", [bool] $RemoveFirstLine = $true)

clear

if (Test-Path ($SourceDirectory + "\" + $Destination + ".csv")) {
    Remove-Item -Path ($SourceDirectory + "\" + $Destination + ".csv")
}

get-childItem $SourceDirectory -Filter "*.csv" | foreach {
    $filePath = $_.FullName

    if (!(Test-Path ($SourceDirectory + "\" + $Destination + ".csv")) -and $RemoveFirstLine) {
         $headerLines = Get-Content $filePath -First 1
         Add-Content ($SourceDirectory + "\" + $Destination + ".csv") $headerLines
    }

    $lines = $lines = Get-Content $filePath  
    $linesToWrite = switch($RemoveFirstLine) {
           $false {$lines}
           $true {$lines | Select -Skip 1}
    }

    Add-Content ($SourceDirectory + "\" + $Destination + ".csv") $linesToWrite

}