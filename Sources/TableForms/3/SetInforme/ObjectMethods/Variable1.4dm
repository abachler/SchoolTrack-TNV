rAvgSupPercent:=NTA_StringValue2Percent (Self:C308->)
If (rAvgSupPercent>100)
	BEEP:C151
	rAvgSupPercent:=100
End if 
Self:C308->:=NTA_PercentValue2StringValue (rAvgSupPercent;iEvaluationMode)