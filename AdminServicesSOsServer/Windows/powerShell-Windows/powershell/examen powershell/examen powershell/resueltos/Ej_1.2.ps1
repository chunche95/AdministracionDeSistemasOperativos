# Ej_1.2.ps1
# Volteo o intercambio de variables

[int32]$x = Read-Host
[int32]$y = Read-Host
[int32]$z = 0

$z = $x
$x = $y
$y = $z

"Ahora: x=$x e y=$y"
