function Run-CommandLine {
    Param(
        [Parameter(Mandatory=$True,Position=1)][String]$CommandLine,
        [hashtable]$ExitCodeStatus=@{ 0="SUCCESS" },
        [hashtable]$ExitCodeMessage,
        [String]$DefaultStatus="ERROR",
        [String]$DefaultSuccessMessage="",
        [String]$DefaultErrorMessage="",
        [String[]]$ExitOnStatus
    )

    Log-Message "Running command line: $CommandLine"
    $CommandOutput = Invoke-Expression "& $CommandLine"
    # Format output a single string instead of an array of strings when output has multiple lines
    $CommandOutput = $CommandOutput -join "`r`n"
    $CommandOutput = $CommandOutput.Trim()
    if ($CommandOutput -eq "") {
        $CommandOutput = "<none>"
    }

    # Build result object returned by the function
    $Result = New-Object PSObject -Property @{
        ExitCode = $LastExitCode
        Output = $CommandOutput
        Status = ""
        Message = ""
    }

    # Set status for logging. Use the default status unless a particular status associated to the exit code is specified
    $Result.Status = $DefaultStatus
    if ($ExitCodeStatus) {
        if ($ExitCodeStatus.Keys -contains $Result.ExitCode) {
            $Result.Status = $ExitCodeStatus[$Result.ExitCode]
        }
    }

    # Set message for logging. Use the default success/error messages unless a particular message associated to the exit code is specified
    if ($Result.Status -eq "SUCCESS") {
            $Result.Message = $DefaultSuccessMessage
    }
    if ($Result.Status -eq "ERROR") {
            $Result.Message = $DefaultErrorMessage
    }
    if ($ExitCodeMessage) {
        if ($ExitCodeMessage.Keys -contains $Result.ExitCode) {
            $Result.Message = $ExitCodeMessage[$Result.ExitCode]
        }
    }

    if ($Result.Message -ne "") {
        Log-Message "$($Result.Message)" "$($Result.Status)"
    }
    Log-Message "Exit code: $($Result.ExitCode). Command output:`r`n$CommandOutput" "$($Result.Status)"

    # Exit script if the status is one of the statues specified in array $ExitOnStatus
    if ($ExitOnStatus -contains $Result.Status ) {
        Log-Message "Fatal error, exiting script." "$($Result.Status)"
        exit
    }

    return $Result
}
