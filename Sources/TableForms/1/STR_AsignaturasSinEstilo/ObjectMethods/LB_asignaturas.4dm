Case of 
	: (Form event:C388=On Drop:K2:12)
		ARRAY LONGINT:C221($al_filasAsignatura;0)
		ARRAY LONGINT:C221($al_filasEstilos;0)
		LB_GetSelectedRows (OBJECT Get pointer:C1124(Object named:K67:5;"LB_asignaturas");->$al_filasAsignatura)
		LB_GetSelectedRows (OBJECT Get pointer:C1124(Object named:K67:5;"LB_estilos");->$al_filasEstilos)
		If (Size of array:C274($al_filasAsignatura)>0)
			C_LONGINT:C283($i)
			For ($i;1;Size of array:C274($al_filasAsignatura))
				at_nomEstilo{$al_filasAsignatura{$i}}:=at_Estilo{$al_filasEstilos{1}}
				al_numEstilo{$al_filasAsignatura{$i}}:=al_numEstiloEvaluacion{$al_filasEstilos{1}}
			End for 
		Else 
			CD_Dlog (0;"Se debe seleccionar asignatura(s) para asignar Estilo de evaluación.")
		End if 
End case 