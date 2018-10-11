If (Num:C11([xxSTR_Subasignaturas:83]CalcularPromedios:18)#Self:C308->)
	[xxSTR_Subasignaturas:83]CalcularPromedios:18:=(Self:C308->=1)
	SAVE RECORD:C53([xxSTR_Subasignaturas:83])
	For ($i;1;Size of array:C274(aSubEvalId))
		ASsev_Average ($i)
	End for 
	AL_UpdateArrays (xALP_SubEvals;-2)
End if 