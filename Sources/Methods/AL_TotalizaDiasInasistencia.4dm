//%attributes = {}
  //AL_TotalizaDiasInasistencia

C_LONGINT:C283($1;$2;$idAlumno;$nivel)
If (Not:C34(<>vb_BloquearModifSituacionFinal))
	$id_Alumno:=$1
	$recNum:=KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->$id_Alumno)
	If (Count parameters:C259=2)
		$nivel:=$2
	Else 
		$nivel:=[Alumnos:2]nivel_numero:29
	End if 
	
	If ($recNum>=0)
		PERIODOS_LoadData ($nivel)
		$modoRegistroAsistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivel;->[xxSTR_Niveles:6]AttendanceMode:3)
		
		If (($modoRegistroAsistencia=1) | ($modoRegistroAsistencia=2))
			READ ONLY:C145([Alumnos_Inasistencias:10])
			QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=$id_Alumno;*)
			QUERY:C277([Alumnos_Inasistencias:10]; & [Alumnos_Inasistencias:10]Fecha:1>=vdSTR_Periodos_InicioEjercicio;*)
			QUERY:C277([Alumnos_Inasistencias:10]; & [Alumnos_Inasistencias:10]Fecha:1<=vdSTR_Periodos_FinEjercicio)
			ARRAY LONGINT:C221($aRecNums;0)
			LONGINT ARRAY FROM SELECTION:C647([Alumnos_Inasistencias:10];$aRecNums;"")
			For ($i;1;Size of array:C274($aRecNums))
				  //GOTO RECORD([Alumnos_Inasistencias];$aRecNums{$i})
				KRL_GotoRecord (->[Alumnos_Inasistencias:10];$aRecNums{$i})
				  //lectura del número de periodo y subperiodo correspondiente a la fecha de la inasistencia
				$devolverPeriodoMasCercano:=False:C215
				$periodo:=PERIODOS_PeriodosActuales ([Alumnos_Inasistencias:10]Fecha:1;$devolverPeriodoMasCercano)
				
				
				  //se incrementan los valores de los totales en los registros de sintesis
				If ($periodo>0)
					Case of 
						: ($periodo=1)
							$y_Injustificadas:=->[Alumnos_SintesisAnual:210]P01_InasistenciasInjustif_Dias:117
							$y_Justificadas:=->[Alumnos_SintesisAnual:210]P01_InasistenciasJustif_Dias:116
						: ($periodo=2)
							$y_Injustificadas:=->[Alumnos_SintesisAnual:210]P02_InasistenciasInjustif_Dias:146
							$y_Justificadas:=->[Alumnos_SintesisAnual:210]P02_InasistenciasJustif_Dias:145
						: ($periodo=3)
							$y_Injustificadas:=->[Alumnos_SintesisAnual:210]P03_InasistenciasInjustif_Dias:175
							$y_Justificadas:=->[Alumnos_SintesisAnual:210]P03_InasistenciasJustif_Dias:174
						: ($periodo=4)
							$y_Injustificadas:=->[Alumnos_SintesisAnual:210]P04_InasistenciasInjustif_Dias:204
							$y_Justificadas:=->[Alumnos_SintesisAnual:210]P04_InasistenciasJustif_Dias:203
						: ($periodo=5)
							$y_Injustificadas:=->[Alumnos_SintesisAnual:210]P05_InasistenciasInjustif_Dias:233
							$y_Justificadas:=->[Alumnos_SintesisAnual:210]P05_InasistenciasJustif_Dias:232
					End case 
					
					$key:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10($nivel)+"."+String:C10($id_Alumno)
					KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$key;True:C214)
					If (OK=1)
						If ([Alumnos_Inasistencias:10]Justificación:2="")
							$y_Injustificadas->:=$y_Injustificadas->+1
						Else 
							$y_Justificadas->:=$y_Justificadas->+1
						End if 
						SAVE RECORD:C53([Alumnos_SintesisAnual:210])
						UNLOAD RECORD:C212([Alumnos_SintesisAnual:210])
					End if 
				End if 
			End for 
		End if 
	End if 
End if 