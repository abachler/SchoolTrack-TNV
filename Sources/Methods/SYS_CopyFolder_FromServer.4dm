//%attributes = {}
  // MÉTODO: SYS_CopyFolder_FromServer
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 07/06/11, 17:20:53
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // SYS_CopyServerFolder2Client()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES
C_TEXT:C284($1;$t_serverFolderPath;$2;$t_clientFolderPath)
C_BOOLEAN:C305($b_dontShowMsg)
C_LONGINT:C283($hl_DirectoriesList)
$t_serverFolderPath:=$1
$t_clientFolderPath:=$2
$b_replaceFolder:=False:C215
$b_showMsg:=True:C214
ARRAY TEXT:C222($at_Docs;0)
ARRAY TEXT:C222($at_Folders;0)

Case of 
	: (Count parameters:C259=3)
		$b_replaceFolder:=$3
		
	: (Count parameters:C259=4)
		$b_replaceFolder:=$3
		$b_showMsg:=$4
End case 


  //CUERPO
error:=0
If ($b_showMsg)
	$l_processID:=IT_UThermometer (1;0;"Copiando carpeta desde el servidor...")
End if 
If ((Test path name:C476($t_serverFolderPath)=Is a folder:K24:2) | ((($t_serverFolderPath="@.app") | ($t_serverFolderPath="@.bundle") | ($t_serverFolderPath="@.dbase")) & (SYS_IsMacintosh )))  //es una carpeta
	If ((($t_serverFolderPath="@.app") | ($t_serverFolderPath="@.bundle") | ($t_serverFolderPath="@.dBase")) & (SYS_IsMacintosh ))
		$b_replaceFolder:=True:C214
	End if 
	If ($b_replaceFolder)
		$t_serverFolderPath:=Replace string:C233($t_serverFolderPath;":";Folder separator:K24:12)
		$t_serverFolderPath:=Replace string:C233($t_serverFolderPath;"\\";Folder separator:K24:12)
		  //$t_clientFolderPath:=$t_clientFolderPath+sys_folderdelimiter+SYS_Path2FileName ($t_serverFolderPath)
		SYS_DeleteFolder ($t_clientFolderPath)
		SYS_CreateFolder ($t_clientFolderPath)
	Else 
		$t_serverFolderPath:=Replace string:C233($t_serverFolderPath;":";Folder separator:K24:12)
		$t_serverFolderPath:=Replace string:C233($t_serverFolderPath;"\\";Folder separator:K24:12)
		  //$t_clientFolderPath:=$t_clientFolderPath+sys_folderdelimiter+SYS_Path2FileName ($t_serverFolderPath)
		SYS_CreateFolder ($t_clientFolderPath)
	End if 
	
	
	$blob:=SYS_GetServerFolderHList ($t_serverFolderPath)
	$hl_DirectoriesList:=BLOB to list:C557($blob)
	For ($i;Count list items:C380($hl_DirectoriesList);1;-1)
		GET LIST ITEM:C378($hl_DirectoriesList;$i;$itemRef;$itemName)
		GET LIST ITEM PARAMETER:C985($hl_DirectoriesList;$itemRef;"Path";$t_sourceSubPath)
		  //$t_sourceSubPath:=$t_serverFolderPath+sys_folderdelimiter+$at_Folders{$i}
		$t_destinationSubPath:=$t_clientFolderPath+Folder separator:K24:12+$itemName
		If (SYS_TestPathName ($t_sourceSubPath;Server)=Is a folder:K24:2)
			SYS_CopyFolder_FromServer ($t_sourceSubPath;$t_destinationSubPath;False:C215;False:C215)
		End if 
	End for 
	
	$blob:=SYS_GetServerDocumentList ($t_serverFolderPath)
	BLOB_Blob2Vars (->$blob;0;->$at_Docs)
	For ($i;Size of array:C274($at_Docs);1;-1)
		$t_sourceSubPath:=$t_serverFolderPath+Folder separator:K24:12+$at_Docs{$i}
		$t_destinationSubPath:=$t_clientFolderPath+Folder separator:K24:12+$at_Docs{$i}
		$l_docType:=SYS_TestPathName ($t_sourceSubPath;Server)
		
		Case of 
			: ((($t_sourceSubPath="@.app") | ($t_sourceSubPath="@.bundle") | ($t_sourceSubPath="@.dbase")) & (SYS_IsMacintosh ))
				SYS_CopyFolder_FromServer ($t_sourceSubPath;$t_destinationSubPath;False:C215;False:C215)
				If (error#0)
					$i:=Size of array:C274($at_Docs)
					CD_Dlog (0;__ ("Se produjo un error durante la copia. La carpeta no pudo se copiada íntegramente"))
				End if 
				
			: ($l_docType=Is a document:K24:1)
				SYS_CopyFileFromServer ($t_sourceSubPath;$t_destinationSubPath;False:C215)
				If (error#0)
					$i:=Size of array:C274($at_Docs)
					CD_Dlog (0;__ ("Se produjo un error durante la copia. La carpeta no pudo se copiada íntegramente"))
				End if 
		End case 
	End for 
Else 
	
End if 
If ($b_showMsg)
	$l_processID:=IT_UThermometer (-2;$l_processID)
End if 
HL_ClearList ($hl_DirectoriesList)