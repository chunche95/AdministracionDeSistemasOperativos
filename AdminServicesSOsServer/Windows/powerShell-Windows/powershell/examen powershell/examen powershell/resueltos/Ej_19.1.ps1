# Ej_19.1.ps1
# 19.1. Conectar con el servidor de AD

$objDom = New-Object `
    System.DirectoryServices.DirectoryEntry('LDAP://192.168.56.200','administrador','Pa$$w0rd')

$objDom.Path
$objDom |Get-Member