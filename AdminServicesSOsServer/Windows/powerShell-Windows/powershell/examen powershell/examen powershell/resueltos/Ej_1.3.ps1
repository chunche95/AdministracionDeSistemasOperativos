# Ej_1.3.ps1
# Suma de los 20 primeros naturales

[int32]$i = 1
[int32]$suma = 0

for ($i = 1; $i -le 20; $i++){
    $suma += $i
}

"La suma es $suma"