//%attributes = {}
  //IN_SaveDefaultCurriculum


If (Application type:C494=4D Remote mode:K5:5)
	$p:=Execute on server:C373("IN_SaveDefaultCurriculum";Pila_256K;"Guardando planes de estudio")
Else 
	C_TEXT:C284($file)
	_O_C_STRING:C293(15;fileHeader)
	C_LONGINT:C283(nbRecords)
	
	$file:=Get 4D folder:C485(Database folder:K5:14)+"Config"+Folder separator:K24:12+<>vtXS_CountryCode+Folder separator:K24:12+"Programas_"+<>vtXS_CountryCode+".txt"
	SET CHANNEL:C77(12;$file)
	If (ok=1)
		READ ONLY:C145([xShell_Prefs:46])
		QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]Reference:1="Plan@";*)
		QUERY:C277([xShell_Prefs:46]; & [xShell_Prefs:46]User:9=-1)
		nbRecords:=Records in selection:C76([xShell_Prefs:46])
		SEND VARIABLE:C80(nbRecords)
		FIRST RECORD:C50([xShell_Prefs:46])
		While (Not:C34(End selection:C36([xShell_Prefs:46])))
			SEND RECORD:C78([xShell_Prefs:46])
			NEXT RECORD:C51([xShell_Prefs:46])
		End while 
		SET CHANNEL:C77(11)
	End if 
End if 