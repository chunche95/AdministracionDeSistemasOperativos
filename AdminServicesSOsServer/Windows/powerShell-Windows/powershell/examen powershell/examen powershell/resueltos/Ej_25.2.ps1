# Ej_25.2.ps1
# 25.2. Asignar una contraseña aleatoria de 10 caracteres
#       a los de la OU “Navarra”

$OU_obj = "Navarra"

$cad_con = "LDAP://192.168.56.200"
$objDom = New-Object `
    System.DirectoryServices.DirectoryEntry($cad_con,'administrador','Pa$$w0rd')

$objBusqueda = New-Object System.DirectoryServices.DirectorySearcher($objDom)
$objBusqueda.Filter = '(&(objectCategory=OrganizationalUnit)(OU='+$OU_obj+'))'
$resultado = $objBusqueda.FindOne()
$path_obj = $resultado.Path

$objOU = New-Object `
    System.DirectoryServices.DirectoryEntry($path_obj,'administrador','Pa$$w0rd')
$objBusOU = New-Object System.DirectoryServices.DirectorySearcher($objOU)
$objBusOU.Filter = '(objectCategory=Person)'

foreach ($user in $objBusOU.FindAll()){
    $objUser = New-Object `
        System.DirectoryServices.DirectoryEntry($user.Path,'administrador','Pa$$w0rd')
    "Cambiando la contraseña a "+$objUser.cn
    $new_pass = ""
    for ($i=0;$i -le 9;$i++){
        $num=Get-Random -Maximum 126 -Minimum 32
        $new_pass = $new_pass+[char]$num
    }
    "`tNueva contraseña: "+$new_pass
    $objUser.SetPassword($new_pass)
    $objUser.SetInfo()
}
