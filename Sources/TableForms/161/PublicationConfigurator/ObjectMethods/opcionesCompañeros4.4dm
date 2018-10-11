If (Self:C308->=1)
	cb_PublicarCompNivel:=0
	OBJECT SET ENABLED:C1123(cb_PublicarCompNivel;False:C215)
Else 
	OBJECT SET ENABLED:C1123(cb_PublicarCompNivel;True:C214)
End if 