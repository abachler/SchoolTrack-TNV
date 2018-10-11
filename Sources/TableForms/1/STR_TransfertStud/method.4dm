Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		ARRAY TEXT:C222(<>aPlantel;0)
		QUERY WITH ARRAY:C644([Cursos:3]Nivel_Numero:7;<>al_NumeroNivelesActivos)
		ORDER BY:C49([Cursos:3];[Cursos:3]Nivel_Numero:7;>;[Cursos:3]Curso:1;>)
		SELECTION TO ARRAY:C260([Cursos:3]Curso:1;atSTR_CursoOrigen;[Cursos:3]Curso:1;atSTR_CursoDestino)
		
		INSERT IN ARRAY:C227(atSTR_CursoDestino;Size of array:C274(atSTR_CursoDestino)+1;4)
		atSTR_CursoDestino{Size of array:C274(atSTR_CursoDestino)-3}:="-"
		atSTR_CursoDestino{Size of array:C274(atSTR_CursoDestino)-2}:="Admisión"
		atSTR_CursoDestino{Size of array:C274(atSTR_CursoDestino)-1}:="Retirados"
		atSTR_CursoDestino{Size of array:C274(atSTR_CursoDestino)}:="Egresados"
		atSTR_CursoDestino:=0
		$err:=AL_SetArraysNam (xALP_Trans2;1;1;"◊aPlantel")
		AL_SetHeaders (xALP_Trans2;1;1;__ ("Alumnos"))
		ALP_SetDefaultAppareance (xALP_Trans2;11;1;2;1;4)
		AL_SetSort (xALP_Trans2;1)
		AL_SetWidths (xALP_Trans2;1;1;232)
		AL_SetMiscOpts (xALP_Trans2;0;0;"'";0;1)
		AL_SetColOpts (xALP_Trans2;0;0;0;1;0;0;0)
		AL_SetRowOpts (xALP_Trans2;1;0;1;0;0)
		AL_SetSortOpts (xALP_Trans2;1;0;0;"";0)
		AL_SetScroll (xALP_Trans2;0;-3)
		
		
		INSERT IN ARRAY:C227(atSTR_CursoOrigen;Size of array:C274(atSTR_CursoOrigen)+1;4)
		atSTR_CursoOrigen{Size of array:C274(atSTR_CursoOrigen)-3}:="-"
		atSTR_CursoOrigen{Size of array:C274(atSTR_CursoOrigen)-2}:="Admisión"
		atSTR_CursoOrigen{Size of array:C274(atSTR_CursoOrigen)-1}:="Retirados"
		atSTR_CursoOrigen{Size of array:C274(atSTR_CursoOrigen)}:="Egresados"
		atSTR_CursoOrigen:=Size of array:C274(atSTR_CursoOrigen)-2
		QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29;=;Nivel_AdmisionDirecta*1)
		SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;<>aStdWhNme;[Alumnos:2]numero:1;<>aStdID;[Alumnos:2]Situacion_final:33;<>aStatPromo)
		$err:=AL_SetArraysNam (xALP_Trans1;1;3;"◊aStdWhNme";"◊aStatPromo";"◊aStdId")
		AL_SetHeaders (xALP_Trans1;1;2;__ ("Alumnos");__ ("Sit. Final"))
		ALP_SetDefaultAppareance (xALP_Trans1;11;1;2;1;4)
		AL_SetSort (xALP_Trans1;1)
		AL_SetWidths (xALP_Trans1;1;2;180;52)
		AL_SetMiscOpts (xALP_Trans1;0;0;"\\";0;1)
		AL_SetColOpts (xALP_Trans1;0;0;0;1;0;0;0)
		AL_SetRowOpts (xALP_Trans1;1;1;0;0;0)
		AL_SetSortOpts (xALP_Trans1;1;0;0;"";0)
		AL_SetScroll (xALP_Trans1;0;-3)
		ARRAY INTEGER:C220(alLines;0)
		AL_SetSelect (xALP_Trans1;alLines)
		_O_DISABLE BUTTON:C193(b_Selección)
		If ((Size of array:C274(<>aStdWhNme)>0) & (atSTR_CursoOrigen>0) & (atSTR_CursoDestino>0))
			_O_ENABLE BUTTON:C192(b_todos)
		Else 
			_O_DISABLE BUTTON:C193(b_Todos)
		End if 
		
	: (Form event:C388=On Clicked:K2:4)
		If ((Size of array:C274(<>aStdWhNme)>0) & (atSTR_CursoOrigen>0) & (atSTR_CursoDestino>0))
			_O_ENABLE BUTTON:C192(b_todos)
			$r:=AL_GetSelect (xALP_Trans1;alLines)
			If ($r#1)
				$r:=CD_Dlog (2;__ ("No hay suficiente memoria para conservar la selección."))
				ARRAY INTEGER:C220(alLines;0)
			End if 
			If ((Size of array:C274(alLines)#0) & (atSTR_CursoOrigen>0) & (atSTR_CursoDestino>0))
				_O_ENABLE BUTTON:C192(b_Selección)
			Else 
				_O_DISABLE BUTTON:C193(b_Selección)
			End if 
		Else 
			_O_DISABLE BUTTON:C193(b_Selección)
			_O_DISABLE BUTTON:C193(b_Todos)
		End if 
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Outside Call:K2:11)
		XS_SetInterface 
		ALP_SetInterface (xALP_Trans1)
		ALP_SetInterface (xALP_Trans2)
		
End case 
