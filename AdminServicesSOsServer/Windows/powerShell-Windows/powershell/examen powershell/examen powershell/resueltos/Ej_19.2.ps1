# Ej_19.2.ps1
# 19.2. Mostrar todas las Unidades Organizativas

$objDom = New-Object `
    System.DirectoryServices.DirectoryEntry('LDAP://192.168.56.200','administrador','Pa$$w0rd')

$objBusqueda = New-Object `
    System.DirectoryServices.DirectorySearcher($objDom)
    $objBusqueda.Filter='(objectCategory=OrganizationalUnit)'
$objBusqueda.FindAll() |Format-List -Property Path
