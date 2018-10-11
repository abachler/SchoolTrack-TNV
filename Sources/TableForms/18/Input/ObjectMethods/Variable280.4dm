  //forzar la salida de las celdas de las areas para evitar bug de area list
Case of 
	: (vlSTR_PaginaFormAsignaturas=3)  //evaluaciones
		AL_ExitCell (xALP_ASNotas)
		
	: (vlSTR_PaginaFormAsignaturas=4)  //observaciones
		
		  // MOD Ticket N° 215084 Patricio Aliaga 20180924
		  //: (vlSTR_PaginaFormAsignaturas=10)  //aprendizajes
		  //AL_ExitCell (xALP_Aprendizajes)
		  //: (vlSTR_PaginaFormAsignaturas=10)  //aprendizajes
		  //AL_ExitCell (xALP_Aprendizajes)
	: (vlSTR_PaginaFormAsignaturas=10)  //aprendizajes
		C_POINTER:C301($lastObject)
		C_TEXT:C284($varName)
		C_LONGINT:C283($tableNum;$fieldnum)
		$lastObject:=Focus object:C278
		RESOLVE POINTER:C394(Focus object:C278;$varName;$tableNum;$fieldnum)
		If (($varName="xALP_@") | ($varName="xAL_@"))
			AL_ExitCell ($lastObject->)
		End if 
		
	: (vlSTR_PaginaFormAsignaturas=11)  //evaluaciones
		AL_ExitCell (xALP_Evaluaciones)
		
End case 


GET LIST ITEM:C378(Self:C308->;Selected list items:C379(hlTab_STR_asignaturas);$itemRef;$itemText)
AS_OnRecordLoad ($itemRef)
