# Ej_24.1.ps1
# 24.1. Renombrar la OU “Alicante” como “Zuera” y
#       moverla a la OU “Zaragoza”

$OU_vieja = "Alicante"
$OU_nueva = "Zuera"
$OU_mover = "Zaragoza"

$cad_con = "LDAP://192.168.56.200"
$objDom = New-Object `
    System.DirectoryServices.DirectoryEntry($cad_con,'administrador','Pa$$w0rd')

$objBusqueda = New-Object System.DirectoryServices.DirectorySearcher($objDom)
$objBusqueda.Filter = '(&(objectCategory=OrganizationalUnit)(OU='+$OU_vieja+'))'
$resultado = $objBusqueda.FindOne()
$path_viejo = $resultado.Path
"- Renombrar OU "+$OU_vieja+" --> "+$OU_nueva
$path_padre = $path_viejo -replace "OU=$OU_vieja,",""

$objOU = New-Object `
    System.DirectoryServices.DirectoryEntry($path_padre,'administrador','Pa$$w0rd')
    
$objOU2 = $objOU.MoveHere($path_viejo,'OU='+$OU_nueva)

"- Mover OU $OU_nueva --> OU $OU_mover"

$objBusqueda.Filter = '(&(objectCategory=OrganizationalUnit)(OU='+$OU_mover+'))'
$resultado = $objBusqueda.FindOne()
$path_padre = $resultado.Path

$objOU = New-Object `
    System.DirectoryServices.DirectoryEntry($path_padre,'administrador','Pa$$w0rd')

$objOU3 = $objOU.MoveHere($objOU2.Path,"OU="+$OU_nueva)    
