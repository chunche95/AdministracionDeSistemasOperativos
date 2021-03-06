# Ej_25.3.ps1
# 25.3. Poner como teléfonos de “Administración”,
#       976222222, 976333333 y 976444444

$gr_obj = "Administración"
$telefonos = "976222222","976333333","976444444"

$cad_con = "LDAP://192.168.56.200"
$objDom = New-Object `
    System.DirectoryServices.DirectoryEntry($cad_con,'administrador','Pa$$w0rd')

$objBusqueda = New-Object System.DirectoryServices.DirectorySearcher($objDom)
$objBusqueda.Filter = '(&(objectCategory=group)(CN='+$gr_obj+'))'
$resultado = $objBusqueda.FindOne()
$path_obj = $resultado.Path

$objGr = New-Object `
    System.DirectoryServices.DirectoryEntry($path_obj,'administrador','Pa$$w0rd')
foreach ($user in $objGr.member){
    $path_user = $cad_con+'/'+$user
    $objUser = New-Object `
        System.DirectoryServices.DirectoryEntry($path_user,'administrador','Pa$$w0rd')
    "Poniendo teléfonos a "+$objUser.cn
    $objUser.PutEx(2,'otherTelephone', $telefonos)
    $objUser.SetInfo()
}