  //If (Form event=On Data Change )

READ ONLY:C145([ACT_CuentasCorrientes:175])
REDUCE SELECTION:C351([ACT_CuentasCorrientes:175];0)
If (Records in selection:C76([Alumnos:2])=1)
	vtACT_Alumno:=[Alumnos:2]apellidos_y_nombres:40
	vtACT_RUT:=[Alumnos:2]RUT:5
	vlACT_IDAlumno:=[Alumnos:2]numero:1
Else 
	vtACT_Alumno:=""
	vtACT_RUT:=""
	vlACT_IDAlumno:=0
End if 

If (vtACT_Alumno#"")
	vrACT_SaldoActual:=KRL_GetNumericFieldData (->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]Saldo_Ejercicio:21)
	READ ONLY:C145([Cursos:3])
	QUERY:C277([Cursos:3];[Cursos:3]Curso:1=[Alumnos:2]curso:20)
	If (Records in selection:C76([Cursos:3])=1)
		$vl_pos:=Find in array:C230(atACTp_Cursos;[Cursos:3]Curso:1)
		vtACT_Regimen:=[Cursos:3]Sala:3
		vtACT_Carrera:=[Cursos:3]Sede:19
		If ($vl_pos#-1)
			vtACT_Matriz:=atACTp_Matrices{$vl_pos}
			vrACT_MontoMatriz:=arACTp_Montos{$vl_pos}
			vlACT_Matriz:=alACTp_Matrices{$vl_pos}
		Else 
			vtACT_Matriz:=""
			vrACT_MontoMatriz:=0
			vlACT_Matriz:=0
		End if 
	Else 
		vtACT_Regimen:=""
		vtACT_Carrera:=""
		vtACT_Matriz:=""
		vrACT_MontoMatriz:=0
		vlACT_Matriz:=0
	End if 
End if 
  //End if 