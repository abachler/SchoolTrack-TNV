If (<>vb_BloquearModifSituacionFinal)
	CD_Dlog (0;__ ("Cualquier acción que afecte la situación académica de los alumnos ha sido bloqueada a contar del ")+String:C10(<>vd_FechaBloqueoSchoolTrack;5)+__ ("."))
Else 
	READ ONLY:C145([Alumnos:2])
	viBWR_RecordWasSaved:=AS_fSave 
	
	If (viBWR_RecordWasSaved>=0)
		$idAsignatura:=[Asignaturas:18]Numero:1
		$esGrupal:=[Asignaturas:18]Seleccion:17
		$esElectiva:=[Asignaturas:18]Electiva:11
		$seleccionPorSexo:=[Asignaturas:18]Seleccion_por_sexo:24
		$curso:=[Asignaturas:18]Curso:5
		$recNum:=Record number:C243([Asignaturas:18])
		
		KRL_ReloadAsReadOnly (->[Asignaturas:18])
		AL_RemoveArrays (xALP_StdList;1;10)
		OBJECT SET VISIBLE:C603(xALP_StdList;False:C215)
		inscriptOK:=False:C215
		Case of 
			: (($esGrupal) | ($esElectiva))
				WDW_OpenFormWindow (->[Asignaturas:18];"StudSelection";9;4;__ ("Selección de alumnos");"wdw_CloseDlog")
				DIALOG:C40([Asignaturas:18];"StudSelection")
				CLOSE WINDOW:C154
				AS_OnActivate 
				
			: (Not:C34($esGrupal))
				QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=$curso)
				$msg:="Inscribiendo a todos los alumnos de "+$curso+" en "+[Asignaturas:18]denominacion_interna:16
				Case of 
					: ($seleccionPorSexo=2)
						QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Sexo:49="F")
						$msg:="Inscribiendo a todas las alumnas de "+$curso+" en "+[Asignaturas:18]denominacion_interna:16
					: ($seleccionPorSexo=3)
						QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Sexo:49="M")
						$msg:="Inscribiendo a todos los alumnos varones de "+$curso+" en "+[Asignaturas:18]denominacion_interna:16
				End case 
				$UThermo:=IT_UThermometer (1;0;$msg)
				QUERY:C277([Cursos:3];[Cursos:3]Curso:1=$curso)
				ORDER BY:C49([Alumnos:2];[Alumnos:2]apellidos_y_nombres:40;>)
				ARRAY LONGINT:C221($aRecNums;0)
				LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];$aRecNums;"")
				For ($i;1;Size of array:C274($aRecNums))
					GOTO RECORD:C242([Alumnos:2];$aRecNums{$i})
					AS_CreaRegistrosEvaluacion ([Alumnos:2]numero:1;$idAsignatura)
				End for 
				InscriptOK:=True:C214
				IT_UThermometer (-2;$UThermo)
		End case 
		
		KRL_GotoRecord (->[Asignaturas:18];$recNum;True:C214)
		
		OBJECT SET VISIBLE:C603(xALP_StdList;True:C214)
		AS_LoadStudentList 
	End if 
End if 