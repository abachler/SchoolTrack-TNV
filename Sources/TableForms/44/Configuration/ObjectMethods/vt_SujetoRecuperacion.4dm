If (Self:C308->>"")
	Case of 
		: (iEvaluationMode=Notas)
			Self:C308->:=String:C10(Round:C94(Num:C11(Self:C308->);iGradesDec))
			$real:=NTA_StringValue2Percent (Self:C308->;0;iEvaluationMode)
			$valorNumerico:=EV2_Real_a_Nota ($real;0;iGradesDec)
			vr_MinimoRecuperacion:=$real
			vb_evStyleModified:=True:C214
			
			
		: (iEvaluationMode=Puntos)
			Self:C308->:=String:C10(Round:C94(Num:C11(Self:C308->);iPointsDec))
			$real:=NTA_StringValue2Percent (Self:C308->;0;iEvaluationMode)
			$valorNumerico:=EV2_Real_a_Puntos ($real;iPointsDec)
			vr_MinimoRecuperacion:=$real
			vb_evStyleModified:=True:C214
			
			
		: (iEvaluationMode=Porcentaje)
			Self:C308->:=String:C10(Round:C94(Num:C11(Self:C308->);1))
			$real:=NTA_StringValue2Percent (Self:C308->;0;iEvaluationMode)
			$valorNumerico:=Num:C11(NTA_PercentValue2StringValue ($real))
			vr_MinimoRecuperacion:=$real
			vb_evStyleModified:=True:C214
			
			
		: (iEvaluationMode=Simbolos)
			$real:=NTA_StringValue2Percent (Self:C308->;0;iEvaluationMode)
			vr_MinimoRecuperacion:=$real
			vb_evStyleModified:=True:C214
	End case 
	
	EVS_SetModified 
End if 