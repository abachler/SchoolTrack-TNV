If (modbol)
	$r:=CD_Dlog (0;__ ("Todos los cambios que pudiera haber realizado se perderán. ¿Desea continuar?");__ ("");__ ("No");__ ("Si"))
Else 
	$r:=2
End if 
If ($r=2)
	Case of 
		: (vlACT_WTipoBusqueda=1)
			vtACT_WDTDesde:="0"
			vtACT_WDTHasta:="0"
			vdACT_WDTDesde:=!00-00-00!
			vd_WDTHasta:=!00-00-00!
		: (vlACT_WTipoBusqueda=2)
			vtACT_WDTDesde:=dt_GetNullDateString 
			vtACT_WDTHasta:=dt_GetNullDateString 
	End case 
	vdACT_WDTDesde:=!00-00-00!
	vdACT_WDTHasta:=!00-00-00!
	AL_UpdateArrays (xALP_WizDocTrib;0)
	IT_SetButtonState (False:C215;->bDelWBol;->bRellenar)
End if 