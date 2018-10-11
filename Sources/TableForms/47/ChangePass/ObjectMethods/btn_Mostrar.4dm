If (Not:C34(b_mostrar))
	OBJECT SET FONT:C164(vsPW_password1;"Arial")
	OBJECT SET FONT:C164(vsPW_password2;"Arial")
	OBJECT SET TITLE:C194(*;"btn_Mostrar";"Ocultar")
	b_mostrar:=True:C214
Else 
	OBJECT SET FONT:C164(vsPW_password1;"%password")
	OBJECT SET FONT:C164(vsPW_password2;"%password")
	OBJECT SET TITLE:C194(*;"btn_Mostrar";"Mostrar")
	b_mostrar:=False:C215
End if 
