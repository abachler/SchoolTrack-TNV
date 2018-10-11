C_LONGINT:C283($line;$col;$fia;$l_rn;$ris)
C_TEXT:C284($t_menu;$t_opcSel;$t_mensaje)
LISTBOX GET CELL POSITION:C971(LB_AluASig;$col;$line)
Case of 
	: ((Form event:C388=On Clicked:K2:4) & (($line>0) & ($line<=Size of array:C274(a_LB_AADIAP_asignatura))))
		
		Case of 
			: ($col=1)  //Orden
				
				
			: ($col=2)  //Abreviatura
				  //se ingresa al seleccinar una asignatura
				
			: ($col=3) & ($line>1)  //Asignatura, la primera es la obligatoria no se puede cambiar desde aquí
				
				$t_menu:=MNU_CreaMenu_arreglo (->at_menu_subsector)
				$t_opcSel:=Dynamic pop up menu:C1006($t_menu)
				RELEASE MENU:C978($t_menu)
				
				If ($t_opcSel#"")
					$fia:=Find in array:C230(at_menu_subsector;$t_opcSel)
					READ ONLY:C145([Alumnos_Calificaciones:208])
					
					QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Alumno:6=al_ID_alumnos{al_ID_alumnos};*)
					QUERY:C277([Alumnos_Calificaciones:208]; & ;[Alumnos_Calificaciones:208]Año:3=<>gyear)
					QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas:18]Materia_UUID:46=at_menu_subsector_UUID{$fia})
					$ris:=Records in selection:C76([Alumnos_Calificaciones:208])
					
					If ($ris=1)
						
						$fia:=Find in array:C230(a_id_asignatura;[Alumnos_Calificaciones:208]ID_Asignatura:5)
						
						If ($fia=-1)
							
							READ WRITE:C146([DIAP_AlumnosAsignaturas:225])
							$l_rn:=Find in field:C653([DIAP_AlumnosAsignaturas:225]Auto_UUID:1;a_inscripcion_UUID{$line})
							If ($l_rn>=0)
								GOTO RECORD:C242([DIAP_AlumnosAsignaturas:225];$l_rn)
								[DIAP_AlumnosAsignaturas:225]ID_Asignatura:3:=[Alumnos_Calificaciones:208]ID_Asignatura:5
								SAVE RECORD:C53([DIAP_AlumnosAsignaturas:225])
								
								a_LB_AADIAP_asignatura{$line}:=KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[Alumnos_Calificaciones:208]ID_Asignatura:5;->[Asignaturas:18]Asignatura:3)
								a_LB_AADIAP_abrev{$line}:=KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[Alumnos_Calificaciones:208]ID_Asignatura:5;->[Asignaturas:18]Abreviación:26)
								a_id_asignatura{$line}:=[Alumnos_Calificaciones:208]ID_Asignatura:5
								  //MONO TICKET 197234
								  //verificamos que esté marcada la propiedad de evaluaciones especiales dentro del objeto opciones
								READ WRITE:C146([Asignaturas:18])
								QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=[Alumnos_Calificaciones:208]ID_Asignatura:5)
								$b_usaEvaEspecial:=OB Get:C1224([Asignaturas:18]Opciones:57;"usaEvaluacionesEspeciales")
								If (Not:C34($b_usaEvaEspecial))
									$llaveAsig:=String:C10(<>gInstitucion)+"."+String:C10(<>gyear)+"."+String:C10(Abs:C99([Asignaturas:18]Numero:1))
									AS_creaRegistrosAluEvaEspecial ($llaveAsig)
									OB SET:C1220([Asignaturas:18]Opciones:57;"usaEvaluacionesEspeciales";True:C214)
									SAVE RECORD:C53([Asignaturas:18])
								End if 
								KRL_UnloadReadOnly (->[Asignaturas:18])
								
							End if 
							KRL_UnloadReadOnly (->[DIAP_AlumnosAsignaturas:225])
							
						Else 
							CD_Dlog (0;"El alumno ya tiene inscrito una asignatura del subsector "+$t_opcSel)
						End if 
						
					Else 
						
						If ($ris=0)
							$t_mensaje:="El alumno no está inscrito en ninguna asignatura del subsector "+$t_opcSel
						Else 
							$t_mensaje:="El alumno está inscrito en más de una asignatura del subsector "+$t_opcSel+" por favor revise que esté en sólo una para tener sus evaluaciones criteriales"
						End if 
						
						CD_Dlog (0;$t_mensaje)
						
					End if 
					
				End if 
				
			: ($col=4)  //examen
				
				$t_menu:=MNU_CreaMenu_arreglo (->a_LB_TipoEVA)
				$t_opcSel:=Dynamic pop up menu:C1006($t_menu)
				
				If ($t_opcSel#"")
					
					$fia:=Find in array:C230(a_LB_TipoEVA;$t_opcSel)
					
					READ WRITE:C146([DIAP_AlumnosAsignaturas:225])
					$l_rn:=Find in field:C653([DIAP_AlumnosAsignaturas:225]Auto_UUID:1;a_inscripcion_UUID{$line})
					If ($l_rn>=0)
						GOTO RECORD:C242([DIAP_AlumnosAsignaturas:225];$l_rn)
						[DIAP_AlumnosAsignaturas:225]ID_TipoExamen:6:=a_LB_IdTipoEva{$fia}
						SAVE RECORD:C53([DIAP_AlumnosAsignaturas:225])
						a_LB_AADIAP_tipoExamen{$line}:=$t_opcSel
						a_id_tipoexamen{$line}:=a_LB_IdTipoEva{$fia}
					End if 
					KRL_UnloadReadOnly (->[DIAP_AlumnosAsignaturas:225])
					
				End if 
				
				RELEASE MENU:C978($t_menu)
				
			: ($col=5)  //lengua materna
				
				$t_menu:=MNU_CreaMenu_arreglo (->a_LB_LenguaMaterna)
				$t_opcSel:=Dynamic pop up menu:C1006($t_menu)
				If ($t_opcSel#"")
					$fia:=Find in array:C230(a_LB_LenguaMaterna;$t_opcSel)
					
					READ WRITE:C146([DIAP_AlumnosAsignaturas:225])
					$l_rn:=Find in field:C653([DIAP_AlumnosAsignaturas:225]Auto_UUID:1;a_inscripcion_UUID{$line})
					If ($l_rn>=0)
						GOTO RECORD:C242([DIAP_AlumnosAsignaturas:225];$l_rn)
						[DIAP_AlumnosAsignaturas:225]ID_Idioma:5:=a_LB_IdLenguaMaterna{$fia}
						SAVE RECORD:C53([DIAP_AlumnosAsignaturas:225])
						a_LB_AADIAP_IdiomaMaterno{$line}:=$t_opcSel
						a_id_lenguaMaterna{$line}:=a_LB_IdLenguaMaterna{$fia}
					End if 
					KRL_UnloadReadOnly (->[DIAP_AlumnosAsignaturas:225])
					
				End if 
				
				RELEASE MENU:C978($t_menu)
				
		End case 
		
		OBJECT SET ENABLED:C1123(*;"bInscribeAlu";(Size of array:C274(a_LB_AADIAP_asignatura)<5))
		OBJECT SET ENABLED:C1123(*;"bDesinscribeAlu";(Size of array:C274(a_LB_AADIAP_asignatura)>1))
		
End case 