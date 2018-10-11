If (Form event:C388=On Data Change:K2:15)
	C_BOOLEAN:C305($mesAbierto)
	If ([ACT_Documentos_de_Pago:176]FechaPago:4#!00-00-00!)  //20170607 RCH
		$mesAbierto:=ACTcm_IsMonthOpenFromDate ([ACT_Documentos_de_Pago:176]FechaPago:4)
		If (Not:C34($mesAbierto))
			[ACT_Documentos_de_Pago:176]FechaPago:4:=Old:C35([ACT_Documentos_de_Pago:176]FechaPago:4)
			CD_Dlog (0;__ ("La fecha ingresada corresponde a un período cerrado."))
		End if 
	Else 
		CD_Dlog (0;__ ("La fecha ingresada no fue reconocida ("+String:C10([ACT_Documentos_de_Pago:176]FechaPago:4)+"). Intente nuevamente usando otro separador de fecha."))
	End if 
End if 