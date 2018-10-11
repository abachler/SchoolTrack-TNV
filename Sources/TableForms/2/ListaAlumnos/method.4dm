Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		C_LONGINT:C283(vl_alumnos)
		LISTBOX SELECT ROW:C912(*;"listado";0;lk remove from selection:K53:3)
		vl_alumnos:=Size of array:C274(atACT_alumnosCurso)
		
	: (Form event:C388=On Close Box:K2:21)
		ACCEPT:C269
End case 
