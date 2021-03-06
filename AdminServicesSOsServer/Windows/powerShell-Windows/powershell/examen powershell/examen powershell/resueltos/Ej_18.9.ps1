# Ej_18.9.ps1
# 18.9. Cambiar el nombre de inicio de sesión de los
# siguientes usuarios:
#    Cristóbal Carbajal (ccarbajal) = cristobal
#    Manuel Rodríguez (mrodriguez) = manolo
#    Remedios Iglesias (riglesias) = queremedio

$users = @{"ccarbajal"="cristobal";
           "mrodriguez"="manolo";
           "riglesias"="queremedio"
          }

foreach ($usuario in $users.Keys){
    "Cambiando el nombre de $usuario por "+$users[$usuario]
    $objUser = [ADSI]"WinNT://./$usuario,user"
    $objUser.Rename($users[$usuario])
    $objUser.SetInfo()
}

Remove-Variable usuario,objUser
$users.Clear()
