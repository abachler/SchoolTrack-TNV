If (Self:C308-><=1)
	BEEP:C151
	Self:C308->:=2
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
		POST KEY:C465(Character code:C91("g");Command key mask:K16:1+Shift key mask:K16:3+Option key mask:K16:7)
	End if 
End if 