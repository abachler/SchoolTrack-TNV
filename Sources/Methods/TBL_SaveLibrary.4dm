//%attributes = {}
  //TBL_SaveLibrary

If (False:C215)
	  // Procédure : dfn SaveLists
	  // Created by: Alberto Bächler
	  // Date creation: Junio de 23, 1994
	  // Date modifi: Junio de 23, 1994  
	  //____________________
	  // Comments:
	  //Save the list file
	  //Old name was ExportLists
End if 


If (Application type:C494=4D Remote mode:K5:5)
	$p:=Execute on server:C373("TBL_SaveLibrary";Pila_256K;"Guardando listas")
Else 
	
	C_TEXT:C284($file)
	_O_C_STRING:C293(15;fileHeader)
	C_LONGINT:C283(nbRecords)
	C_PICTURE:C286($pict;theBundle)
	Case of 
		: (SYS_IsMacintosh )
			$file:=SYS_CarpetaAplicacion (CLG_Estructura)+"Config"+Folder separator:K24:12+"Tablas.txt"
			$fileList:=SYS_CarpetaAplicacion (CLG_Estructura)+"Config"+Folder separator:K24:12+"TablasField.txt"
		: (SYS_IsWindows )
			$file:=SYS_CarpetaAplicacion (CLG_Estructura)+"Config"+Folder separator:K24:12+"Tablas.txt"
			$fileList:=SYS_CarpetaAplicacion (CLG_Estructura)+"Config"+Folder separator:K24:12+"TablasField.txt"
	End case 
	SET CHANNEL:C77(12;$file)
	If (ok=1)
		READ ONLY:C145([xShell_List:39])
		ALL RECORDS:C47([xShell_List:39])
		nbRecords:=Records in selection:C76([xShell_List:39])
		SEND VARIABLE:C80(nbRecords)
		FIRST RECORD:C50([xShell_List:39])
		While (Not:C34(End selection:C36([xShell_List:39])))
			sName:=[xShell_List:39]Listname:1
			SEND VARIABLE:C80(sName)
			SEND RECORD:C78([xShell_List:39])
			NEXT RECORD:C51([xShell_List:39])
		End while 
		SET CHANNEL:C77(11)
		
		  //Codigo para guardar las referencias
		SET CHANNEL:C77(12;$fileList)
		READ ONLY:C145([xShell_List_FieldRefs:236])
		ALL RECORDS:C47([xShell_List_FieldRefs:236])
		nbRecords:=Records in selection:C76([xShell_List_FieldRefs:236])
		SEND VARIABLE:C80(nbRecords)
		FIRST RECORD:C50([xShell_List_FieldRefs:236])
		While (Not:C34(End selection:C36([xShell_List_FieldRefs:236])))
			sNameField:=[xShell_List_FieldRefs:236]ListName:4
			SEND VARIABLE:C80(sNameField)
			SEND RECORD:C78([xShell_List_FieldRefs:236])
			NEXT RECORD:C51([xShell_List_FieldRefs:236])
		End while 
		SET CHANNEL:C77(11)
		  //fin codifo para guarda las referencias.
	End if 
End if 