If (Self:C308->=1)
	cb_PublicarCompColegio:=0
	OBJECT SET ENABLED:C1123(cb_PublicarCompColegio;False:C215)
Else 
	OBJECT SET ENABLED:C1123(cb_PublicarCompColegio;True:C214)
End if 