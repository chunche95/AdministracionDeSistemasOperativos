# Ej_10.2.b.ps1
# Renombrar el archivo creado a Ej_1_1.txt y
#    moverlo al directorio FEBRERO

# Solución con Move-Item y luego Rename-Item

Set-Location C:\

Move-Item `
    -Path "C:\PRACTICAS\FEBRERO\PROGRAMACION\PRACTICA1\Ejemplo1.txt" `
    "C:\PRACTICAS\FEBRERO"
Rename-Item -Path "C:\PRACTICAS\FEBRERO\Ejemplo1.txt"`
    "C:\PRACTICAS\FEBRERO\Ej_1.1.txt"