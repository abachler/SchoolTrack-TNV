Self:C308->:=Abs:C99(Self:C308->)

For ($i;1;Size of array:C274(aSubEvalP1))
	ASsev_Average ($i)
End for 
SAVE RECORD:C53([xxSTR_Subasignaturas:83])
COPY ARRAY:C226(aSubEvalID;aIdAlumnos_a_Recalcular)
AL_UpdateArrays (xALP_SubEvals;-2)