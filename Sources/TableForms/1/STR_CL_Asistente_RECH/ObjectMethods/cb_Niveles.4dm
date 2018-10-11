If (Self:C308->=1)
	For ($i;1;Size of array:C274(at_NivelesRech))
		lb_Niveles{$i}:=True:C214
	End for 
Else 
	For ($i;1;Size of array:C274(at_NivelesRech))
		lb_Niveles{$i}:=False:C215
	End for 
End if 
GOTO OBJECT:C206(lb_Niveles)