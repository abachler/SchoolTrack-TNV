$continuar:=False:C215

If ((cb_soloCuotasVencidas=1) & (Self:C308->>vrACT_MontoAPagar))
	BEEP:C151
	Self:C308->:=vrACT_MontoAPagar
Else 
	vrACT_MontoAPagarApdo:=Round:C94(vrACT_MontoAPagarApdo;<>vlACT_Decimales)
	Case of 
		: (rCheques=1)
			If (Size of array:C274(atACT_Serie)>0)
				$continuar:=True:C214
			End if 
		: (rLetras=1)
			If (Size of array:C274(arACT_LCFolio)>0)
				$continuar:=True:C214
			End if 
	End case 
	If ($continuar)
		POST KEY:C465(Character code:C91("g");Command key mask:K16:1+Shift key mask:K16:3+Option key mask:K16:7)
	End if 
End if 