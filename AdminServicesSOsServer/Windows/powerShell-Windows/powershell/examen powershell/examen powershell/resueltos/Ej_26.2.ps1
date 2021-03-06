# Ej_26.2.ps1
# 26.2. Desactivar las cuentas de los usuarios de la OU
#       “Teruel” y las que cuelgan de ella

$OU_obj = "Huesca"

$cad_con = "LDAP://192.168.56.200"
$objDom = New-Object `
    System.DirectoryServices.DirectoryEntry($cad_con,'administrador','Pa$$w0rd')

$objBusqueda = New-Object System.DirectoryServices.DirectorySearcher($objDom)
$objBusqueda.Filter = '(&(objectCategory=OrganizationalUnit)(OU='+$OU_obj+'))'
#$objBusqueda.Filter = '(objectCategory=OrganizationalUnit)'
$resultado = $objBusqueda.FindOne()
$path_OU_obj = $resultado.Path

$objOU = New-Object `
    System.DirectoryServices.DirectoryEntry($path_OU_obj,'administrador','Pa$$w0rd')
$objQryOU = New-Object System.DirectoryServices.DirectorySearcher($objOU)
$objQryOU.Filter = '(objectCategory=OrganizationalUnit)'
foreach ($OU in $objQryOU.FindAll()){
    $objOUs = New-Object `
        System.DirectoryServices.DirectoryEntry($OU.path,'administrador','Pa$$w0rd')
    $objOUs.ou
    $objQryUsr = New-Object System.DirectoryServices.DirectorySearcher($objOUs,'administrador','Pa$$w0rd')
    $objQryUsr.Filter = '(objectCategory=Person)'
    foreach ($usr in $objQryUsr.FindAll()){
        $objUsr = New-Object `
            System.DirectoryServices.DirectoryEntry($usr.Path,'Administrador','Pa$$w0rd')
        "`tDesactivando a "+$objUsr.cn
        $objUsr.PSBase.InvokeSet('AccountDisabled',$False)
        $objUsr.SetInfo()
    }
}
