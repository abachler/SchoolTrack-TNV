//%attributes = {}
  //IN_LoadDefaultCurriculum


If (Application type:C494=4D Remote mode:K5:5)
	$pId:=Execute on server:C373(Current method name:C684;Pila_256K;Current method name:C684)
Else 
	READ WRITE:C146([xShell_Prefs:46])
	QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]Reference:1="Plan@";*)
	QUERY:C277([xShell_Prefs:46]; & [xShell_Prefs:46]User:9=-1)
	DELETE SELECTION:C66([xShell_Prefs:46])
	
	$file:=Get 4D folder:C485(Database folder:K5:14)+"Config"+Folder separator:K24:12+<>vtXS_CountryCode+Folder separator:K24:12+"Programas_"+<>vtXS_CountryCode+".txt"
	SET CHANNEL:C77(10;$file)
	If (ok=1)
		$Process:=IT_UThermometer (1;0;__ ("Cargando planes de estudio por defecto…"))
		RECEIVE VARIABLE:C81(nbRecords)
		For ($k;1;nbrecords)
			RECEIVE RECORD:C79([xShell_Prefs:46])
			[xShell_Prefs:46]Auto_UUID:11:=Generate UUID:C1066  //20140123 RCH
			SAVE RECORD:C53([xShell_Prefs:46])
			$ref:=[xShell_Prefs:46]Reference:1
			PUSH RECORD:C176([xShell_Prefs:46])
			QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]Reference:1;=;$ref;*)
			QUERY:C277([xShell_Prefs:46]; & ;[xShell_Prefs:46]User:9;=;0)
			If (Records in selection:C76([xShell_Prefs:46])=0)
				POP RECORD:C177([xShell_Prefs:46])
				DUPLICATE RECORD:C225([xShell_Prefs:46])
				[xShell_Prefs:46]User:9:=0
				[xShell_Prefs:46]Auto_UUID:11:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
				SAVE RECORD:C53([xShell_Prefs:46])
			End if 
		End for 
		SET CHANNEL:C77(11)
		READ ONLY:C145([xShell_Prefs:46])
		IT_UThermometer (-2;$Process)
	Else 
		$r:=CD_Dlog (1;__ ("El archivo que contiene los planes de estudio no pudo ser cargado."))
	End if 
End if 