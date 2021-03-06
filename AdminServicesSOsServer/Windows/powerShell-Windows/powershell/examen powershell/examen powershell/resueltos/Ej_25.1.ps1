# Ej_25.1.ps1
# 25.1. Indicar como correo electrónico de cada usuario,
#       su nombre de usuario y la OU seguida de kkfu.com
#       (es decir, del tipo mrodriguez@buerba.kkfu.com)

$cad_con = "LDAP://192.168.56.200"
$objDom = New-Object `
    System.DirectoryServices.DirectoryEntry($cad_con,'administrador','Pa$$w0rd')

$objBusqueda = New-Object System.DirectoryServices.DirectorySearcher($objDom)
$objBusqueda.Filter = '(objectCategory=Person)'
foreach ($user in $objBusqueda.FindAll()){
    $objUser = New-Object `
        System.DirectoryServices.DirectoryEntry($user.Path,'administrador','Pa$$w0rd')
    $username = $objUser.sAMAccountName
    $matriz = $user.Path -split ","
    $ou = $matriz[1] -replace "OU=",""
    $ou = $ou.ToLower()
    $email = "$username@$ou.kkfu.com"
    
    "Poniendo correo $email a $username..."
    
    $objUser.Put('mail',$email)
    $objUser.SetInfo()
}

