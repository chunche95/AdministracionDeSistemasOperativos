# Ej_17.4.ps1
# 17.4. Mostrar todas las propiedades del
# usuario “aperez”
#

$usr_nm = "aperez"

$objUser = [ADSI]"WinNT://./$usr_nm,user"

"Propiedades básicas"
"-------------------"
$objUser

"Propiedades extendidas"
"----------------------"
$objUser.PSAdapted

"Ver una propiedad concreta"
"--------------------------"
"Nombre completo: "+$objUser.PSBase.InvokeGet('FullName')
"Nombre inicio:   "+$objUser.PSBase.InvokeGet('Name')