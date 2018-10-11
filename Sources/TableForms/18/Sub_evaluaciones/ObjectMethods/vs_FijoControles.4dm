EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
Case of 
	: (vi_ModoControlesSeleccionado=7)  // si control inferior a promedio
		[xxSTR_Subasignaturas:83]ValorControlSiInferior:9:=NTA_StringValue2Percent (Self:C308->)
		Self:C308->:=NTA_PercentValue2StringValue ([xxSTR_Subasignaturas:83]ValorControlSiInferior:9)
	: (vi_ModoControlesSeleccionado=12)  // si control superior a promedio
		[xxSTR_Subasignaturas:83]ValorControlSiSuperior:10:=NTA_StringValue2Percent (Self:C308->)
		Self:C308->:=NTA_PercentValue2StringValue ([xxSTR_Subasignaturas:83]ValorControlSiSuperior:10)
End case 
SAVE RECORD:C53([xxSTR_Subasignaturas:83])

If (Self:C308->="")
	CD_Dlog (0;__ ("El valor ingresado no es admisible."))
	BEEP:C151
End if 


For ($i;1;Size of array:C274(aSubEvalP1))
	ASsev_Average ($i)
End for 
COPY ARRAY:C226(aSubEvalID;aIdAlumnos_a_Recalcular)
