# operaciones.ps1
# Administración de Sistemas Operativos – 2ASIR

Write-Output "Vamos a realizar cuatro operaciones con dos numeros"
$numero1=Read-Host "Introduce el primero"
$numero2=Read-Host "Introduce el segundo"

$suma=[int]$numero1+[int]$numero2
Write-Output "La suma de los dos es:"$suma
$resta=[int]$numero1-[int]$numero2
Write-Output "La resta de los dos es:"$resta
$multi=[int]$numero1*[int]$numero2
Write-Output "La multiplicacion de los dos es:"$multi
$div=[int]$numero1/[int]$numero2
Write-Output "La division de los dos es:"$div