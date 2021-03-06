# Ej_26.3.ps1
# 26.3. Indicar como script de inicio de sesión de los usuarios
#       de la OU “Aragón” (y sus dependientes) un archivo con su
#       nombre de inicio de sesión acabado en .cmd (del
#       tipo usuario.cmd)

$OU_obj = "Aragón"

$cad_con = "LDAP://192.168.56.200"
$objDom = New-Object `
    System.DirectoryServices.DirectoryEntry($cad_con,'administrador','Pa$$w0rd')

$objBusqueda = New-Object System.DirectoryServices.DirectorySearcher($objDom)
$objBusqueda.Filter = '(&(objectCategory=OrganizationalUnit)(OU='+$OU_obj+'))'
$resultado = $objBusqueda.FindOne()
$path_OU_obj = $resultado.Path

$objOU = New-Object `
    System.DirectoryServices.DirectoryEntry($path_OU_obj,'administrador','Pa$$w0rd')
$objQryOU = New-Object System.DirectoryServices.DirectorySearcher($objOU)
$objQryOU.Filter = '(objectCategory=Person)'
foreach ($usr in $objQryOU.FindAll()){
    $objUsr = New-Object `
        System.DirectoryServices.DirectoryEntry($usr.Path,'Administrador','Pa$$w0rd')
    "`tScript de inicio para "+$objUsr.cn+" ("+$objUsr.sAMAccountName+")"
    [string]$script = $objUsr.sAMAccountName+".cmd"
    $objUsr.Put('scriptPath',$script)
    $objUsr.SetInfo()
}