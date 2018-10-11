C_LONGINT:C283($col;$line)
LISTBOX GET CELL POSITION:C971(LB_TipoEva;$col;$line)

If (($line>0) & ($line<=Size of array:C274(a_LB_IdTipoEva)))
	
	READ ONLY:C145([DIAP_AlumnosAsignaturas:225])
	QUERY:C277([DIAP_AlumnosAsignaturas:225];[DIAP_AlumnosAsignaturas:225]ID_TipoExamen:6=a_LB_IdTipoEva{$line})
	
	If (Records in selection:C76([DIAP_AlumnosAsignaturas:225])=0)
		DELETE FROM ARRAY:C228(a_LB_IdTipoEva;$line)
		DELETE FROM ARRAY:C228(a_LB_TipoEVA;$line)
	Else 
		CD_Dlog (0;"El tipo de examen "+a_LB_TipoEVA{$line}+", está asignada a registros de inscripción del DIAP, no puede ser eliminado.")
	End if 
	
End if 

OBJECT SET ENABLED:C1123(*;"bRemoveTipoEVa";(Size of array:C274(a_LB_IdTipoEva)>0))

