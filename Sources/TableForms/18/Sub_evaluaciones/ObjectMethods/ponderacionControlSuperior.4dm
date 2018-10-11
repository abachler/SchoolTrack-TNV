[xxSTR_Subasignaturas:83]PonderacionControlSuperior:15:=Abs:C99([xxSTR_Subasignaturas:83]PonderacionControlSuperior:15)

If ([xxSTR_Subasignaturas:83]ModoControles:5 ?? 1)
	[xxSTR_Subasignaturas:83]PonderacionControlInferior:8:=[xxSTR_Subasignaturas:83]PonderacionControlSuperior:15
End if 

For ($i;1;Size of array:C274(aSubEvalP1))
	ASsev_Average ($i)
End for 
COPY ARRAY:C226(aSubEvalID;aIdAlumnos_a_Recalcular)
SAVE RECORD:C53([xxSTR_Subasignaturas:83])
AL_UpdateArrays (xALP_SubEvals;-2)