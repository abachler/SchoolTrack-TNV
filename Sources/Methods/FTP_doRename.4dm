//%attributes = {}
  //FTP_doRename

  // Project Method: Do_Rename
  // Description: Rename the selected file or folder
C_TEXT:C284($newName)

$line:=AL_GetLine (xALP_FTPContents)
If (atFTP_ObjectNames#0)
	$selectedObjectName:=Replace string:C233(vtFTP_CurrentDirectory+"/"+Substring:C12(atFTP_ObjectNames{$line};Position:C15(" ";atFTP_ObjectNames{$line})+1);"//";"/")
	$newName:=CD_Request (__ ("Por favor ingrese el nuevo nombre para ")+vItem;__ ("Aceptar");__ ("Cancelar"))
	
	If (OK=1)
		$newName:=Replace string:C233($newName;"/";"")
		FTP_RenameItem (vlFTP_ConectionID;$selectedObjectName;$newName)
	End if 
End if 