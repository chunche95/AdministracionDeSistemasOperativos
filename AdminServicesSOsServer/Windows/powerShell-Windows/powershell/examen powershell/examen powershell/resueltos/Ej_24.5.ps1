# Ej_24.5.ps1
# 24.5. Renombrar el grupo “Ingeniería” por “Ingeniería e I+D+i”
#       y mover el grupo a la OU “Huesca”

$gr_viejo = "Ingeniería"
$gr_nuevo = "Ingeniería e ImasDmasi"
$OU_nueva = "Huesca"

$cad_con = "LDAP://192.168.56.200"
$objDom = New-Object `
    System.DirectoryServices.DirectoryEntry($cad_con,'administrador','Pa$$w0rd')

$objBusqueda = New-Object System.DirectoryServices.DirectorySearcher($objDom)
$objBusqueda.Filter = '(&(objectCategory=group)(CN='+$gr_viejo+'))'
$resultado = $objBusqueda.FindOne()
$path_grupo = $resultado.Path
"Renombrando $gr_viejo por $gr_nuevo"

$path_padre = $resultado.Path -replace "CN=$gr_viejo,",""
$objGrupo = New-Object `
    System.DirectoryServices.DirectoryEntry($path_padre,'administrador','Pa$$w0rd')
$objGrupo.MoveHere($path_grupo,'CN='+$gr_nuevo)

"Mover a la OU $OU_nueva"
$objBusqueda = New-Object System.DirectoryServices.DirectorySearcher($objDom)
$objBusqueda.Filter = '(&(objectCategory=OrganizationalUnit)(OU='+$OU_nueva+'))'
$resultado = $objBusqueda.FindOne()
$path_nuevo = $resultado.Path

$objBusqueda = New-Object System.DirectoryServices.DirectorySearcher($objDom)
$objBusqueda.Filter = '(&(objectCategory=group)(CN='+$gr_nuevo+'))'
$resultado = $objBusqueda.FindOne()
$path_grupo = $resultado.Path


$objOU = New-Object `
    System.DirectoryServices.DirectoryEntry($path_nuevo,'administrador','Pa$$w0rd')
$objOU.MoveHere($path_grupo,'CN='+$gr_nuevo)
