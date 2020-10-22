# Ej_19.3.ps1
# 19.3. Listar los grupos de seguridad existentes

$objDom = New-Object `
    System.DirectoryServices.DirectoryEntry('LDAP://192.168.56.200','administrador','Pa$$w0rd')

$objBusqueda = New-Object `
    System.DirectoryServices.DirectorySearcher($objDom)
    $objBusqueda.Filter='(objectCategory=group)'
$objBusqueda.FindAll() |Format-Table -Property Path
