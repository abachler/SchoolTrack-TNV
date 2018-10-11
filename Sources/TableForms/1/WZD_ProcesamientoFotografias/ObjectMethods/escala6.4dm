vt_ResizeMode:="Alto"
vl_ResizeValue:=vl_Alto

GOTO OBJECT:C206(e2_Alto)
OBJECT SET ENTERABLE:C238(vl_Ancho;False:C215)
OBJECT SET ENTERABLE:C238(vl_Alto;True:C214)
GOTO OBJECT:C206(vl_Alto)
vl_Ancho:=0