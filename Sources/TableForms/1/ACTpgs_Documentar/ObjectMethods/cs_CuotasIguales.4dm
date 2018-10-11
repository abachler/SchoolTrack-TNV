If (Self:C308->=1)
	vrACT_LCMontoPrimero:=0
	OBJECT SET ENTERABLE:C238(vrACT_LCMontoPrimero;False:C215)
Else 
	OBJECT SET ENTERABLE:C238(vrACT_LCMontoPrimero;True:C214)
End if 
cambioLC:=True:C214