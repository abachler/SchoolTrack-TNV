//%attributes = {}
  // Método: XALCB_EX_HObs_Asignaturas
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 02/11/09, 09:40:03
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal

  //XALCB_EX_HObs_Asignaturas

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2)
C_LONGINT:C283($col;$row)

If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	If (AL_GetCellMod (xALP_HNotasECursos)=1)
		AL_GetCurrCell (xALP_HNotasECursos;$col;$row)
		modObservaciones:=True:C214
		aPJObs{$row}:=ST_clearUnNecessaryCR (ST_ClrWildChars (aPJObs{$row}))
		AL_UpdateArrays (xALP_HNotasECursos;-2)
		
		KRL_ReloadInReadWriteMode (->[Alumnos_ComplementoEvaluacion:209])
		
		Case of 
			: (Size of array:C274(aPJObs)=3)
				Case of 
					: ($row=1)
						[Alumnos_ComplementoEvaluacion:209]P01_Obs_Academicas:19:=aPJObs{$row}
					: ($row=2)
						[Alumnos_ComplementoEvaluacion:209]P02_Obs_Academicas:24:=aPJObs{$row}
					: ($row=3)
						[Alumnos_ComplementoEvaluacion:209]Final_ObservacionesAcademicas:46:=aPJObs{$row}
				End case 
				
			: (Size of array:C274(aPJObs)=4)
				Case of 
					: ($row=1)
						[Alumnos_ComplementoEvaluacion:209]P01_Obs_Academicas:19:=aPJObs{$row}
					: ($row=2)
						[Alumnos_ComplementoEvaluacion:209]P02_Obs_Academicas:24:=aPJObs{$row}
					: ($row=3)
						[Alumnos_ComplementoEvaluacion:209]P03_Obs_Academicas:29:=aPJObs{$row}
					: ($row=4)
						[Alumnos_ComplementoEvaluacion:209]Final_ObservacionesAcademicas:46:=aPJObs{$row}
				End case 
				
				
			: (Size of array:C274(aPJObs)=5)
				Case of 
					: ($row=1)
						[Alumnos_ComplementoEvaluacion:209]P01_Obs_Academicas:19:=aPJObs{$row}
					: ($row=2)
						[Alumnos_ComplementoEvaluacion:209]P02_Obs_Academicas:24:=aPJObs{$row}
					: ($row=3)
						[Alumnos_ComplementoEvaluacion:209]P03_Obs_Academicas:29:=aPJObs{$row}
					: ($row=4)
						[Alumnos_ComplementoEvaluacion:209]P04_Obs_Academicas:34:=aPJObs{$row}
					: ($row=5)
						[Alumnos_ComplementoEvaluacion:209]Final_ObservacionesAcademicas:46:=aPJObs{$row}
				End case 
				
				
			: (Size of array:C274(aPJObs)=6)
				Case of 
					: ($row=1)
						[Alumnos_ComplementoEvaluacion:209]P01_Obs_Academicas:19:=aPJObs{$row}
					: ($row=2)
						[Alumnos_ComplementoEvaluacion:209]P02_Obs_Academicas:24:=aPJObs{$row}
					: ($row=3)
						[Alumnos_ComplementoEvaluacion:209]P03_Obs_Academicas:29:=aPJObs{$row}
					: ($row=4)
						[Alumnos_ComplementoEvaluacion:209]P04_Obs_Academicas:34:=aPJObs{$row}
					: ($row=5)
						[Alumnos_ComplementoEvaluacion:209]P05_Obs_Academicas:39:=aPJObs{$row}
					: ($row=6)
						[Alumnos_ComplementoEvaluacion:209]Final_ObservacionesAcademicas:46:=aPJObs{$row}
				End case 
				
		End case 
		
		SAVE RECORD:C53([Alumnos_ComplementoEvaluacion:209])
		KRL_ReloadAsReadOnly (->[Alumnos_ComplementoEvaluacion:209])
		
		$nombreAñoEscolar:=KRL_GetTextFieldData (->[xxSTR_DatosDeCierre:24]Year:1;->vl_Year_Historico;->[xxSTR_DatosDeCierre:24]NombreAgnoEscolar:5)
		LOG_RegisterEvt ("Modificación en observaciones históricas para "+[Alumnos:2]apellidos_y_nombres:40+" en la asignatura "+[Alumnos_Calificaciones:208]NombreInternoAsignatura:8+", año "+$nombreAñoEscolar)
	End if 
End if 


