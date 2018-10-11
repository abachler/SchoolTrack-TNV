//%attributes = {}
  //ACTxx_BorraArchivosBancarios

ACTinit_LoadPrefs 

For ($i;1;Size of array:C274(atACT_BankName))
	
	READ WRITE:C146([xShell_Prefs:46])
	QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]Reference:1=atACT_BankName{$i})
	DELETE SELECTION:C66([xShell_Prefs:46])
	UNLOAD RECORD:C212([xShell_Prefs:46])
	READ ONLY:C145([xShell_Prefs:46])
	
End for 