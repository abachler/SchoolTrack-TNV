  //If ((Self->>vrACT_MontoAPagar) | (Self-><0))
If ((Self:C308->>vrACT_MontoAPagarApdo) | (Self:C308-><0))
	BEEP:C151
	Self:C308->:=0
	GOTO OBJECT:C206(Self:C308->)
Else 
	vrACT_MontoPrimero:=Round:C94(vrACT_MontoPrimero;<>vlACT_Decimales)
End if 