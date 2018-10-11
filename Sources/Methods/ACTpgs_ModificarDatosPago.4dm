//%attributes = {}
  //ACTpgs_ModificarDatosPago

If (USR_GetMethodAcces (Current method name:C684))
	If (Table:C252(yBWR_CurrentTable)#Table:C252(->[ACT_Documentos_de_Pago:176]))
		If (Not:C34([ACT_Pagos:172]Nulo:14))
			If (Not:C34([ACT_Documentos_de_Pago:176]Protestado:36))
				OBJECT SET ENTERABLE:C238(*;"mod@";True:C214)
				OBJECT SET VISIBLE:C603(*;"banco@";True:C214)
				modPago:=True:C214
			Else 
				CD_Dlog (0;__ ("Los datos de un documento protestado no pueden ser modificados."))
			End if 
		End if 
	End if 
End if 