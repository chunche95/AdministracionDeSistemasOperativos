Import-Csv "C:\Users\admin\Desktop\usuarios.csv" | ForEach-Object {

	$samAccountName = $_."users"


	Add-DistributionGroupMember -Identify "Administrador de redes" -Memmber $samAccountName

}
