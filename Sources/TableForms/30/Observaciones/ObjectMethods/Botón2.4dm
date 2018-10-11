GET LIST ITEM:C378(hl_ObservacionesAlumno;Selected list items:C379(hl_ObservacionesAlumno);$itemRef;$itemText;$subList)
Case of 
	: ($itemRef<0)
		If ($subList#0)
			For ($i;Count list items:C380($subList);1;-1)
				GET LIST ITEM:C378($subList;$i;$subRef;$subText)
				$el:=Find in array:C230(alSTR_ObsEval_RefObs;$subRef)
				If ($el>0)
					AT_Delete ($el;1;->atSTR_ObsEval_Categoria;->atSTR_ObsEval_Observacion;->alSTR_ObsEval_RefObs)
					READ WRITE:C146([Alumnos_ObservacionesEvaluacion:30])
					QUERY:C277([Alumnos_ObservacionesEvaluacion:30];[Alumnos_ObservacionesEvaluacion:30]ID_Asignatura:2;=;vlSTR_CurrentAsignaturaID;*)
					QUERY:C277([Alumnos_ObservacionesEvaluacion:30]; & ;[Alumnos_ObservacionesEvaluacion:30]ID_Alumno:1;=;vlSTR_CurrentAlumnoID;*)
					QUERY:C277([Alumnos_ObservacionesEvaluacion:30]; & ;[Alumnos_ObservacionesEvaluacion:30]Periodo:3;=;vlSTR_PeriodoObservaciones;*)
					QUERY:C277([Alumnos_ObservacionesEvaluacion:30]; & [Alumnos_ObservacionesEvaluacion:30]Ref_Observacion:10;=;$subRef)
					DELETE RECORD:C58([Alumnos_ObservacionesEvaluacion:30])
					READ ONLY:C145([Alumnos_ObservacionesEvaluacion:30])
				End if 
				DELETE FROM LIST:C624($subList;$subRef)
			End for 
		End if 
		DELETE FROM LIST:C624(hl_ObservacionesAlumno;$itemRef)
		_O_REDRAW LIST:C382(hl_ObservacionesAlumno)
		modobservaciones:=True:C214
		
	: ($itemRef>0)
		$el:=Find in array:C230(alSTR_ObsEval_RefObs;$itemRef)
		If ($el>0)
			AT_Delete ($el;1;->atSTR_ObsEval_Categoria;->atSTR_ObsEval_Observacion;->alSTR_ObsEval_RefObs)
			READ WRITE:C146([Alumnos_ObservacionesEvaluacion:30])
			QUERY:C277([Alumnos_ObservacionesEvaluacion:30];[Alumnos_ObservacionesEvaluacion:30]ID_Asignatura:2;=;vlSTR_CurrentAsignaturaID;*)
			QUERY:C277([Alumnos_ObservacionesEvaluacion:30]; & ;[Alumnos_ObservacionesEvaluacion:30]ID_Alumno:1;=;vlSTR_CurrentAlumnoID;*)
			QUERY:C277([Alumnos_ObservacionesEvaluacion:30]; & ;[Alumnos_ObservacionesEvaluacion:30]Periodo:3;=;vlSTR_PeriodoObservaciones;*)
			QUERY:C277([Alumnos_ObservacionesEvaluacion:30]; & [Alumnos_ObservacionesEvaluacion:30]Ref_Observacion:10;=;$itemRef)
			DELETE RECORD:C58([Alumnos_ObservacionesEvaluacion:30])
			READ ONLY:C145([Alumnos_ObservacionesEvaluacion:30])
		End if 
		$parentRef:=List item parent:C633(hl_ObservacionesAlumno;$itemRef)
		DELETE FROM LIST:C624(hl_ObservacionesAlumno;$itemRef)
		_O_REDRAW LIST:C382(hl_ObservacionesAlumno)
		SELECT LIST ITEMS BY REFERENCE:C630(hl_ObservacionesAlumno;$parentRef)
		GET LIST ITEM:C378(hl_ObservacionesAlumno;Selected list items:C379(hl_ObservacionesAlumno);$itemRef;$itemText;$subList)
		If ($subList>0)
			$items:=Count list items:C380($subList)
			If ($items=0)
				DELETE FROM LIST:C624(hl_ObservacionesAlumno;$parentRef)
			End if 
		Else 
			DELETE FROM LIST:C624(hl_ObservacionesAlumno;$parentRef)
		End if 
		_O_REDRAW LIST:C382(hl_ObservacionesAlumno)
		modobservaciones:=True:C214
End case 