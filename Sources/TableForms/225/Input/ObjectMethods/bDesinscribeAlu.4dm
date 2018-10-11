C_LONGINT:C283($col;$line;$l_ordeneliminado)
LISTBOX GET CELL POSITION:C971(LB_AluASig;$col;$line)

If (($line>1) & ($line<=Size of array:C274(a_LB_AADIAP_asignatura)))
	
	READ WRITE:C146([DIAP_AlumnosAsignaturas:225])
	$l_rn:=Find in field:C653([DIAP_AlumnosAsignaturas:225]Auto_UUID:1;a_inscripcion_UUID{$line})
	If ($l_rn>=0)
		GOTO RECORD:C242([DIAP_AlumnosAsignaturas:225];$l_rn)
		DELETE RECORD:C58([DIAP_AlumnosAsignaturas:225])
		
		  //LB Alumnos Asignaturas DIAP
		DELETE FROM ARRAY:C228(a_LB_AADIAP_orden;$line)
		DELETE FROM ARRAY:C228(a_LB_AADIAP_abrev;$line)
		DELETE FROM ARRAY:C228(a_LB_AADIAP_asignatura;$line)
		DELETE FROM ARRAY:C228(a_LB_AADIAP_tipoExamen;$line)
		DELETE FROM ARRAY:C228(a_LB_AADIAP_IdiomaMaterno;$line)
		DELETE FROM ARRAY:C228(a_inscripcion_UUID;$line)
		DELETE FROM ARRAY:C228(a_id_asignatura;$line)
		DELETE FROM ARRAY:C228(a_id_tipoexamen;$line)
		DELETE FROM ARRAY:C228(a_id_lenguaMaterna;$line)
		
		For ($i;$line;Size of array:C274(a_LB_AADIAP_orden))
			a_LB_AADIAP_orden{$i}:=$i
			$l_rn:=Find in field:C653([DIAP_AlumnosAsignaturas:225]Auto_UUID:1;a_inscripcion_UUID{$i})
			If ($l_rn>=0)
				GOTO RECORD:C242([DIAP_AlumnosAsignaturas:225];$l_rn)
				[DIAP_AlumnosAsignaturas:225]Orden:4:=$i
				SAVE RECORD:C53([DIAP_AlumnosAsignaturas:225])
			End if 
		End for 
		
	End if 
	
	KRL_UnloadReadOnly (->[DIAP_AlumnosAsignaturas:225])
	
End if 

OBJECT SET ENABLED:C1123(*;"bDesinscribeAlu";(Size of array:C274(a_LB_AADIAP_asignatura)>1))