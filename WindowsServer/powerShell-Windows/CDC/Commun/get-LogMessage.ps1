function LogMessage {
    Param(
        [Parameter(Mandatory = $True, Position = 1)][String]$Message,
        [Parameter(Position = 2)][String]$MessageType = "INFO",
        [Switch]$DoNotWriteMessageToScreen,
        [Switch]$DoNotWriteMessageToLog,
        [Switch]$AppendToUniqueLog,
        [String]$LogFileFolder = "",
        [String]$LogFileName = ""
    )
    # Build full message string
    $Message = "$(Get-Date -format yyyy-MM-dd-HH-mm-ss) $($MessageType.toUpper()) $((Get-Variable MyInvocation -Scope 1).Value.MyCommand.Name) $Message"

    # Write message on screen (if not disabled)
    if (-not $DoNotWriteMessageToScreen) {
        switch ($MessageType) {
            "ERROR" {
                Write-Host $Message -ForegroundColor Red -BackgroundColor Black
            }
            "WARNING" {
                Write-Host $Message -ForegroundColor Yellow
            }
            "SUCCESS" {
                Write-Host $Message -ForegroundColor Green
            }
            default {
                Write-Host $Message
            }
        }
    }

    # Return if writing message in log file is disabled
    if ($DoNotWriteMessageToLog) {
        return
    }

    # Set log file name (if not already set or if a change was requested using function parameters)
    if (((Test-Path variable:script:LogFileName) -eq $false) -or (($LogFileFolder -ne "") -and ($LogFileName -ne ""))) {
        if ($LogFileFolder -eq "") {
            # If log file folder is not specified
            if ($Script:MyInvocation.MyCommand.Path -ne $null) {
                # If the function is called from a script, use the folder of the calling script as the default location
                $LogFileFolder = Split-Path $Script:MyInvocation.MyCommand.Path
            }
            else {
                # else use the temporary folder as the default location
                $LogFileFolder = $env:TEMP
            }

        }

        if ($LogFileName -eq "") {
            # If log file name is not specified, use the name of the calling script with a .log extension as the default file name
            $LogFileName = $Script:MyInvocation.MyCommand.Name
            if ($LogFileName -ne "") {
                # If the function is called from a script, use the name of the calling script as the default log file name
                $LogFileName = $LogFileName.subString(0, $LogFileName.LastIndexOf("."))
            }
            else {
                # else use this as the default log file name
                $LogFileName = "HeHoScript"
            }
            $LogFileName = "$LogFileName.log"
        }

        if (-not $AppendToUniqueLog) {
            # If using a different log file for each execution (not using a unique log file)
            Start-Sleep -s 1    # Wait 1 second to avoid duplicates if this function is called more than once per second
            $LogFileName = "$(Get-Date -f "yyyy-MM-dd-HH-mm-ss")_$LogFileName"  # Prefix the log file name with the current date and time
        }

        if (($LogFileFolder -ne "") -and ($LogFileName -ne "")) {
            $Script:LogFileName = "$LogFileFolder\$LogFileName"
        }
    }

    # Write message to log file
    try {
        $Message | Out-File -FilePath "$($Script:LogFileName)" -Append -Encoding "UTF8"
    }
    catch {
        if ($DoNotWriteMessageToScreen) {
            Write-Host $Message
        }
        Write-Host "Error, unable to write message to log file. Error: $($Error[0])" -ForegroundColor Red -BackgroundColor Black
    }
}
