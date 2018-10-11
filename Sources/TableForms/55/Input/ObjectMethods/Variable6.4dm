

If ((dFrom#!00-00-00!) & (sName#""))
	
	If ([Alumnos:2]Fecha_de_Ingreso:41#!00-00-00!)
		If (([Alumnos:2]Fecha_de_Ingreso:41<=dFrom))
			ACCEPT:C269
		Else 
			CD_Dlog (0;__ ("La fecha de ingreso del alumno es: ")+String:C10([Alumnos:2]Fecha_de_Ingreso:41)+__ (". No puede ingresar atrasos para esa fecha."))
		End if 
	Else 
		ACCEPT:C269
	End if 
Else 
	CD_Dlog (0;__ ("Por favor complete los campos obligatorios (en rojo)"))
End if 
