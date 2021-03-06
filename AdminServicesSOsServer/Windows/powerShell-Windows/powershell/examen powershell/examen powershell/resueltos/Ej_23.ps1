# Ej_23.ps1
# 23.Asignar los grupos a los usuarios indicados
#    en el fichero Ej_23_Asig.txt. El fichero está
#    compuesto por filas en las que aparece cada usuario
#    con los grupos a los que pertenece (separados por *
#    y entrecomillados).



$cad_con = "LDAP://192.168.56.200"
Set-Location "E:\Documents\Cursos\2011-06 - Administrador de redes\Administrador de redes - Mód. 3 PowerShell\Ejemplos"
$objDom = New-Object `
    System.DirectoryServices.DirectoryEntry($cad_con,'administrador','Pa$$w0rd')

Get-Content -Path ".\Ej_23_Asig.txt" | `
    ForEach-Object {
        $datos = $_ -split "\*"
        $usuario = $datos[0] -replace "`"",""
        "Usuario "+$usuario
        for ($i = 1; $i -le $datos.length -1; $i++){
            $grupo = $datos[$i] -replace "`"",""
            "`t- Agregando al grupo "+$grupo
            "`t`t Buscando OU del grupo $grupo..."
            $objBusqueda = New-Object System.DirectoryServices.DirectorySearcher($objDom)
            $objBusqueda.Filter = '(&(objectCategory=group)(CN='+$grupo+'))'
            $resultado = $objBusqueda.FindOne()
            $objGrupo = New-Object System.DirectoryServices.DirectoryEntry($resultado.Path,'administrador','Pa$$w0rd')
            "`t`t Buscando $usuario en AD..."
            $objBusqueda = New-Object System.DirectoryServices.DirectorySearcher($objDom)
            $objBusqueda.Filter = '(&(objectCategory=Person)(sAMAccountName='+$usuario+'))'
            $resultado = $objBusqueda.FindOne()
            $objGrupo.Add($resultado.Path)
            $objGrupo.SetInfo()
        }
    }
