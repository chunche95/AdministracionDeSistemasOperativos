# Ej_21.ps1
# 21. Crear los Grupos de Seguridad Globales enumerados
#     en el fichero Ej_21_Grupos.txt, que dispone de tres
#     datos en cada fila: nombre del grupo, descripción y OU
#     a la que pertenece. Estos datos están separados por
#     pipeline (|)


$cad_con = "LDAP://192.168.56.200"
Set-Location "E:\Documents\Cursos\2011-06 - Administrador de redes\Administrador de redes - Mód. 3 PowerShell\Ejemplos"
$objDom = New-Object `
    System.DirectoryServices.DirectoryEntry($cad_con,'administrador','Pa$$w0rd')

Get-Content -Path ".\Ej_21_Grupos.txt" | `
    ForEach-Object {
        $datos = $_ -split "\|"
        $nombre = $datos[0]
        $descr  = $datos[1]
        $ou     = $datos[2]
        
        "Creando $nombre en $ou..."
        $objBusqueda = New-Object System.DirectoryServices.DirectorySearcher($objDom)
        $objBusqueda.Filter = '(&(objectCategory=OrganizationalUnit)(OU='+$ou+'))'
        $resultado = $objBusqueda.FindOne()
        
        $objOU = New-Object System.DirectoryServices.DirectoryEntry($resultado.Path,'administrador','Pa$$w0rd')
        $objGrupo = $objOU.Create('group','CN='+$nombre)
        $objGrupo.Put('SAMaccountname',$nombre)
        $objGrupo.Put('description',$descr)
        $objGrupo.SetInfo()
    }
