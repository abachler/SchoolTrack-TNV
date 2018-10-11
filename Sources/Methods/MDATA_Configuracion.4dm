//%attributes = {}
  //MDATA_Configuracion

$processID:=Process number:C372(Current method name:C684)
Case of 
	: ($processID=0)
		$processID:=New process:C317(Current method name:C684;Pila_256K;Current method name:C684)
		
	: ($processID>0)
		If (Process state:C330($processID)#0)
			RESUME PROCESS:C320($processID)
			SHOW PROCESS:C325($processID)
			BRING TO FRONT:C326($processID)
		Else 
			vl_LastMetaDataRecNum:=-1
			WDW_OpenFormWindow (->[xxSTR_MetadatosLocales:141];"Configuracion";-1;8;__ ("Metadatos por País"))
			FORM SET INPUT:C55([xxSTR_MetadatosLocales:141];"Configuracion")
			ADD RECORD:C56([xxSTR_MetadatosLocales:141];*)
			CLOSE WINDOW:C154
			MDATA_SaveDictionnary 
		End if 
End case 




