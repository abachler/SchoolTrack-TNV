If (ACTdc_DocumentoNoBloq ("Reemplazar";->[ACT_Documentos_en_Cartera:182]ID:1))
	C_BOOLEAN:C305($vb_noLiberar)
	$Reemplazar:=False:C215
	
	If (Not:C34(Reemplazado))
		C_LONGINT:C283($vl_proc)
		$vl_proc:=IT_UThermometer (1;0;__ ("Reemplazando documento..."))
		$Reemplazar:=ACTdc_ValidaDocReemplazador 
		
		If ($Reemplazar)
			ACTdc_IngresaDocReemplazador 
			i_Doc:=i_Doc+1
			ACTdc_CargaDatosDCartera 
			$vb_noLiberar:=True:C214
		End if 
		IT_UThermometer (-2;$vl_proc)
	End if 
	
	ACTdc_OpcionesReemplazoMasivo ("SetNextIngresar")
Else 
	ACTdc_DocumentoNoBloq ("ReemplazarMensaje")
	CANCEL:C270
End if 
If (Not:C34($vb_noLiberar))
	ACTdc_DocumentoNoBloq ("ReemplazarLiberaRegistros")
End if 