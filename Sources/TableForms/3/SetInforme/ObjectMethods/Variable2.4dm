rAvgMinPercent:=NTA_StringValue2Percent (Self:C308->)
If (rAvgMinPercent>100)
	BEEP:C151
	rAvgMinPercent:=100
End if 
Self:C308->:=NTA_PercentValue2StringValue (rAvgMinPercent;iEvaluationMode)