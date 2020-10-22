Function Connect-MsolServiceO365 {
	param ( $UserCredential )
	Connect-MsolService -Credential $UserCredential
    Start-Sleep 5
	return $?
}
