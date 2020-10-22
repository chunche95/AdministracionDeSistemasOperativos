function Test-Connection {
    Param(
        [Parameter(Mandatory = $True, Position = 1)][String]$Server,
        [Parameter(Mandatory = $True, Position = 2)][String]$Port

    )
    # Create a new Net.Sockets.TcpClient object to use for testing open TCP ports
    $Socket = New-Object Net.Sockets.TcpClient		
    # Suppress error messages
    $ErrorActionPreference = 'SilentlyContinue' 	
    # Try to connect
    $Socket.Connect($Server,$Port)			 	    
    # Make error messages visible again
    $ErrorActionPreference = $MyEAP					
    if ($Socket.Connected) {
        Return $True
        LogMessage "Info : Test Connectivy server $Server : $Port = SUCCESS"
        # Close the socket.
        $Socket.Close()
        # Reset the variable. Apparently necessary.
        $Socket = $null								
    }else {
        Return $false
        LogMessage "ERROR : Test Connectivy server $Server : $Port = ERROR" "ERROR"
        # Reset the variable. Apparently necessary.
        $Socket = $null								
        Exit
    }
}
