# comparador.ps1
# Administración de Sistemas Operativos – 2ASIR

Write-Output "Vamos a comparar dos numeros"
$numero1=Read-Host "Introduce el primero"
$numero2=Read-Host "Introduce el segundo"

if ($numero1 -eq $numero2) {
    Write-Output "Los numeros son iguales"
    }
if ($numero1 -lt $numero2) {
    Write-Output "El primero es menor que el segundo"
    }
if ($numero1 -gt $numero2) {
    Write-Output "El primero es mayor que el segundo"
    }