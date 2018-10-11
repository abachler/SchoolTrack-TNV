//%attributes = {}
  //IN_LoadComunas

If (Application type:C494=4D Remote mode:K5:5)
	$pId:=Execute on server:C373(Current method name:C684;Pila_256K;Current method name:C684)
Else 
	
	$file:=Get 4D folder:C485(Database folder:K5:14)+"Config"+Folder separator:K24:12+<>vtXS_CountryCode+Folder separator:K24:12+"Comunas_"+<>vtXS_CountryCode+".txt"
	SET CHANNEL:C77(10;$file)
	If (ok=1)
		$Process:=IT_UThermometer (1;0;__ ("Cargando la tabla de comunas…"))
		READ WRITE:C146([xxSTR_Comunas:94])
		QUERY:C277([xxSTR_Comunas:94];[xxSTR_Comunas:94]AppStandard:9=True:C214)
		DELETE SELECTION:C66([xxSTR_Comunas:94])
		RECEIVE VARIABLE:C81(nbRecords)
		For ($k;1;nbrecords)
			RECEIVE RECORD:C79([xxSTR_Comunas:94])
			[xxSTR_Comunas:94]Auto_UUID:12:=Generate UUID:C1066  //20140123 RCH
			SAVE RECORD:C53([xxSTR_Comunas:94])
		End for 
		SET CHANNEL:C77(11)
		READ ONLY:C145([xxSTR_Comunas:94])
		IT_UThermometer (-2;$Process)
		
		Case of 
			: (<>vtXS_CountryCode="cl")
				QUERY WITH ARRAY:C644([Alumnos:2]nivel_numero:29;<>al_NumeroNivelesOficiales)
				QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Codigo_Comuna:79="")
				If (Records in selection:C76([Alumnos:2])#0)
					AL_AsignaCodigoComuna 
				End if 
		End case 
	Else 
		$r:=CD_Dlog (1;__ ("El archivo que contiene la tabla de comunas no pudo ser cargado."))
	End if 
End if 