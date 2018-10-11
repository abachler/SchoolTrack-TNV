If (Self:C308->=1)
	_O_DISABLE BUTTON:C193(e1_Ancho)
	_O_DISABLE BUTTON:C193(e2_Alto)
	OBJECT SET ENTERABLE:C238(vl_Ancho;False:C215)
	OBJECT SET ENTERABLE:C238(vl_Alto;False:C215)
	OBJECT SET ENTERABLE:C238(vl_Escala;True:C214)
	GOTO OBJECT:C206(vl_Escala)
	e1_Ancho:=0
	e2_Alto:=0
	vl_Ancho:=0
	vl_Alto:=0
	vt_ResizeMode:="Proporcional"
End if 