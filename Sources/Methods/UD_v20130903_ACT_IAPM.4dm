//%attributes = {}
  //UD_v20130903_ACT_IAPM

If (ACT_AccountTrackInicializado )
	READ ONLY:C145([Colegio:31])
	ALL RECORDS:C47([Colegio:31])
	FIRST RECORD:C50([Colegio:31])
	
	If (([Colegio:31]Codigo_Pais:31="cl") & ([Colegio:31]Rol Base Datos:9="77178"))
		
		C_REAL:C285($r_idCatConError;$r_idCatCorrecta)
		C_TEXT:C284($t_tipoDocumento)
		
		READ ONLY:C145([ACT_Boletas:181])
		
		$r_idCatCorrecta:=4
		$r_idCatConError:=2
		
		QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID_Categoria:12=-1;*)
		QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]ID_Documento:13=$r_idCatCorrecta;*)
		QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]TipoDocumento:7#"")
		
		$t_tipoDocumento:=[ACT_Boletas:181]TipoDocumento:7
		
		READ WRITE:C146([ACT_Boletas:181])
		QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID_Documento:13=$r_idCatConError)
		APPLY TO SELECTION:C70([ACT_Boletas:181];[ACT_Boletas:181]ID_Documento:13:=$r_idCatCorrecta)
		APPLY TO SELECTION:C70([ACT_Boletas:181];[ACT_Boletas:181]TipoDocumento:7:=$t_tipoDocumento)
		KRL_UnloadReadOnly (->[ACT_Boletas:181])
	End if 
End if 