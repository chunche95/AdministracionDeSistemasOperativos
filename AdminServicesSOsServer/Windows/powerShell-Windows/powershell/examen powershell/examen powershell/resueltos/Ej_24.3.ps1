# Ej_24.3.ps1
# 24.3. Mover los usuarios de la OU "Calanda" a la de "Teruel"

$OU_vieja = "Calanda"
$OU_nueva = "Teruel"

$cad_con = "LDAP://192.168.56.200"
$objDom = New-Object `
    System.DirectoryServices.DirectoryEntry($cad_con,'administrador','Pa$$w0rd')

$objBusqueda = New-Object System.DirectoryServices.DirectorySearcher($objDom)
$objBusqueda.Filter = '(&(objectCategory=OrganizationalUnit)(OU='+$OU_vieja+'))'
$resultado = $objBusqueda.FindOne()
$path_viejo = $resultado.Path
$path_viejo

$objBusqueda.Filter = '(&(objectCategory=OrganizationalUnit)(OU='+$OU_nueva+'))'
$resultado = $objBusqueda.FindOne()
$path_nuevo = $resultado.Path
$path_nuevo

$objOU = New-Object `
    System.DirectoryServices.DirectoryEntry($path_viejo,'administrador','Pa$$w0rd')
$objOUvieja = New-Object System.DirectoryServices.DirectorySearcher($objOU)
$objOUvieja.Filter = '(objectCategory=Person)'
ForEach ($person in $objOUvieja.FindAll()){
    $path_person = $person.Path
    $path_person
    $objPersona = New-Object `
        System.DirectoryServices.DirectoryEntry($path_person,'administrador','Pa$$w0rd')
    $objOUnueva = New-Object `
        System.DirectoryServices.DirectoryEntry($path_nuevo,'administrador','Pa$$w0rd')
    $objOUnueva.MoveHere($path_person,"CN="+$objPersona.cn) >$null
}
