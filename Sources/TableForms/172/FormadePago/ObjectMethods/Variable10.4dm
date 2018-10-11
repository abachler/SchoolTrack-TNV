If (Form event:C388=On Losing Focus:K2:8)
	If (Self:C308->#"")
		C_LONGINT:C283($Duplicados)
		$Duplicados:=ACTdc_buscaDuplicados (-2;Self:C308->;vtACT_BancoCuenta;vtACT_BancoID)
		If ($duplicados>0)
			CD_Dlog (0;__ ("Para este banco ya existe un cheque con ese número de serie."))
			Self:C308->:=""
		End if 
	Else 
		CD_Dlog (0;__ ("Debe ingresar un número de serie para este documento."))
		Self:C308->:=""
	End if 
	vbSpell_StopChecking:=True:C214
	
End if 