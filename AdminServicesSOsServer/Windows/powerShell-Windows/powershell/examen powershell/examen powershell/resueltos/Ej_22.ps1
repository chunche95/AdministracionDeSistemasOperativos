# Ej_22.ps1
# 22. Crear los Usuarios enumerados en el fichero Ej_22_Usuarios.txt.
#     El fichero contiene un usuario por fila y en cada una de ellas
#     los siguientes datos separados por tabulador:
#     - Nombre completo
#     - Nombre
#     - Apellidos
#     - Nombre de usuario
#     - Contraseña
#     - OU a la que pertenece

$cad_con = "LDAP://192.168.56.200"
Set-Location "E:\Documents\Cursos\2011-06 - Administrador de redes\Administrador de redes - Mód. 3 PowerShell\Ejemplos"
$objDom = New-Object `
    System.DirectoryServices.DirectoryEntry($cad_con,'administrador','Pa$$w0rd')

Get-Content -Path ".\Ej_22_Usuarios.txt" | `
    ForEach-Object {
        $datos = $_ -split "`t"
        $nomcompl  = $datos[0]
        $nombre    = $datos[1]
        $apellidos = $datos[2]
        $username  = $datos[3]
        $password  = $datos[4]
        $ou        = $datos[5]
        
        "Creando $username en $ou..."
        $objBusqueda = New-Object System.DirectoryServices.DirectorySearcher($objDom)
        $objBusqueda.Filter = '(&(objectCategory=OrganizationalUnit)(OU='+$ou+'))'
        $resultado = $objBusqueda.FindOne()
        
        $objOU = New-Object System.DirectoryServices.DirectoryEntry($resultado.Path,'administrador','Pa$$w0rd')
        $objUser = $objOU.Create('user','CN='+$nomcompl)
        $objUser.Put('SAMaccountname',$username)
        $objUser.Put('givenName',$nombre)
        $objUser.Put('sn',$apellidos)
        $objUser.SetInfo()
        
        $dnUser = $objUser.Path
        $objUser = New-Object System.DirectoryServices.DirectoryEntry($dnUser,'administrador','Pa$$w0rd')
        $objUser.SetPassword($password)
        $obuUser.SetInfo
    }
