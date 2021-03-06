# Ej_24.4.ps1
# 24.4. Eliminar la OU “Calanda”

$OU_del = "Calanda"

$cad_con = "LDAP://192.168.56.200"
$objDom = New-Object `
    System.DirectoryServices.DirectoryEntry($cad_con,'administrador','Pa$$w0rd')

$objBusqueda = New-Object System.DirectoryServices.DirectorySearcher($objDom)
$objBusqueda.Filter = '(&(objectCategory=OrganizationalUnit)(OU='+$OU_del+'))'
$resultado = $objBusqueda.FindOne()

"Eliminando "+$resultado.Path
$path_padre = $resultado.Path -replace "OU=$OU_del,",""

$objOU = New-Object `
    System.DirectoryServices.DirectoryEntry($path_padre,'administrador','Pa$$w0rd')
$objOU.Delete('organizationalUnit','OU='+$OU_del)
