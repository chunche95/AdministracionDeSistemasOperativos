# Ej_8.1.ps1
# Mostrar todos los proveedores y todas las unidades accesibles

Get-PSProvider |Format-Table -AutoSize

Get-PSDrive |Format-Table -AutoSize
