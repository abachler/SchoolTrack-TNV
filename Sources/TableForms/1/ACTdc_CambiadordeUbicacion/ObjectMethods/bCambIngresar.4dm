If (cb_VariosDocs=1)
	$vb_mensaje:=False:C215
	For ($i;1;Size of array:C274(alACT_RecNumsDocs))
		READ WRITE:C146([ACT_Documentos_en_Cartera:182])
		GOTO RECORD:C242([ACT_Documentos_en_Cartera:182];alACT_RecNumsDocs{$i})
		If (Not:C34(Locked:C147([ACT_Documentos_en_Cartera:182])))
			If (vNuevaUbicacion#"")
				[ACT_Documentos_en_Cartera:182]Ubicacion_Doc:8:=vNuevaUbicacion
				SAVE RECORD:C53([ACT_Documentos_en_Cartera:182])
			End if 
		Else 
			  //$Params:=ST_Concatenate (";";->[ACT_Documentos_en_Cartera]ID;->vNuevaUbicacion)
			  //BM_CreateRequest ("ACT_CambiaUCheques";$Params)
			$vb_mensaje:=True:C214
		End if 
	End for 
	If ($vb_mensaje)
		CD_Dlog (0;__ ("Existían registros en uso. Algunos registros no fueron actualizados."))
	End if 
	UNLOAD RECORD:C212([ACT_Documentos_en_Cartera:182])
	READ ONLY:C145([ACT_Documentos_en_Cartera:182])
	CANCEL:C270
Else 
	If (ACTdc_DocumentoNoBloq ("CambiarU";->[ACT_Documentos_en_Cartera:182]ID:1))
		If (Not:C34(Locked:C147([ACT_Documentos_en_Cartera:182])))
			If (vNuevaUbicacion#"")
				[ACT_Documentos_en_Cartera:182]Ubicacion_Doc:8:=vNuevaUbicacion
				SAVE RECORD:C53([ACT_Documentos_en_Cartera:182])
			End if 
		Else 
			$Params:=ST_Concatenate (";";->[ACT_Documentos_en_Cartera:182]ID:1;->vNuevaUbicacion)
			BM_CreateRequest ("ACT_CambiaUCheques";$Params)
		End if 
	Else 
		ACTdc_DocumentoNoBloq ("CambiarUMensaje")
	End if 
	ACTdc_DocumentoNoBloq ("CambiarULiberaRegistros")
	UNLOAD RECORD:C212([ACT_Documentos_en_Cartera:182])
	READ ONLY:C145([ACT_Documentos_en_Cartera:182])
	CANCEL:C270
End if 