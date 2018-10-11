If (<>vb_BloquearModifSituacionFinal)
	CD_Dlog (0;__ ("Cualquier acción que afecte la situación académica de los alumnos ha sido bloqueada a contar del ")+String:C10(<>vd_FechaBloqueoSchoolTrack;5)+__ ("."))
	Self:C308->:=Old:C35(Self:C308->)
Else 
	
	C_LONGINT:C283($periodo)
	C_BOOLEAN:C305($sumaHoras;$restaHoras)
	
	If (Self:C308->)
		$saved:=AS_fSave 
		If ($saved>=0)
			READ ONLY:C145([TMT_Horario:166])
			QUERY:C277([TMT_Horario:166];[TMT_Horario:166]ID_Asignatura:5=[Asignaturas:18]Numero:1)
			If (Records in selection:C76([TMT_Horario:166])=0)
				  // $ignore:=cd_Dlog (0;":21113,46")
			Else 
				OK:=CD_Dlog (0;__ ("SchoolTrack va a crear ahora las sesiones de clases necesarias para permitir el registro de asistencia horaria.\r\r¿Desea usted continuar?");__ ("");__ ("Si");__ ("No"))
				If (OK=1)
					$date:=adSTR_Periodos_Desde{1}
					KRL_ReloadAsReadOnly (->[Asignaturas:18])
					$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Creando registros de sesiones de clases para el ")+String:C10($date;7)+__ ("..."))
					$loops:=Current date:C33(*)-$date+1
					$i:=0
					While ($date<=Current date:C33(*))
						AS_CreaSesionesAsignatura ([Asignaturas:18]Numero:1;$date)
						$date:=$date+1
						$i:=$i+1
						$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/$loops;__ ("Creando registros de sesiones de clases para el ")+String:C10($date;7)+__ ("..."))
					End while 
					$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
					READ WRITE:C146([Asignaturas:18])
					LOAD RECORD:C52([Asignaturas:18])
					
					If (Old:C35([Asignaturas:18]Incide_en_Asistencia:45)=False:C215)
						$sumaHoras:=True:C214
					End if 
					
				Else 
					Self:C308->:=False:C215
				End if 
			End if 
		End if 
	Else 
		If (Old:C35([Asignaturas:18]Incide_en_Asistencia:45)=True:C214)
			$restaHoras:=True:C214
		End if 
	End if 
	
	If ($sumaHoras | $restaHoras)
		PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
		
		$pID:=IT_UThermometer (1;0;__ ("Recalculando porcentaje de asistencia..."))
		READ ONLY:C145([Asignaturas_Inasistencias:125])
		  //20121126 RCH-ABK Se cambia busqueda para no encontrar info de otros periodos
		  //QUERY([Asignaturas_Inasistencias];[Asignaturas_Inasistencias]ID_Asignatura=[Asignaturas]Numero)
		QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Asignatura:6=[Asignaturas:18]Numero:1;*)
		QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]dateSesion:4;>=;vdSTR_Periodos_InicioEjercicio;*)
		QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]dateSesion:4;<=;vdSTR_Periodos_FinEjercicio)
		SELECTION TO ARRAY:C260([Asignaturas_Inasistencias:125];$aRecNums)
		ARRAY LONGINT:C221($aRecNums;0)
		LONGINT ARRAY FROM SELECTION:C647([Asignaturas_Inasistencias:125];$aRecNums;"")
		For ($i;1;Size of array:C274($aRecNums))
			GOTO RECORD:C242([Asignaturas_Inasistencias:125];$aRecNums{$i})
			$devolverPeriodoMasCercano:=False:C215
			$periodo:=PERIODOS_PeriodosActuales ([Asignaturas_Inasistencias:125]dateSesion:4;$devolverPeriodoMasCercano)
			
			
			$idAlumno:=[Asignaturas_Inasistencias:125]ID_Alumno:2
			$key:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10([Asignaturas:18]Numero_del_Nivel:6)+"."+String:C10($idAlumno)
			KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$key;True:C214)
			If (OK=1)
				Case of 
					: ($periodo=1)
						$fieldPointer:=->[Alumnos_SintesisAnual:210]P01_Inasistencias_Horas:98
					: ($periodo=2)
						$fieldPointer:=->[Alumnos_SintesisAnual:210]P02_Inasistencias_Horas:127
					: ($periodo=3)
						$fieldPointer:=->[Alumnos_SintesisAnual:210]P03_Inasistencias_Horas:156
					: ($periodo=4)
						$fieldPointer:=->[Alumnos_SintesisAnual:210]P04_Inasistencias_Horas:185
					: ($periodo=5)
						$fieldPointer:=->[Alumnos_SintesisAnual:210]P05_Inasistencias_Horas:214
				End case 
				Case of 
					: ($sumaHoras)
						$fieldPointer->:=$fieldPointer->+1
						
					: ($restaHoras)
						$fieldPointer->:=$fieldPointer->-1
				End case 
				SAVE RECORD:C53([Alumnos_SintesisAnual:210])
				UNLOAD RECORD:C212([Alumnos_SintesisAnual:210])
				READ ONLY:C145([Alumnos_SintesisAnual:210])
			Else 
				$0:=BM_CreateRequest ("Totaliza Horas Inasistencia";String:C10($idAlumno))
			End if 
			
		End for 
		
		$pID:=IT_UThermometer (-2;$pID)
	End if 
End if 