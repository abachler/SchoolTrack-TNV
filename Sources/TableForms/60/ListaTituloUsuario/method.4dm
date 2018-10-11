  // [BBL_Préstamos].ListaTituloUsuario()
  // Por: Alberto Bachler: 10/06/13, 16:16:54
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------





If (Form event:C388=On Display Detail:K2:22)
	RELATE ONE:C42([BBL_Prestamos:60]Número_de_registro:1)
	RELATE ONE:C42([BBL_Registros:66]Número_de_item:1)
	RELATE ONE:C42([BBL_Prestamos:60]Número_de_lector:2)
	vt_NombrePrestador:=KRL_GetTextFieldData (->[xShell_Users:47]No:1;->[BBL_Prestamos:60]Préstamo_registrado_por:9;->[xShell_Users:47]Name:2)
	vt_NombreReceptor:=KRL_GetTextFieldData (->[xShell_Users:47]No:1;->[BBL_Prestamos:60]Devolución_registrada_por:10;->[xShell_Users:47]Name:2)
End if 
