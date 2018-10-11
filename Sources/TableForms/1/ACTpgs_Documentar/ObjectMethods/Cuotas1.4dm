If (Self:C308->=0)
	BEEP:C151
	Self:C308->:=vlACT_OldCuotas
Else 
	$continuar:=False:C215
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
		vlACT_OldCuotas:=Self:C308->
		POST KEY:C465(Character code:C91("g");Command key mask:K16:1+Shift key mask:K16:3+Option key mask:K16:7)
	End if 
End if 