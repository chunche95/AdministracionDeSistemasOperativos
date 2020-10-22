# Ej_19.5.ps1
# 19.5. Mostrar todos los usuarios

$objDom = New-Object `
    System.DirectoryServices.DirectoryEntry('LDAP://192.168.56.200','administrador','Pa$$w0rd')

$objBusqueda = New-Object `
    System.DirectoryServices.DirectorySearcher($objDom)
    $objBusqueda.Filter='(&(objectCategory=person)(objectClass=user))'
$objBusqueda.FindAll()

