If (Lid#0)
	QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=Lid)
	If (([Alumnos:2]Fecha_de_Ingreso:41<=dDate) | ([Alumnos:2]Fecha_de_Ingreso:41=!00-00-00!))
		If (Find in array:C230(alABS_AlumnosID;Lid)=-1)
			AT_Insert (1;1;->atABS_Alumnos;->alABS_AlumnosID)
			atABS_Alumnos{1}:=sName
			alABS_AlumnosID{1}:=Lid
			LISTBOX SELECT ROW:C912(lb_AlumnosABS;0;lk remove from selection:K53:3)
		End if 
		sName:=""
		Lid:=0
		GOTO OBJECT:C206(sName)
	Else 
		CD_Dlog (0;__ ("La fecha de ingreso del alumno es: ")+String:C10([Alumnos:2]Fecha_de_Ingreso:41)+__ (". No es posible ingresar inasistencias para esa fecha."))
	End if 
End if 
OBJECT SET ENABLED:C1123(bOK;(Size of array:C274(atABS_Alumnos)>0))