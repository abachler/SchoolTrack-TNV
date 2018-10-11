C_LONGINT:C283($noNivel)

GET LIST ITEM:C378(hl_MenuNiveles;*;$NumeroNivel;$nombreNivel)



If ($numeroNivel#0)
	If (Size of array:C274(aNtaStdNme)>0)
		BEEP:C151
		CD_Dlog (0;__ ("Ya hay alumnos en este curso o asignaturas definidas. No es posible modificarlo."))
	Else 
		$recNum:=Find in field:C653([xxSTR_Niveles:6]NoNivel:5;$NumeroNivel)
		KRL_GotoRecord (->[xxSTR_Niveles:6];$recNum)
		[Asignaturas:18]Numero_del_Nivel:6:=$NumeroNivel
		[Asignaturas:18]Nivel:30:=$nombreNivel
		If ((Not:C34([Asignaturas:18]Seleccion:17)) & ([Asignaturas:18]Curso:5#""))
			$l_nivelCurso:=KRL_GetNumericFieldData (->[Cursos:3]Curso:1;->[Asignaturas:18]Curso:5;->[Cursos:3]Nivel_Numero:7)
			If ($l_nivelCurso#$NumeroNivel)
				[Asignaturas:18]Curso:5:=""
			End if 
		End if 
		AS_fSave 
	End if 
	
	AS_AsignaNumeroOrdenamiento 
	ARRAY TEXT:C222(aCursos;0)
	READ ONLY:C145([xxSTR_Niveles:6])
	QUERY:C277([Cursos:3];[Cursos:3]Nivel_Numero:7=[Asignaturas:18]Numero_del_Nivel:6;*)
	QUERY:C277([Cursos:3]; & ;[Cursos:3]Numero_del_curso:6>0)  //ABC//20180315//201139 
	ORDER BY:C49([Cursos:3];[Cursos:3]Nivel_Numero:7;>;[Cursos:3]Curso:1;>)
	SELECTION TO ARRAY:C260([Cursos:3]Curso:1;aCursos)
	INSERT IN ARRAY:C227(aCursos;Size of array:C274(aCursos)+1;2)
	aCursos{Size of array:C274(aCursos)-1}:="-"
	aCursos{Size of array:C274(aCursos)}:=__ ("Selección")
	PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
	AS_OnActivate 
	
	AS_PopupCopiaNomina 
End if 


