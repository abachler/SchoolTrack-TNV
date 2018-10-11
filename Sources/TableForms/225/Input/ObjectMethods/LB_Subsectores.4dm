C_LONGINT:C283($col;$line;$c;$i;$resp;$proc;$ris)
C_TEXT:C284($mensaje;$ssob_selecionado;$ssob_nuevo)
LISTBOX GET CELL POSITION:C971(LB_Subsectores;$col;$line)

Case of 
	: ((Form event:C388=On Data Change:K2:15) & ($col=2) & ($line>0))
		
		If (Not:C34(a_LB_MateriaDisponible{$line}))
			
			ARRAY TEXT:C222($at_curso;0)
			For ($c;1;Size of array:C274(a_LB_CursoDisponible))
				If (a_LB_CursoDisponible{$c})
					APPEND TO ARRAY:C911($at_curso;a_LB_Curso{$c})
				End if 
			End for 
			
			READ ONLY:C145([Alumnos:2])
			READ ONLY:C145([Alumnos_Calificaciones:208])
			READ WRITE:C146([DIAP_AlumnosAsignaturas:225])
			QUERY WITH ARRAY:C644([Alumnos:2]curso:20;$at_curso)
			QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Status:50#"Retirado@")
			
			If (Records in selection:C76([Alumnos:2])>0)
				KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Alumno:6;->[Alumnos:2]numero:1;"")
				QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas:18]Materia_UUID:46=a_LB_UUID_Materia{$line})
				KRL_RelateSelection (->[DIAP_AlumnosAsignaturas:225]ID_Asignatura:3;->[Alumnos_Calificaciones:208]ID_Asignatura:5;"")
				QUERY SELECTION:C341([DIAP_AlumnosAsignaturas:225];[DIAP_AlumnosAsignaturas:225]Año:7=<>gyear)
				$ris:=Records in selection:C76([DIAP_AlumnosAsignaturas:225])
				If ($ris>0)
					$resp:=CD_Dlog (0;"Existen "+String:C10($ris)+" alumnos inscritos con este subsector en el DIAP, ¿Desea continuar y eliminar las inscripciones a este subsector ?";"";"Si";"No")
					If ($resp=1)
						$proc:=IT_UThermometer (1;0;"Eliminando inscripciones")
						DELETE SELECTION:C66([DIAP_AlumnosAsignaturas:225])
						IT_UThermometer (-2;$proc)
						LOG_RegisterEvt ("DIAP: Se eliminan "+String:C10($ris)+" inscripciones a "+a_LB_Materia{$line}+" por ser quitado como subsector disponible para DIAP")
					Else 
						
					End if 
					
				End if 
			End if 
			
		End if 
		
		KRL_UnloadReadOnly (->[DIAP_AlumnosAsignaturas:225])
		
	: ((Form event:C388=On Double Clicked:K2:5) & ($col=1) & ($line>0))  //Establecer asignatura obligatoria
		
		If (t_UUID_MAteriaObligatoria#a_LB_UUID_Materia{$line})
			
			If (t_UUID_MAteriaObligatoria="")
				$resp:=1
			Else 
				$fia:=Find in array:C230(a_LB_UUID_Materia;t_UUID_MAteriaObligatoria)
				$ssob_selecionado:=a_LB_UUID_Materia{$fia}
				$ssob_nuevo:=a_LB_UUID_Materia{$line}
				$resp:=CD_Dlog (0;"¿Desea realmente cambiar el subsector obligatorio actual "+a_LB_Materia{$fia}+" para el DIAP, por "+a_LB_Materia{$line}+" ?";"";"Si";"No")
			End if 
			
			If ($resp=1)
				
				READ WRITE:C146([DIAP_AlumnosAsignaturas:225])
				QUERY:C277([DIAP_AlumnosAsignaturas:225];[DIAP_AlumnosAsignaturas:225]Año:7=<>gyear)
				QUERY SELECTION:C341([DIAP_AlumnosAsignaturas:225];[DIAP_AlumnosAsignaturas:225]Materia_UUID:8=t_UUID_MAteriaObligatoria)
				DELETE SELECTION:C66([DIAP_AlumnosAsignaturas:225])
				KRL_UnloadReadOnly (->[DIAP_AlumnosAsignaturas:225])
				  //testear cursos disponibles para crear la asignatura obligatoria
				ARRAY TEXT:C222($at_curso;0)
				
				For ($c;1;Size of array:C274(a_LB_CursoDisponible))
					If (a_LB_CursoDisponible{$c})
						APPEND TO ARRAY:C911($at_curso;a_LB_Curso{$c})
					End if 
				End for 
				
				READ ONLY:C145([Alumnos:2])
				READ ONLY:C145([Alumnos_Calificaciones:208])
				QUERY WITH ARRAY:C644([Alumnos:2]curso:20;$at_curso)
				QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Status:50#"Retirado@")
				
				If (Records in selection:C76([Alumnos:2])>0)
					ARRAY LONGINT:C221($al_rnAC;0)
					KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Alumno:6;->[Alumnos:2]numero:1;"")
					QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas:18]Materia_UUID:46=a_LB_UUID_Materia{$line})
					  //hay que revisar que todos los alumnos tengan la asignatura a la que corresponde el uuid de subsector
					
					If (Records in selection:C76([Alumnos_Calificaciones:208])=Records in selection:C76([Alumnos:2]))
						LONGINT ARRAY FROM SELECTION:C647([Alumnos_Calificaciones:208];$al_rnAC;"")
						
						$l_idTermometro:=IT_Progress (1;0;0;"Inscribiendo alumnos en el subsector obligatorio...")
						For ($i;1;Size of array:C274($al_rnAC))
							$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i/Size of array:C274($al_rnAC))
							GOTO RECORD:C242([Alumnos_Calificaciones:208];$al_rnAC{$i})
							DIAP_InscribeAsignatura ([Alumnos_Calificaciones:208]ID_Alumno:6;[Alumnos_Calificaciones:208]ID_Asignatura:5;1;1;1)
						End for 
						IT_Progress (-1;$l_idTermometro)
						
						t_UUID_MAteriaObligatoria:=a_LB_UUID_Materia{$line}
						$fia:=Find in array:C230(a_LB_UUID_Materia;t_UUID_MAteriaObligatoria)
						If ($fia>0)
							a_LB_MateriaEstilo{$fia}:=Bold:K14:2
						End if 
						
						C_BLOB:C604($xBlob)
						SET BLOB SIZE:C606($xBlob;0)
						BLOB_Blob2Vars (->$xBlob;0;->a_LB_UUID_Materia;->a_LB_MateriaDisponible;->t_UUID_MAteriaObligatoria)
						PREF_SetBlob (0;"DIAP_SubsectoresDisponibles";$xBlob)
						
						LOG_RegisterEvt ("DIAP: Fue cambiado el subsector obligatorio de DIAP de "+$ssob_selecionado+" pasó a ser "+$ssob_nuevo)
						
					Else 
						  //avisar que faltan alumnos inscritos en la asignatura del subsector seleccionado
						If (Records in selection:C76([Alumnos:2])>Records in selection:C76([Alumnos_Calificaciones:208]))
							$mensaje:="De "+String:C10(Records in selection:C76([Alumnos:2]))+" alumnos, sólo "+String:C10(Records in selection:C76([Alumnos_Calificaciones:208]))+" están inscritos en el subsector seleccionado, por favor inscriba a los que faltan en la asignatura del subsector que seleccionó."
						Else 
							$mensaje:="Existen alumnos que están en mas de una asignatura relacionada al subsector seleccionado, por favor revise este conflicto."
						End if 
						
						CD_Dlog (0;$mensaje)
						
					End if 
					
				End if 
				
			End if 
			
		End if 
		
End case 