//%attributes = {}
  //FTP_doDirectoryUpload

  // Project Method: Do_DirectoryUpload
  // Description: Upload a directory

C_TEXT:C284($folderPath)

  // Select a local directory to be uploaded ***
$folderPath:=Select folder:C670("Select a folder")

If (OK=1)
	C_BOOLEAN:C305($OK)
	$OK:=True:C214
	
	  // *** Get the path name of all volumns ***
	_O_ARRAY STRING:C218(255;$asVolumes;0)
	VOLUME LIST:C471($asVolumes)
	
	  // *** Make sure that the user is not uploading a volumn ***
	For ($i;1;Size of array:C274($asVolumes))
		If ($folderPath=$asVolumes{$i})
			CD_Dlog (0;__ ("¡¡¡Acción denegada!!! - intento de transferir un volumen completo: ")+$folderPath)
			$i:=Size of array:C274($asVolumes)+1
			$OK:=False:C215
		End if 
	End for 
	
	If ($OK)
		
		  // *** Perform directory upload ***    
		FTP_DirectoryUpload (vtFTP_CurrentDirectory;$folderPath)
		
		  // *** Refresh the current directory listing ***
		$success:=FTP_ChangeDirectory (vlFTP_ConectionID;vtFTP_CurrentDirectory)
		  //Reset_SelectedArrayElem(->atFTP_ObjectNames;->alFTP_ObjectSize;->aiFTP_ObjectKind;->adFTP_ObjectDate;->apICon)
		
		CD_Dlog (0;__ ("Transferencia de archivos terminada."))
	End if 
End if 