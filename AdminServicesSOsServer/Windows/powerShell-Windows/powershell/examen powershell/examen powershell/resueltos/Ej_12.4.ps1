# Ej_12.4.ps1
# Mostrar las variables actualmente en uso, crear una
#    nueva MiVariable con el valor 4 y después borrarla.
#    Comprobar que ya no aparece.

Set-Location Variable:

"VARIABLES ACTUALES"
"=================="
Get-ChildItem

New-Item MiVariable –Value 4

"VARIABLES TRAS LA CREACION"
"=========================="
Get-ChildItem

Remove-Item MiVariable -Confirm

"VARIABLES TRAS LA DESTRUCCIÓN"
"============================="
Get-ChildItem

