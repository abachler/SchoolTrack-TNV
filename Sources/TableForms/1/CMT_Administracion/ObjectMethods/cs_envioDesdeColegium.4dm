  //OPCION CREADA PARA PRUEBAS DE QA
If (Self:C308->=1)
	$resp:=CD_Dlog (0;"Al marcar esta opción el sistema enviará datos a CMT automáticamente durante la n"+"oche, a pesar de e"+"star dentro del dominio lester.colegium.com. Esto puede sobreescribir datos de lo"+"s co"+"legios..."+"\r\r"+"¡¡¡OPCIÓN VÁLIDA SÓLO EN OFICINA BILBAO!!!"+"\r\r"+"¿Está seguro de que desea continuar?";"";"Sí, estoy seguro";"No, mejor lo pensaré")
Else 
	$resp:=0
End if 
If ($resp=1)
	PREF_Set (0;"CMT_SOPORTE_ENVIOAUT";"1")
Else 
	PREF_Set (0;"CMT_SOPORTE_ENVIOAUT";"0")
	Self:C308->:=0
End if 
