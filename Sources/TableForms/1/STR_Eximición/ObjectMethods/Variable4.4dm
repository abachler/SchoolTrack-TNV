
If (Size of array:C274(<>aExmNo)>0)
	AL_SetSort (xALP_Exim;7)
	START TRANSACTION:C239
	READ WRITE:C146([Alumnos_ComplementoEvaluacion:209])
	CREATE SELECTION FROM ARRAY:C640([Alumnos_ComplementoEvaluacion:209];aRecNums)
	ARRAY TO SELECTION:C261(<>aExmNo;[Alumnos_ComplementoEvaluacion:209]Eximicion_NoRegistro:8;<>aExmDate;[Alumnos_ComplementoEvaluacion:209]Eximicion_Fecha:7;<>aExmObs;[Alumnos_ComplementoEvaluacion:209]Eximicion_Obs:9)
	UNLOAD RECORD:C212([Alumnos_ComplementoEvaluacion:209])
	READ ONLY:C145([Alumnos_ComplementoEvaluacion:209])
	
	If (Records in set:C195("lockedSet")=0)
		VALIDATE TRANSACTION:C240
		ACCEPT:C269
	Else 
		USE SET:C118("lockedset")
		CANCEL TRANSACTION:C241
		CD_Dlog (0;__ ("Algunos registros están siendo utilizados por otro usuario.\rNo es posible efectuar esta operación ahora.\rInténtelo nuevament en un momento."))
	End if 
Else 
	ACCEPT:C269
End if 
UNLOAD RECORD:C212([Alumnos_Calificaciones:208])
READ ONLY:C145([Alumnos_Calificaciones:208])
UNLOAD RECORD:C212([Alumnos_ComplementoEvaluacion:209])
READ ONLY:C145([Alumnos_ComplementoEvaluacion:209])