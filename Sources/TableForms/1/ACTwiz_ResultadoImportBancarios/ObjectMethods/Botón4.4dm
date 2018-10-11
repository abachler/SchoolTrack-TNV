If (Size of array:C274(aRUTRechazo)>0)
	C_TEXT:C284($vt_obs)
	$vt_obs:="Se generarán registros de observaciones para "
	Case of 
		: ((cs_Apdos=1) & (cs_Ctas=1))
			$vt_obs:=$vt_obs+"los apoderados y cuentas corrientes con rechazo."
		: (cs_Apdos=1)
			$vt_obs:=$vt_obs+"los apoderados rechazados."
		: (cs_Ctas=1)
			$vt_obs:=$vt_obs+"las cuentas corrientes rechazadas."
	End case 
	$vt_obs:=$vt_obs+"\r\r"+"¿Desea continuar?"
	$resp:=CD_Dlog (0;$vt_obs;"";"Si";"No")
	If ($resp=1)
		ACTpp_GuardaRechazos (->aRUTRechazo;->aDescRechazo;vdACT_ImpRealDate;vTipo;vtACT_fileName;vRUTTable;vRUTField;cs_Apdos;cs_Ctas;->aIDAvisoRechazo)
	End if 
End if 