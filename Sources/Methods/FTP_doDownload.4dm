//%attributes = {}
  //FTP_doDownload

  // Project Method: Do_Download
  // Description: Download the select file of folder

$line:=AL_GetLine (xALP_FTPContents)
$selectedObjectName:=Replace string:C233(vtFTP_CurrentDirectory+"/"+Substring:C12(atFTP_ObjectNames{$line};Position:C15(" ";atFTP_ObjectNames{$line})+1);"//";"/")
Case of 
	: (aiFTP_ObjectKind{atFTP_ObjectNames}=0)
		
		  // *** Download the target file ***
		FTP_GetFile ($selectedObjectName)
		
	: (aiFTP_ObjectKind{atFTP_ObjectNames}=1)
		
		  // *** Select the target directory ***
		C_TEXT:C284($localPath)
		$localPath:=Select folder:C670("Seleccione la carpeta de destino:")
		
		If (OK=1)
			
			ARRAY TEXT:C222(atDirectoryList;1)
			ARRAY TEXT:C222(atFileList;0)
			ARRAY TEXT:C222(atTargetFilePaths;0)
			
			  // *** Path to the target directory ***
			atDirectoryList{1}:=vtFTP_CurrentDirectory+"/"+vItem
			
			  // *** Get path to all files and directories ***
			FTP_GetHostPaths (vlFTP_ConectionID;->atDirectoryList;->atFileList)
			SORT ARRAY:C229(atFileList;>)
			ARRAY TEXT:C222(atTargetFilePaths;Size of array:C274(atFileList))
			For ($I;1;Size of array:C274(atFileList))
				atTargetFilePaths{$i}:=Replace string:C233(atDirectoryList{$i};vtFTP_CurrentDirectory;$localPath)+Folder separator:K24:12+ST_GetWord (atFileList{$i};ST_CountWords (atFileList{$i};0;"/");"/")
				atTargetFilePaths{$i}:=Replace string:C233(Replace string:C233(atTargetFilePaths{$i};"/";Folder separator:K24:12);Folder separator:K24:12+Folder separator:K24:12;Folder separator:K24:12)
			End for 
			
			  // *** Create all acquired directories on the disk ***
			C_LONGINT:C283($deleteAt)
			For ($i;1;Size of array:C274(atDirectoryList))
				$folderPath:=$localPath+Replace string:C233(atDirectoryList{$i};vtFTP_CurrentDirectory;"")  //+ST_GetWord (atDirectoryList{$i};ST_CountWords (atDirectoryList{$i};0;"/");"/")+SYS_FolderDelimiter 
				$folderPath:=Replace string:C233(Replace string:C233($folderPath;"/";Folder separator:K24:12);Folder separator:K24:12+Folder separator:K24:12;Folder separator:K24:12)
				  //$folderPath:=$localPath+SYS_FolderDelimiter +AT_array2text (->atDirectoryList;SYS_FolderDelimiter )
				SYS_CreatePath ($folderPath)
			End for 
			
			  // *** Download all files and save them at an appropriate location ***
			FTP_DownloadFiles ($folderPath;->atFileList;->atTargetFilePaths)
			
			
			
			CD_Dlog (0;__ ("Descarga terminada."))
		End if 
End case 
