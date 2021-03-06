# Ej_18.10.ps1
# 18.10. Realizar los siguientes listados:
#    - Usuarios de los grupos Administración y Contabilidad
#    - Grupos a los que pertenece Berta Asensio
#    - Todos los usuarios en un fichero de texto separado por ;
#    - Todos los grupos en un fichero de texto separado por tabulador
#    - Cada usuario con sus grupos en un fichero de texto separado por
#      | y delimitado por “

"="*50
"LISTADOS"
"="*50
# Listado de los usuarios del grupo Administración
$grupo = "Administración"
"Listado del grupo $grupo"
"-"*40
$objGrupo = [ADSI]"WinNT://./$grupo,group"
$objGrupo.PSBase.Invoke('Members') | `
    foreach{
        $_.GetType().InvokeMember('Name','GetProperty',$null,$_,$null)
    }

"-"*40

# Listado de los usuarios del grupo Contabilidad
$grupo = "Contabilidad"
"Listado del grupo $grupo"
"-"*40
$objGrupo = [ADSI]"WinNT://./$grupo,group"
$objGrupo.PSBase.Invoke('Members') | `
    foreach{
        $_.GetType().InvokeMember('Name','GetProperty',$null,$_,$null)
    }

"-"*40

# Listado de grupos a los que pertenece Berta Asensio
$objUser = [ADSI]"WinNT://./basensio,user"

"-"*40
# Todos los usuarios en un fichero de texto separado por ;
"Usuarios a fichero de texto"
"-"*40

$conexion = [ADSI]"WinNT://."
$conexion.PSBase.Children | `
    Where-Object {$_.PSBase.SchemaClassName -eq 'user'} | `
    foreach{$_.Name} | `
    Out-File ".\Ej_18.10_Usuarios.txt"

"-"*40
# Todos los grupos en un fichero de texto separado por tabulador
"Grupos a fichero de texto"
"-"*40

$conexion = [ADSI]"WinNT://."
$conexion.PSBase.Children | `
    Where-Object {$_.PSBase.SchemaClassName -eq 'group'} | `
    foreach{$_.Name} >> ".\Ej_18_10_Grupos.txt"
    
