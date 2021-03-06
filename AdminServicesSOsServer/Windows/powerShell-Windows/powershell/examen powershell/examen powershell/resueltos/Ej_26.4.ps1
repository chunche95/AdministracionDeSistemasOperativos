# Ej_26.4.ps1
# 26.4. Crear un grupo llamado “Comercial” que estará en la
#       OU “Zaragoza” y cuyos miembros sean los de “Utebo”

$gr_nuevo = "Comercial"
$OU_dest  = "Zaragoza"
$OU_orig  = "Utebo"

# Crear el grupo $gr_nuevo en $OU_dest
"Creando $gr_nuevo en $OU_dest"

$cad_con = "LDAP://192.168.56.200"
$objDom = New-Object `
    System.DirectoryServices.DirectoryEntry($cad_con,'administrador','Pa$$w0rd')

$objBusqueda = New-Object System.DirectoryServices.DirectorySearcher($objDom)
$objBusqueda.Filter = '(&(objectCategory=OrganizationalUnit)(OU='+$OU_dest+'))'
$resultado = $objBusqueda.FindOne()
$path_OU_dest = $resultado.Path
"`t-->OU destino: $path_OU_dest"

$objOU_dest = New-Object `
    System.DirectoryServices.DirectoryEntry($path_OU_dest,'administrador','Pa$$w0rd')
$objGrupo = $objOU_dest.Create('group','CN='+$gr_nuevo)
$objGrupo.Put('SAMaccountName',$gr_nuevo)
$objGrupo.Put('description','Grupo de '+$gr_nuevo)
$objGrupo.Put('groupType','2147483650')
$objGrupo.SetInfo()

"`t-->Agregar usuarios de $OU_orig"

$objBusqueda = New-Object System.DirectoryServices.DirectorySearcher($objDom)
$objBusqueda.Filter = '(&(objectCategory=OrganizationalUnit)(OU='+$OU_orig+'))'
$resultado = $objBusqueda.FindOne()
$path_OU_orig = $resultado.Path

$objOU_orig = New-Object `
    System.DirectoryServices.DirectoryEntry($path_OU_orig,'administrador','Pa$$w0rd')
$objQryOU = New-Object System.DirectoryServices.DirectorySearcher($objOU_Orig)
$objQryOU.Filter = '(objectCategory=Person)'
foreach ($usr in $objQryOU.FindAll()){
    $usr.Path
    $objGrupo.Add($usr.Path)
}
$objGrupo.SetInfo()
