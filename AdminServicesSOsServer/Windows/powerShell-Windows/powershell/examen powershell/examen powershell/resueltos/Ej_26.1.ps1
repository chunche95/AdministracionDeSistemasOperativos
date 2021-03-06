# Ej_26.1.ps1
# 26.1. Poner en la descripción de los usuarios del
#       Grupo de Contabilidad una indicación que señale
#       esa pertenencia y la página web http://conta.kkfu.com

$gr_obj = "Contabilidad"
$descrip = "Usuario del grupo de Contabilidad"
$url = "http://conta.kkfu.com"

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
    "Poniendo descripción y URL a "+$objUser.cn
    $objUser.Put('description',$descrip)
    $objUser.Put('WWWHomePage',$url)
    $objUser.SetInfo()
}
