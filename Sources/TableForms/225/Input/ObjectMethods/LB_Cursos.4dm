C_LONGINT:C283($col;$line;$c;$i;$resp;$proc;$ris)
C_TEXT:C284($mensaje;$ssob_selecionado;$ssob_nuevo)
LISTBOX GET CELL POSITION:C971(LB_Cursos;$col;$line)
Case of 
	: ((Form event:C388=On Data Change:K2:15) & ($col=2) & ($line>0))
		
		If (a_LB_CursoDisponible{$line})
			  //inscribir asignatura obligatoria para los alumnos del curso seleccionado para DIAP 
			ARRAY LONGINT:C221($al_id_alu;0)
			ARRAY LONGINT:C221($al_id_asig;0)
			
			READ ONLY:C145([Alumnos:2])
			QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=a_LB_Curso{$line})
			KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Alumno:6;->[Alumnos:2]numero:1;"")
			QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas:18]Materia_UUID:46=t_UUID_MAteriaObligatoria)
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]ID_Alumno:6;$al_id_alu;[Alumnos_Calificaciones:208]ID_Asignatura:5;$al_id_asig)
			
			$l_idTermometro:=IT_Progress (1;0;0;"Inscribiendo alumnos en el subsector obligatorio...")
			For ($i;1;Size of array:C274($al_id_alu))
				$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i/Size of array:C274($al_id_alu))
				DIAP_InscribeAsignatura ($al_id_alu{$i};$al_id_asig{$i};1;1;1)
				DIAP_CreaRegistroObservacion ($al_id_alu{$i})
			End for 
			IT_Progress (-1;$l_idTermometro)
			  //MONO TICKET 197234
			AT_DistinctsArrayValues (->$al_id_asig)
			For ($i;1;Size of array:C274($al_id_asig))
				READ WRITE:C146([Asignaturas:18])
				QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=$al_id_asig{$i})
				$b_usaEvaEspecial:=OB Get:C1224([Asignaturas:18]Opciones:57;"usaEvaluacionesEspeciales")
				If (Not:C34($b_usaEvaEspecial))
					$llaveAsig:=String:C10(<>gInstitucion)+"."+String:C10(<>gyear)+"."+String:C10(Abs:C99([Asignaturas:18]Numero:1))
					AS_creaRegistrosAluEvaEspecial ($llaveAsig)
					OB SET:C1220([Asignaturas:18]Opciones:57;"usaEvaluacionesEspeciales";True:C214)
					SAVE RECORD:C53([Asignaturas:18])
				End if 
				KRL_UnloadReadOnly (->[Asignaturas:18])
			End for 
			
		Else 
			  //preguntar si realmente quiere quitar al curso del diap y sio confirma eliminará las inscripciones de este.
			READ WRITE:C146([DIAP_AlumnosAsignaturas:225])
			READ ONLY:C145([Alumnos:2])
			QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=a_LB_Curso{$line})
			KRL_RelateSelection (->[DIAP_AlumnosAsignaturas:225]ID_Alumno:2;->[Alumnos:2]numero:1;"")
			QUERY SELECTION:C341([DIAP_AlumnosAsignaturas:225];[DIAP_AlumnosAsignaturas:225]Año:7=<>gyear)
			$ris:=Records in selection:C76([DIAP_AlumnosAsignaturas:225])
			If ($ris>0)
				$mensaje:="Existen "+String:C10($ris)+" inscripciones relacionadas al curso "+a_LB_Curso{$line}+", si es lo quita de la disponibilidad para el DIAP estas inscripciones serán eliminada. ¿Desea continuar esta operación?"
				$resp:=CD_Dlog (0;$mensaje;"";"Si";"No")
				
				If ($resp=1)
					$proc:=IT_UThermometer (1;0;"Eliminando inscripciones")
					DELETE SELECTION:C66([DIAP_AlumnosAsignaturas:225])
					IT_UThermometer (-2;$proc)
					LOG_RegisterEvt ("DIAP: Son eliminadas "+String:C10($ris)+" inscripciones del "+a_LB_Curso{$line}+" al ser retirado como curso disponible para DIAP")
				Else 
					a_LB_CursoDisponible{$line}:=True:C214
				End if 
				
			End if 
			
			KRL_UnloadReadOnly (->[DIAP_AlumnosAsignaturas:225])
			
		End if 
End case 