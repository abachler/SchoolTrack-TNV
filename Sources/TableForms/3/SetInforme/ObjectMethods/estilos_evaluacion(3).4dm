If (Self:C308->>0)
	vlEVS_CurrentEvStyleID:=0
	  // MOD Ticket N° 209201 Patricio Aliaga 20180705
	  //vi_SelectedStyle:=Self->
	vi_SelectedStyle:=aEvStyleID{Self:C308->}
	EVS_ReadStyleData (aEvStyleID{Self:C308->})
	
	sAvgSup:=NTA_PercentValue2StringValue (rAvgSupPercent;iEvaluationMode)
	sAvgInf:=NTA_PercentValue2StringValue (rAvgInfPercent;iEvaluationMode)
	sAvgMin:=NTA_PercentValue2StringValue (rAvgMinPercent;iEvaluationMode)
	sAvgMinAsignatura:=NTA_PercentValue2StringValue (rAvgMinAsignaturaPercent;iEvaluationMode)
	
	For ($i;1;8)
		atCU_DispersionFrom{$i}:=NTA_PercentValue2StringValue (arCU_DispersionFrom{$i};iEvaluationMode)
		atCU_DispersionTo{$i}:=NTA_PercentValue2StringValue (arCU_Dispersionto{$i};iEvaluationMode)
	End for 
	
	AL_UpdateArrays (xALP_Dispersion;-2)
End if 


