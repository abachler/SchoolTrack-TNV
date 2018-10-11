If (Form event:C388=On Data Change:K2:15)
	If (vlDiasAtraso<1)
		BEEP:C151
		vlDiasAtraso:=1
	End if 
End if 