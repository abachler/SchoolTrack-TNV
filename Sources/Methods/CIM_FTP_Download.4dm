//%attributes = {}
  // MÉTODO: CIM_FTP_Upload
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 24/06/11, 17:31:44
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // CIM_FTP_Upload()
  // ----------------------------------------------------
C_BOOLEAN:C305($b_expanded)
C_LONGINT:C283($l_index;$l_draggedElement;$l_dropPosition;$l_error;$l_itemRef;$l_list)
C_POINTER:C301($y_Nil)
C_TEXT:C284($t_destinationPath;$t_folderPath;$t_sourcePath;$t_volumeName)


  // DECLARACIONES E INICIALIZACIONES

  // CODIGO PRINCIPAL
$l_draggedElement:=$1
GET LIST ITEM:C378(hlCIM_FTPDirectories;Selected list items:C379(hlCIM_FTPDirectories);$l_itemRef;$t_volumeName;$l_list;$b_expanded)
GET LIST ITEM PARAMETER:C985(hlCIM_FTPDirectories;$l_itemRef;"FTPpath";$t_sourcePath)
If ($t_sourcePath="")
	$t_sourcePath:="/"
End if 
$t_sourcePath:=Replace string:C233($t_sourcePath;vtFTP_RootDirectory;"/")
$t_sourcePath:=$t_sourcePath+"/"+atFTP_ObjectNames{$l_draggedElement}

GET LIST ITEM:C378(hlCIM_LocalBrowser_FTP;Selected list items:C379(hlCIM_LocalBrowser_FTP);$l_itemRef;$t_volumeName;$l_list;$b_expanded)
GET LIST ITEM PARAMETER:C985(hlCIM_LocalBrowser_FTP;$l_itemRef;"Path";$t_destinationPath)
$l_dropPosition:=Drop position:C608

$y_Ruta:=OBJECT Get pointer:C1124(Object named:K67:5;"localRuta")
If ($l_dropPosition>=1)
	$t_destinationPath:=$y_Ruta->{$l_dropPosition}
Else 
	$t_destinationPath:=$t_destinationPath
End if 

If (aiFTP_ObjectKind{$l_draggedElement}=1)
	ARRAY TEXT:C222(atDirectoryList;1)
	ARRAY TEXT:C222(atFileList;0)
	ARRAY TEXT:C222(atTargetFilePaths;0)
	
	  // *** Path to the target directory ***
	atDirectoryList{1}:=$t_sourcePath
	
	  // *** Get path to all files and directories ***
	FTP_GetHostPaths (vlFTP_ConectionID;->atDirectoryList;->atFileList)
	SORT ARRAY:C229(atFileList;>)
	ARRAY TEXT:C222(atTargetFilePaths;Size of array:C274(atFileList))
	For ($l_index;1;Size of array:C274(atFileList))
		atTargetFilePaths{$l_index}:=$t_destinationPath+$t_sourcePath+Folder separator:K24:12+ST_GetWord (atFileList{$l_index};ST_CountWords (atFileList{$l_index};0;"/");"/")
		atTargetFilePaths{$l_index}:=Replace string:C233(atTargetFilePaths{$l_index};"/";Folder separator:K24:12)
		atTargetFilePaths{$l_index}:=Replace string:C233(atTargetFilePaths{$l_index};Folder separator:K24:12+Folder separator:K24:12;Folder separator:K24:12)
	End for 
	
	  // *** Create all acquired directories on the disk ***
	For ($l_index;1;Size of array:C274(atDirectoryList))
		$t_folderPath:=$t_destinationPath+Folder separator:K24:12+Replace string:C233(atDirectoryList{$l_index};"//";"")
		$t_folderPath:=Replace string:C233($t_folderPath;"/";Folder separator:K24:12)
		$t_folderPath:=Replace string:C233($t_folderPath;Folder separator:K24:12+Folder separator:K24:12;Folder separator:K24:12)
		SYS_CreatePath ($t_folderPath)
	End for 
	
	  // *** Download all files and save them at an appropriate location ***
	FTP_DownloadFiles ($t_folderPath;->atFileList;->atTargetFilePaths)
	XS_CIM_ObjetMethods ("LocalDirectoriesBrowser";$y_Nil;"updateDirectory")
Else 
	$t_destinationPath:=$t_destinationPath+Folder separator:K24:12+atFTP_ObjectNames{$l_draggedElement}
	$l_error:=FTP_VerifyConexionStatus (vlFTP_ConectionID;vtFTP_Url;vtWS_ftpLoginName;vtWS_ftppassword;->vlFTP_ConectionID)
	If ($l_error=0)
		FTP_GetFile ($t_sourcePath;$t_destinationPath)
		XS_CIM_ObjetMethods ("LocalDirectoriesBrowser";$y_Nil;"updateDirectory")
	End if 
End if 