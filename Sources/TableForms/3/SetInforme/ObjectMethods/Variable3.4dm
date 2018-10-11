rAvgInfPercent:=NTA_StringValue2Percent (Self:C308->)
If (rAvgInfPercent>100)
	BEEP:C151
	rAvgInfPercent:=100
End if 
Self:C308->:=NTA_PercentValue2StringValue (rAvgInfPercent;iEvaluationMode)