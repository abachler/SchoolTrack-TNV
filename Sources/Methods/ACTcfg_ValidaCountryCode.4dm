//%attributes = {}
  //ACTcfg_ValidaCountryCode
  //20110408 RCH hay problemas de que el codigo esta vacio en algunos casos..

If (<>gCountryCode="")
	READ ONLY:C145([Colegio:31])
	ALL RECORDS:C47([Colegio:31])
	FIRST RECORD:C50([Colegio:31])
	<>gCountryCode:=[Colegio:31]Codigo_Pais:31
	If (<>gCountryCode="")
		READ ONLY:C145([xShell_ApplicationData:45])
		ALL RECORDS:C47([xShell_ApplicationData:45])
		FIRST RECORD:C50([xShell_ApplicationData:45])
		<>gCountryCode:=[xShell_ApplicationData:45]Código_Pais:26
		If (<>gCountryCode="")
			LOG_RegisterEvt ("ERROR - No hay código de país asignado a la base de datos.")
		End if 
	End if 
End if 