# Ej_1.4.ps1
# Leer dos números y escribir el mayor

[int32]$a = Read-Host
[int32]$b = Read-Host

if ($a -ge $b){
    "El mayor es $a"
}else{
    "El mayor es $b"
}