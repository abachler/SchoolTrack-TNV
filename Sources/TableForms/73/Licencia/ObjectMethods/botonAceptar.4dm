If ((dFrom#!00-00-00!) & (dto#!00-00-00!) & (sMotivo#"") & (sName#""))
	If ([Alumnos:2]Fecha_de_Ingreso:41#!00-00-00!)
		If (([Alumnos:2]Fecha_de_Ingreso:41<=dFrom))
			ACCEPT:C269
		Else 
			CD_Dlog (0;__ ("La fecha de ingreso del alumno es: ")+String:C10([Alumnos:2]Fecha_de_Ingreso:41)+__ (". No puede ingresar licencias para esa fecha."))
		End if 
	Else 
		ACCEPT:C269
	End if 
Else 
	CD_Dlog (0;__ ("Por favor indique el alumno, la fecha de inicio y término y el tipo de licencia"))
End if 