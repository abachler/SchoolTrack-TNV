//%attributes = {}
  // ----------------------------------------------------
  // Usuario (SO): Daniel Ledezma
  // Fecha y hora: 16-08-18, 12:07:21
  // ----------------------------------------------------
  // Método: UD_v20180816_FixObsAsig_213584
  // Descripción
  // Limpieza de observaciones de asignaturas con "::" por defecto reportado en el ticket 213584
  // en stwa no ponía el : en los nombres de la categoría.

If (PREF_fGet (0;"UtilizarListasObservaciones";"0")="1")
	
	C_TEXT:C284($t_key)
	C_LONGINT:C283($l_idAlu;$l_idAsig;$l_periodo;$r;$l_idTermometro)
	C_BOOLEAN:C305($b_ok)
	
	ARRAY TEXT:C222($at_key;0)
	ARRAY LONGINT:C221($al_aluID;0)
	ARRAY LONGINT:C221($al_asigID;0)
	ARRAY INTEGER:C220($al_periodo;0)
	
	$l_idTermometro:=IT_Progress (1;0;0;"Revisando observaciones en asignaturas ...")
	
	READ ONLY:C145([Alumnos_ObservacionesEvaluacion:30])
	QUERY:C277([Alumnos_ObservacionesEvaluacion:30];[Alumnos_ObservacionesEvaluacion:30]ID_Alumno:1>0)
	
	SELECTION TO ARRAY:C260([Alumnos_ObservacionesEvaluacion:30]ID_Alumno:1;$al_aluID;*)
	SELECTION TO ARRAY:C260([Alumnos_ObservacionesEvaluacion:30]Periodo:3;$al_periodo;*)
	SELECTION TO ARRAY:C260([Alumnos_ObservacionesEvaluacion:30]ID_Asignatura:2;$al_asigID;*)
	SELECTION TO ARRAY:C260
	
	For ($r;1;Size of array:C274($al_aluID))
		
		$l_idTermometro:=IT_Progress (0;$l_idTermometro;$r/Size of array:C274($al_aluID))
		
		$l_idAlu:=$al_aluID{$r}
		$l_idAsig:=$al_asigID{$r}
		$l_periodo:=$al_periodo{$r}
		$t_key:=KRL_MakeStringAccesKey (->$l_idAlu;->$l_idAsig;->$l_periodo)
		If (Find in array:C230($at_key;$t_key)=-1)
			$b_ok:=AS_SaveObsxCatEnCompEva ($l_idAlu;$l_idAsig;$l_periodo;False:C215)
			If ($b_ok)
				APPEND TO ARRAY:C911($at_key;$t_key)
			End if 
		End if 
	End for 
	
	$l_idTermometro:=IT_Progress (-1;$l_idTermometro)
	
End if 
