# Ej_10.2.a.ps1
# Renombrar el archivo creado a Ej_1_1.txt y
#    moverlo al directorio FEBRERO

# Solución con Move-Item (1 solo comando)

Set-Location C:\

Move-Item `
    -Path "C:\PRACTICAS\FEBRERO\PROGRAMACION\PRACTICA1\Ejemplo1.txt" `
    "C:\PRACTICAS\FEBRERO\Ej_1_1.txt"
