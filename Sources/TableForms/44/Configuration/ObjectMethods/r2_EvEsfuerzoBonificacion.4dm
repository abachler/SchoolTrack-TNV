If (Self:C308->=1)
	If ((iEvaluationMode<=0) | (iEvaluationMode>3))
		Self:C308->:=0
		r1_EvEsfuerzoIndicadores:=1
		$r:=CD_Dlog (0;__ ("Esta modalidad sólo puede ser utilizada con escalas numéricas."))
	Else 
		EVS_SetModified 
	End if 
End if 
