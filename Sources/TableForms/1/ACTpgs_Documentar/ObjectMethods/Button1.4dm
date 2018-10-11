$line:=AL_GetLine (xALP_Documentar)

If (($line>0) & (Size of array:C274(atACT_BancoNombre)>1))
	vlACT_Cuotas:=vlACT_Cuotas-1
	POST KEY:C465(Character code:C91("g");Command key mask:K16:1+Shift key mask:K16:3+Option key mask:K16:7)
Else 
	BEEP:C151
End if 