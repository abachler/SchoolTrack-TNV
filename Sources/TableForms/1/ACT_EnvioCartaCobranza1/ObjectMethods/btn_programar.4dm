C_BOOLEAN:C305($b_validado)
$b_validado:=(ACTecc_OpcionesGenerales ("ValidaProgramacion")="1")

If ($b_validado)
	$t_mensaje:=__ ("Se realizará un envío automático de correos electrónicos para los apoderados encontrados con la consulta ")+ST_Qte (vtACTecc_Consulta)+"."+"\r\r"
	$t_mensaje:=$t_mensaje+__ ("El envío se realizará el día ")+String:C10(vlACTecc_Dia)+__ (" de cada mes.")+"\r\r"
	$t_mensaje:=$t_mensaje+__ ("¿Desea programar el envío?")
	$l_respuesta:=CD_Dlog (0;$t_mensaje;"";__ ("Si");__ ("No"))
	If ($l_respuesta=1)
		ACTecc_OpcionesGenerales ("GuardaBlob")
		CANCEL:C270
	End if 
Else 
	BEEP:C151
End if 