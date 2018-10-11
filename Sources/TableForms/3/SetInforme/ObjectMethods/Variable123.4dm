rAvgMinAsignaturaPercent:=NTA_StringValue2Percent (Self:C308->)
If (rAvgMinAsignaturaPercent>100)
	BEEP:C151
	rAvgMinAsignaturaPercent:=100
End if 
Self:C308->:=NTA_PercentValue2StringValue (rAvgMinAsignaturaPercent;iEvaluationMode)