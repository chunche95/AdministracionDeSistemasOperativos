# Ej_7.2.ps1
# Sacar un listado en formato CSV de los procesos que
#   se están corriendo en la máquina ordenados de forma
#   descendente por el uso de procesador. Abrirlo en Excel

Get-Process |Sort-Object {$_.CPU} -Descending `
    |Export-Csv ".\Ej_7.2.csv"
