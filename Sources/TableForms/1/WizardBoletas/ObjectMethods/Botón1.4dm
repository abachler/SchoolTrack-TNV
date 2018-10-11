AL_ExitCell (xALP_WizDocTrib)
If (modbol)
	$r:=CD_Dlog (0;__ ("¿Está seguro de querer confirmar los cambios realizados?");__ ("");__ ("No");__ ("Si"))
	If ($r=2)
		ACTbol_ProcessModifications 
		vlACT_WTipoBusqueda:=vlACT_WTipoBusquedaL
		vtACT_WDTDesde:=vtACT_WDTDesdeL
		vtACT_WDTHasta:=vtACT_WDTHastaL
		vdACT_WDTDesde:=vdACT_WDTDesdeL
		vdACT_WDTHasta:=vdACT_WDTHastaL
		ARRAY LONGINT:C221($al_idDoc;0)
		AT_Text2Array (->$al_idDoc;vtACT_WTipoDocID;";")
		vlACT_WTipoDoc:=$al_idDoc{1}
		vtACT_WTipoDoc:=vtACT_WTipoDocL
		vlACT_WCatDoc:=vlACT_WCatDocL
		vbACT_WAfectaDoc:=vbACT_WAfectaDocL
		OBJECT SET VISIBLE:C603(*;"fecha@";(vlACT_WTipoBusqueda=2))
		OBJECT SET ENTERABLE:C238(*;"numero@";(vlACT_WTipoBusqueda=1))
		modBol:=False:C215
		ACTbol_WDTLoad 
		<>vb_refresh:=True:C214
	End if 
Else 
	CD_Dlog (0;__ ("No hay modificaciones que confirmar."))
End if 