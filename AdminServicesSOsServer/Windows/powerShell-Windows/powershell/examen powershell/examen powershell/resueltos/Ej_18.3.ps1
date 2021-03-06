# Ej_18.3.ps1
# 18.3. Asignar a cada usuario un script de inicio de sesión
# con el nombre “usuario.cmd” en el directorio C:\Users\scripts


Set-Location "F:\Documents\Cursos\2011-06 - Administrador de redes\Administrador de redes - Mód. 3 PowerShell\Ejemplos"
$ruta = "C:\Users\Scripts\"

Get-Content -Path ".\Usuarios_KKFU_SA.txt" | `
    ForEach-Object {
        $datos = $_ -split "\|"
        $datos = $datos -replace "`"",""
        $usuario = $datos[1]
        $objUser = [ADSI]"WinNT://./$usuario,user"
        $objUser.PSBase.InvokeSet('LoginScript',$ruta+$usuario+".cmd")
        $objUser.SetInfo()
        "Agregando script al usuario "+$usuario
    }

Remove-Variable ruta,datos,usuario,objUser
