# Ej_18.5.ps1
# 18.5. Crear los scripts de inicio de sesión de cada uno,
# teniendo en cuenta que tendrán que conectarse a un recurso
# compartido denominado con el nombre del grupo al que pertenecen

Set-Location "F:\Documents\Cursos\2011-06 - Administrador de redes\Administrador de redes - Mód. 3 PowerShell\Ejemplos"
$ruta = "C:\Users\Scripts\"
$unidades="G:","H:","I:","J:","K:","L:","M:","N:","O:","P:"

Get-Content -Path ".\Asig_KKFU_SA.csv" | `
    ForEach-Object {
        $datos = $_ -split ";"
        $usuario = $datos[0]
        $objUser = [ADSI]"WinNT://./$usuario,user"
        $script = $objUser.PSBase.InvokeGet('LoginScript')
        "Creando fichero de inicio "+$script
        New-Item -Path $script -ItemType file >$null
        for ($i = 1; $i -le $datos.length -1; $i++){
            $grupo = $datos[$i]
            $un = $unidades[$i-1]
            "`t- Añadiendo conexión $un a recurso \\SERVIDOR\$grupo"
            $cad_con = "NET USE $un \\SERVIDOR\$grupo"
            Add-Content –Path $script –Value $cad_con
        }
    }

Remove-Variable ruta,unidades,datos,usuario,objUser,i,grupo,un,cad_con
