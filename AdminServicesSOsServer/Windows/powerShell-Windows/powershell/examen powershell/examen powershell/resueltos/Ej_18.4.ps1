# Ej_18.4.ps1
# 18.4. Asignar a cada usuario los grupos a los que pertenece (fichero
# http://cursos.integra-gestion.com/AdeR/material/Asig_KKFU_SA.csv,
# delimitado por ;)

Set-Location "F:\Documents\Cursos\2011-06 - Administrador de redes\Administrador de redes - Mód. 3 PowerShell\Ejemplos"

Get-Content -Path ".\Asig_KKFU_SA.csv" | `
    ForEach-Object {
        $datos = $_ -split ";"
        $usuario = $datos[0]
        "Usuario "+$usuario
        for ($i = 1; $i -le $datos.length -1; $i++){
            $grupo = $datos[$i]
            "`t- Agregando al grupo "+$grupo
            $objGrupo = [ADSI]"WinNT://./$grupo,group"
            $objGrupo.Add("WinNT://$usuario")
        }
    }

Remove-Variable datos,usuario,grupo,objGrupo
