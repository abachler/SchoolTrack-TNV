//%attributes = {}
  //FTP_doRemove

  // Project Method: Do_Remove
  // Description: Remove the selected file or folder from the FTP Server

$line:=AL_GetLine (xALP_FTPContents)
$selectedObjectName:=Replace string:C233(vtFTP_CurrentDirectory+"/"+Substring:C12(atFTP_ObjectNames{$line};Position:C15(" ";atFTP_ObjectNames{$line})+1);"//";"/")
vItem:=Substring:C12(atFTP_ObjectNames{$line};Position:C15(" ";atFTP_ObjectNames{$line})+1)

Case of 
	: (aiFTP_ObjectKind{atFTP_ObjectNames}=0)
		
		C_LONGINT:C283($proc)
		C_TEXT:C284($targetItem)
		  //$targetItem:=FTP_GetPath (vtFTP_CurrentDirectory)
		$uThermPid:=IT_UThermometer (1;0;__ ("Eliminando ")+$selectedObjectName)
		
		FTP_Remove (vlFTP_ConectionID;$selectedObjectName;vtFTP_CurrentDirectory;1)
		  //Reset_SelectedArrayElem(->atFTP_ObjectNames;->alFTP_ObjectSize;->aiFTP_ObjectKind  `;->adFTP_ObjectDate;->apICon)
		
		$ignore:=IT_UThermometer (-2;$uThermPid)
		
	: (aiFTP_ObjectKind{atFTP_ObjectNames}=1)
		
		If (alFTP_ObjectSize{atFTP_ObjectNames}>0)
			OK:=CD_Dlog (0;__ ("Este directorio no está vacío. \r¿Desea eliminarlo de todas maneras?");__ ("");__ ("Si");__ ("No"))
			
			If (OK=1)
				C_LONGINT:C283($proc)
				$uThermPid:=IT_UThermometer (1;0;__ ("Preparando eliminación del directorio ")+vItem)
				
				FTP_DeleteDir (vlFTP_ConectionID;vtFTP_CurrentDirectory;vItem;$uThermPid)
				
				$ignore:=IT_UThermometer (-2;$uThermPid)
			End if 
			
		Else 
			
			C_LONGINT:C283($proc)
			C_TEXT:C284($targetItem)
			$targetItem:=FTP_GetPath (vtFTP_CurrentDirectory)
			$uThermPid:=IT_UThermometer (1;0;__ ("Eliminando ")+$targetItem)
			
			FTP_Remove (vlFTP_ConectionID;$targetItem;vtFTP_CurrentDirectory;0)
			
			$ignore:=IT_UThermometer (-2;$uThermPid)
			
		End if 
		
End case 

