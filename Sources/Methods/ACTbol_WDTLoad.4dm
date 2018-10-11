//%attributes = {}
  //ACTbol_WDTLoad

If (modbol)
	$r:=CD_Dlog (0;__ ("Todos los cambios que pudiera haber realizado se perderán. ¿Desea continuar?");"";__ ("No");__ ("Si"))
Else 
	$r:=2
End if 
If ($r=2)
	$proc:=IT_UThermometer (1;0;__ ("Recopilando información...");-1)
	AL_UpdateArrays (xALP_WizDocTrib;0)
	ACTbol_LoadDocumentos 
	AL_UpdateArrays (xALP_WizDocTrib;-2)
	AL_SetLine (xALP_WizDocTrib;0)
	Case of 
		: (vlACT_WTipoBusqueda=1)
			AL_SetSort (xALP_WizDocTrib;1;4)
		: (vlACT_WTipoBusqueda=2)
			AL_SetSort (xALP_WizDocTrib;4;1)
	End case 
	If (Size of array:C274(abACT_WDTNulas)>1)
		ACTbol_WDTAnalize 
	End if 
	vlACT_WTipoBusquedaL:=vlACT_WTipoBusqueda
	vtACT_WDTDesdeL:=vtACT_WDTDesde
	vtACT_WDTHastaL:=vtACT_WDTHasta
	vdACT_WDTDesdeL:=vdACT_WDTDesde
	vdACT_WDTHastaL:=vdACT_WDTHasta
	  //vlACT_WTipoDocL:=vlACT_WTipoDoc
	ARRAY LONGINT:C221($al_idDoc;0)
	AT_Text2Array (->$al_idDoc;vtACT_WTipoDocID;";")
	vlACT_WTipoDocL:=$al_idDoc{1}
	vtACT_WTipoDocL:=vtACT_WTipoDoc
	vlACT_WCatDocL:=vlACT_WCatDoc
	vbACT_WAfectaDocL:=vbACT_WAfectaDoc
	IT_SetButtonState ((Size of array:C274(abACT_WDTNulas)>1);->bRellenar)
	IT_UThermometer (-2;$proc)
	If (Size of array:C274(abACT_WDTNulas)=0)
		Case of 
			: (vlACT_WTipoBusqueda=1)
				CD_Dlog (0;__ ("No hay documentos tributarios emitidos en el rango de números especificado."))
			: (vlACT_WTipoBusqueda=2)
				CD_Dlog (0;__ ("No hay documentos tributarios emitidos en el rango de fechas especificado."))
		End case 
	End if 
End if 