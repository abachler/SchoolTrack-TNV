vt_ResizeMode:="Ancho"
vl_ResizeValue:=vl_Ancho

GOTO OBJECT:C206(e1_Ancho)

OBJECT SET ENTERABLE:C238(vl_Ancho;True:C214)
OBJECT SET ENTERABLE:C238(vl_Alto;False:C215)
GOTO OBJECT:C206(vl_Ancho)
vl_Alto:=0