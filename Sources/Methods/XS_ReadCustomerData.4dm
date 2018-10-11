//%attributes = {}
  //XS_ReadCustomerData

READ ONLY:C145([xShell_ApplicationData:45])
ALL RECORDS:C47([xShell_ApplicationData:45])
If (Records in selection:C76([xShell_ApplicationData:45])>0)
	FIRST RECORD:C50([xShell_ApplicationData:45])
	<>vtXS_CountryCode:=[xShell_ApplicationData:45]Código_Pais:26
	<>vtXS_Razon_Social:=[xShell_ApplicationData:45]Razon_Social:21
	<>vtXS_Denominacion_Fantasia:=[xShell_ApplicationData:45]Denominacion_Fantasia:28
	<>vtXS_Representante_Legal:=[xShell_ApplicationData:45]Representante_Legal:22
	<>vtXS_Direccion:=[xShell_ApplicationData:45]Direccion:2
	<>vtXS_Comuna:=[xShell_ApplicationData:45]Comuna:3
	<>vtXS_Ciudad:=[xShell_ApplicationData:45]Ciudad:4
	<>vtXS_Codigo_Postal:=[xShell_ApplicationData:45]Codigo_Postal:6
	<>vtXS_Provincia_o_Distrito:=[xShell_ApplicationData:45]Provincia_o_Distrito:5
	<>vtXS_Pais:=[xShell_ApplicationData:45]Pais:25
	<>vtXS_Telefono:=[xShell_ApplicationData:45]Telefono:7
	<>vtXS_Fax:=[xShell_ApplicationData:45]Fax:8
	<>vtXS_Email:=[xShell_ApplicationData:45]Email:20
	<>vtXS_WebSite:=[xShell_ApplicationData:45]WebSite:24
	<>vpXS_Logo:=[xShell_ApplicationData:45]Logo:9
	<>vtXS_Región:=[xShell_ApplicationData:45]Región:27
	<>vtXS_UUID:=[xShell_ApplicationData:45]UUID:31
	UNLOAD RECORD:C212([xShell_ApplicationData:45])
Else 
	<>vtXS_CountryCode:="cl"
	<>vtXS_langage:="es"
End if 
dhXS_ReadCustomerData 

