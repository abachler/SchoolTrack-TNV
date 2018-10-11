//%attributes = {}
  //ACTpp_CambUbicacion

C_TEXT:C284(vtACT_Ubicacion)

$r:=CD_Dlog (0;__ ("Ingrese una nueva ubicación");__ ("");__ ("Aceptar");__ ("Cancelar");__ ("");__ ("");__ (""))
vtACT_Ubicacion:=vt_UserEntry
If ((vtACT_Ubicacion#"") & ($r=1))
	$line:=AL_GetLine (xALP_DocsenCartera)
	If ($line>0)
		READ WRITE:C146([ACT_Documentos_en_Cartera:182])
		QUERY:C277([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]ID:1=aACT_ApdosDCarID{$line})
		If (Not:C34(Locked:C147([ACT_Documentos_en_Cartera:182])))
			[ACT_Documentos_en_Cartera:182]Ubicacion_Doc:8:=vtACT_Ubicacion
			SAVE RECORD:C53([ACT_Documentos_en_Cartera:182])
		Else 
			$Params:=ST_Concatenate (";";->[ACT_Documentos_en_Cartera:182]ID:1;->vtACT_Ubicacion)
			BM_CreateRequest ("ACT_CambiaUCheques";$Params)
		End if 
	End if 
	KRL_UnloadReadOnly (->[ACT_Documentos_en_Cartera:182])
End if 