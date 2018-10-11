//%attributes = {}
  //FTP_doNewDirectory

  // Project Method: Do_NewDirectory
  // Description: Create a new directory

C_TEXT:C284($directoryName;vtdirectoryname)
$directoryName:=CD_Request (__ ("Por favor ingrese el nombre del nuevo directorio:");__ ("Aceptar");__ ("Cancelar"))
vtdirectoryname:=$directoryName
If (OK=1)
	$directoryName:=Replace string:C233($directoryName;"/";"")
	FTP_CreateDir (vlFTP_ConectionID;vtFTP_CurrentDirectory;$directoryName)
End if 
