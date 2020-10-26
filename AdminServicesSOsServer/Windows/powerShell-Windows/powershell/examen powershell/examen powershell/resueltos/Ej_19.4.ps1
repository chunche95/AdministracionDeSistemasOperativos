# Ej_19.4.ps1
# 19.4. Listar los grupos globales existentes

$objDom = New-Object `
    System.DirectoryServices.DirectoryEntry('LDAP://192.168.56.200','administrador','Pa$$w0rd')

$objBusqueda = New-Object `
    System.DirectoryServices.DirectorySearcher($objDom)
    $objBusqueda.Filter='(&(objectCategory=group)(groupType=2147483650))'
$objBusqueda.FindAll()