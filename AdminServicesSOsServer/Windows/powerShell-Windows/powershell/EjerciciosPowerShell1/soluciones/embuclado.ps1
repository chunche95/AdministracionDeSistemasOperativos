# embuclado.ps1
# Administración de Sistemas Operativos – 2ASIR

$numero=Read-Host "Introduce un numero, por favor"
$numero=[int]$numero

while ($numero -lt 0) {
     $numero=Read-Host "Mete un numero positivo, por favor"
}

while ($numero -gt 0) {
     Write-Output "EMBUCLADO"
     $numero--
}