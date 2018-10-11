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
	
	i_Doc:=i_Doc+1
	If (i_Doc>1)
		OBJECT SET VISIBLE:C603(*;"cb_VariosDocs";False:C215)
	End if 
	If (i_Doc=Size of array:C274(alACT_RecNumsDocs))
		OBJECT SET VISIBLE:C603(*;"@next@";False:C215)
		OBJECT SET VISIBLE:C603(*;"@Ingresar@";True:C214)
	End if 
	ACTdc_CargaDatosDCartera 
	GOTO OBJECT:C206(vdACT_FechaProrroga)
Else 
	ACTdc_DocumentoNoBloq ("CambiarUMensaje")
End if 
ACTdc_DocumentoNoBloq ("CambiarULiberaRegistros")