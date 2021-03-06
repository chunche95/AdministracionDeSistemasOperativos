# Ej_20.ps1
# 20. Crear las Unidades Organizativas incluidas en el fichero
#     Ej_20_OU.txt. Este fichero tiene dos posibles valores por fila,
#     separados por punto y coma (;): el primero presenta
#     el nombre de la OU a crear y el segundo, si existe, la OU
#     en la que debe incluirse (s no está es que cuelga del dominio
#     principal raíz)

$cad_con = "LDAP://192.168.56.200"
Set-Location "E:\Documents\Cursos\2011-06 - Administrador de redes\Administrador de redes - Mód. 3 PowerShell\Ejemplos"
$objDom = New-Object `
    System.DirectoryServices.DirectoryEntry($cad_con,'administrador','Pa$$w0rd')

Get-Content -Path ".\Ej_20_OU.txt" | `
    ForEach-Object {
        $datos = $_ -split ";"
        $ou = $datos[0]
        $padre = $datos[1]
        "Creando $ou bajo $padre..."
        if ($padre -eq ""){
            "`tCreando bajo el raíz..."
            $objPadre = New-Object System.DirectoryServices.DirectoryEntry($cad_con,'administrador','Pa$$w0rd')
            
        }else{
            "`tCreando bajo $padre..."
            $objBusqueda = New-Object System.DirectoryServices.DirectorySearcher($objDom)
            $objBusqueda.Filter = '(&(objectCategory=OrganizationalUnit)(OU='+$padre+'))'
            $resultado = $objBusqueda.FindOne()
            $objPadre = New-Object System.DirectoryServices.DirectoryEntry($resultado.Path,'administrador','Pa$$w0rd')
        }
        $objOU = $objPadre.Create('organizationalUnit','OU='+$ou)
        $objOU.Put('description',$ou)
        $objOU.SetInfo()
    }

