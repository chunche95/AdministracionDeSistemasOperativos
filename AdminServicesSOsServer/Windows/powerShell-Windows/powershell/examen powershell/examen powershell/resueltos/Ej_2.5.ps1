# Ej_2.5.ps1
# Decir si un número es o no primo

[int]$n = Read-Host "Escribe el número a evaluar"
[int]$i = 2
[int]$ind = 1

while ($i -lt $n){
    if (($n % $i) -eq 0){$ind = 0}
    $i++
}

if ($ind -eq 1){
    "El número $n es primo"
}else{
    "El número $n no es primo"
}
