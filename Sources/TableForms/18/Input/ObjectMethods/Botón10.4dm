If (<>vb_BloquearModifSituacionFinal)
	
	
Else 
	AL_UpdateArrays (xALP_StdList;0)
	ALP_RemoveAllArrays (xALP_ASNotas)
	  //AL_UpdateArrays (xALP_Sesions;0)
	
	$l_indexEstiloEvaluacion:=aEvStyleName
	$recNum:=Record number:C243([Asignaturas:18])
	SAVE RECORD:C53([Asignaturas:18])
	
	C_BLOB:C604($x_RecNumsArray)
	ARRAY LONGINT:C221($al_RecNumsAsignaturas;0)
	APPEND TO ARRAY:C911($al_RecNumsAsignaturas;$recNum)
	BLOB_Variables2Blob (->$x_RecNumsArray;0;->$al_RecNumsAsignaturas)
	EV2dbu_Recalculos ($x_RecNumsArray)
	
	RELATE ONE:C42([Asignaturas:18]profesor_numero:4)
	AL_UpdateArrays (xALP_StdList;-2)
	
	READ WRITE:C146([Asignaturas:18])
	KRL_GotoRecord (->[Asignaturas:18];$recNum;True:C214)
	aEvStyleName:=$l_indexEstiloEvaluacion
	
	LOG_RegisterEvt ("Modificación en modalidades de cálculo de promedios de fin de período y/o nota fi"+"nal "+[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5;Table:C252(->[Asignaturas:18]);[Asignaturas:18]Numero:1)
End if 