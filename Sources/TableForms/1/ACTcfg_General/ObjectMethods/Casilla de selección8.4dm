If (Self:C308->=0)
	cbAgrupar:=0
	cbAgruparXAlumnoItem:=0
	OBJECT SET ENABLED:C1123(cbAgrupar;False:C215)
	OBJECT SET ENABLED:C1123(cbAgruparXAlumnoItem;False:C215)
Else 
	cbAgrupar:=1
	OBJECT SET ENABLED:C1123(cbAgrupar;True:C214)
	OBJECT SET ENABLED:C1123(cbAgruparXAlumnoItem;True:C214)
End if 