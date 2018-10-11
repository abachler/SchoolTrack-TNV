If (Not:C34([xxACT_Items:179]EsDescuento:6))
	$vb_obtenerDctoDelArreglo:=True:C214
	$vr_suma:=Num:C11(ACTcfg_OpcionesEliminacionDctos ("ObtieneSumaDescuentosXItem";->alACT_IdItem{vi_lastLine};->$vb_obtenerDctoDelArreglo))
	$vb_entrar:=False:C215
	If ($vr_suma#0)
		$vb_entrar:=True:C214
	Else 
		$vr_suma2:=Num:C11(ACTcfg_OpcionesEliminacionDctos ("ObtieneDescuentosXCta";->[xxACT_Items:179]ID:1))
		If ($vr_suma2#0)
			$vb_entrar:=True:C214
		End if 
	End if 
	
	If ($vb_entrar)
		C_LONGINT:C283($vl_resp)
		If (Self:C308->)
			$vl_resp:=CD_Dlog (0;__ ("Esta opción eliminará los descuentos por número de hijo, cuenta y/o por número de cargas cuando el cargo emitido se encuentre vencido y no pagado completamente.")+"\r\r"+__ ("La eliminación de los descuentos se hará a través de la creación de cargos especiales por el monto del descuento.")+"\r\r"+__ ("¿Está seguro de querer eliminar los descuentos cuando los cargos se encuentren vencidos?");"";__ ("Si");__ ("No"))
			If ($vl_resp=1)
			Else 
				Self:C308->:=False:C215
			End if 
		Else 
		End if 
	Else 
		Self:C308->:=False:C215
		CD_Dlog (0;__ ("Este ítem de cargo no tiene configurados descuentos por por número de hijo, cuenta y/o descuento por hijos o cargas totales."))
	End if 
Else 
	Self:C308->:=False:C215
	BEEP:C151
End if 