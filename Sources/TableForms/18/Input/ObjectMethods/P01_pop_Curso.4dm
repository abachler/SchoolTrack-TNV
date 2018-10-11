
If (Size of array:C274(aCursos)>0)
	If (aCursos>0)
		If ((Size of array:C274(aNtaStdNme)>0) & (aCursos{aCursos}#[Asignaturas:18]Curso:5) & ([Asignaturas:18]Numero_del_Curso:25#0))
			$r:=CD_Dlog (1;__ ("Ya hay alumnos de ")+[Asignaturas:18]Curso:5+__ (" inscritos en esta asignatura.\rNo es posible modificar el curso."))
		Else 
			  //If (aCursos{aCursos}="Selección")
			If (aCursos=Size of array:C274(aCursos))
				  //$answ:=Substring(Request("Ingrese el nombre del grupo (10 car. max.):");1;10)
				$answ:=Substring:C12(CD_Request (__ ("Ingrese el nombre del grupo (10 car. max.):");__ ("Aceptar");__ ("");__ (""));1;10)
				If ($answ#"")
					[Asignaturas:18]Curso:5:=$answ
					[Asignaturas:18]Numero_del_Curso:25:=0
					[Asignaturas:18]Seleccion:17:=True:C214
					$rslt:=AS_fExist 
				End if 
			Else 
				$curso:=aCursos{aCursos}
				[Asignaturas:18]Seleccion:17:=False:C215
				QUERY:C277([Cursos:3];[Cursos:3]Curso:1=aCursos{aCursos})
				[Asignaturas:18]Curso:5:=aCursos{aCursos}
				[Asignaturas:18]Numero_del_Curso:25:=[Cursos:3]Numero_del_curso:6
				AS_AsignaNumeroOrdenamiento 
				$rslt:=AS_fExist 
			End if 
		End if 
	End if 
End if 
If (([Asignaturas:18]Asignatura:3#"") & ([Asignaturas:18]Curso:5#"") & (USR_checkRights ("M";->[Asignaturas:18])))
	AS_PopupCopiaNomina 
	_O_ENABLE BUTTON:C192(b_inscribir)
Else 
	_O_DISABLE BUTTON:C193(b_Inscribir)
End if 