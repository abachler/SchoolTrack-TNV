If (vlACTreemp_Modo=1)
	
	If (ACTdc_DocumentoNoBloq ("Reemplazar";->[ACT_Documentos_en_Cartera:182]ID:1))
		$Reemplazar:=False:C215
		
		If (Not:C34(Reemplazado))
			C_LONGINT:C283($vl_proc)
			$vl_proc:=IT_UThermometer (1;0;__ ("Reemplazando documento..."))
			$Reemplazar:=ACTdc_ValidaDocReemplazador 
			
			If ($Reemplazar)
				KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->[ACT_Documentos_en_Cartera:182]ID_Apoderado:2)
				KRL_FindAndLoadRecordByIndex (->[ACT_Terceros:138]Id:1;->[ACT_Documentos_en_Cartera:182]ID_Tercero:18)
				ACTdc_IngresaDocReemplazador 
				CANCEL:C270
				ACTdc_DocumentoNoBloq ("ReemplazarLiberaRegistros")
			End if 
			IT_UThermometer (-2;$vl_proc)
		Else 
			CANCEL:C270
			ACTdc_DocumentoNoBloq ("ReemplazarLiberaRegistros")
		End if 
	Else 
		ACTdc_DocumentoNoBloq ("ReemplazarMensaje")
		CANCEL:C270
		ACTdc_DocumentoNoBloq ("ReemplazarLiberaRegistros")
	End if 
Else 
	
	$vt_ok:=Num:C11(ACTdc_OpcionesReemplazoMasivo ("ReemplazaDocumentos"))
	If ($vt_ok=0)
		CD_Dlog (0;"No fue posible ingresar el reemplazo.")
	End if 
	CANCEL:C270
End if 