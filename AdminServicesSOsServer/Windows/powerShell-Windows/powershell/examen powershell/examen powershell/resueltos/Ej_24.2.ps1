# Ej_24.2.ps1
# 24.2. Mover el grupo "Ingeniería" del "País Vasco" a "Navarra"

$grupo = "Ingeniería"
$OU_vieja = "País Vasco"
$OU_nueva = "Navarra"

$cad_con = "LDAP://192.168.56.200"
$objDom = New-Object `
    System.DirectoryServices.DirectoryEntry($cad_con,'administrador','Pa$$w0rd')

$objBusqueda = New-Object System.DirectoryServices.DirectorySearcher($objDom)
$objBusqueda.Filter = '(&(objectCategory=OrganizationalUnit)(OU='+$OU_vieja+'))'
$resultado = $objBusqueda.FindOne()
$path_viejo = $resultado.Path
$aux = $path_viejo -replace "$cad_con/",""
$grupo_viejo = $cad_con+"/CN=$grupo,"+$aux

$objBusqueda.Filter = '(&(objectCategory=OrganizationalUnit)(OU='+$OU_nueva+'))'
$resultado = $objBusqueda.FindOne()
$path_nuevo = $resultado.Path

"Mover $grupo_viejo de `n`t$path_viejo `n-->`n`t$path_nuevo"

$objOU = New-Object `
    System.DirectoryServices.DirectoryEntry($path_nuevo,'administrador','Pa$$w0rd')
    
$objOU2 = $objOU.MoveHere($grupo_viejo,'CN='+$grupo)