# Ej_26.5.ps1
# 26.5. Eliminar el grupo “Producción” y los usuarios
#       que pertenezcan a él

$gr_obj = "Producción"

$cad_con = "LDAP://192.168.56.200"
$objDom = New-Object `
    System.DirectoryServices.DirectoryEntry($cad_con,'administrador','Pa$$w0rd')

$objBusqueda = New-Object System.DirectoryServices.DirectorySearcher($objDom)
$objBusqueda.Filter = '(&(objectCategory=group)(CN='+$gr_obj+'))'
$resultado = $objBusqueda.FindOne()
$path_gr_dest = $resultado.Path

"Borrando usuarios del grupo $gr_obj"
$objGrupo = New-Object `
    System.DirectoryServices.DirectoryEntry($path_gr_dest,'administrador','Pa$$w0rd')
foreach ($usr in $objGrupo.Member){
    $path_usr = $cad_con+"/"+$usr
    $objUsr = New-Object `
        System.DirectoryServices.DirectoryEntry($path_usr,'administrador','Pa$$w0rd')
    $path_padre = $objUsr.Parent
    "`tBorrando usuario "+$objUsr.cn
    $objOU = New-Object `
        System.DirectoryServices.DirectoryEntry($path_padre,'administrador','Pa$$w0rd')
    $objOU.Delete('user','CN='+$objUsr.cn)
}
"Borrando grupo $gr_obj"
$path_OU_gr = $path_gr_dest -replace "CN=$gr_obj,",""
$objOU_gr = New-Object `
    System.DirectoryServices.DirectoryEntry($path_OU_gr,'administrador','Pa$$w0rd')
$objOU_gr.Delete('group','CN='+$gr_obj)
