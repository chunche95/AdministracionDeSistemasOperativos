# Ej_5.2.ps1
# Obtener un listado de los archivos *.txt que haya en
#   c:\windows en forma tabular autoajustada, incluyendo
#   el nombre, tamaño, fecha de creación, extensión y su
#   nombre completo

Get-ChildItem -path "C:\Windows\*" `
    -include "*.txt" | Format-Table -AutoSize `
    -property Name,Length,CreationTime,Extension,FullName
