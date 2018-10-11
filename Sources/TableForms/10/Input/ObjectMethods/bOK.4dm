  //
  //If ((dFrom#!00-00-00!) & (dTo#!00-00-00!) & (sName#""))  //validacion de que fecha de inasistencia sea menor a fecha de ingreso
  //If ([Alumnos]Fecha_de_Ingreso#!00-00-00!)
  //If (([Alumnos]Fecha_de_Ingreso<=dFrom))
  //ACCEPT
  //Else 
  //CD_Dlog (0;__ ("La fecha de ingreso del alumno es: ")+String([Alumnos]Fecha_de_Ingreso)+__ (". No puede ingresar inasistencias para esa fecha."))
  //End if 
  //Else 
  //ACCEPT
  //End if 
  //Else 
  //CD_Dlog (0;__ ("Por favor complete los campos obligatorios (en rojo)"))
  //End if 


If ((dFrom#!00-00-00!) & (dTo#!00-00-00!) & (sName#""))  //validacion de que fecha de inasistencia sea menor a fecha de ingreso
	If ([Alumnos:2]Fecha_de_Ingreso:41#!00-00-00!)
		If (([Alumnos:2]Fecha_de_Ingreso:41<=dFrom))
			  //ACCEPT
			$resultado:=AL_validaIngresoAtraso ([Alumnos:2]numero:1;dFrom)
			If ($resultado=0)
				ACCEPT:C269
			Else 
				CD_Dlog (0;__ ("El alumno ya registra faltas por atraso. ")+"\r\r"+__ ("No puede ingresar Inasistencias."))
			End if 
		Else 
			CD_Dlog (0;__ ("La fecha de ingreso del alumno es: ")+String:C10([Alumnos:2]Fecha_de_Ingreso:41)+__ (". No puede ingresar inasistencias para esa fecha."))
		End if 
	Else 
		  //ACCEPT
		$resultado:=AL_validaIngresoAtraso ([Alumnos:2]numero:1;dFrom)
		If ($resultado=0)
			ACCEPT:C269
		Else 
			CD_Dlog (0;__ ("El alumno ya registra faltas por atraso. ")+"\r\r"+__ ("No puede ingresar Inasistencias."))
		End if 
	End if 
Else 
	CD_Dlog (0;__ ("Por favor complete los campos obligatorios (en rojo)"))
End if 