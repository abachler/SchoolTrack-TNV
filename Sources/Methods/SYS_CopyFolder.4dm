//%attributes = {}
  //Metodo: SYS_CopyFolder
  //Por abachler
  //Creada el 04/12/2006, 19:05:08
  // ----------------------------------------------------
  // Descripción
  // 
  //
  // ----------------------------------------------------
  // Parámetros
  // $1: source folder path
  // $2: destination folder path
  // ----------------------------------------------------

  //DECLARACIONES & INICIALIZACIONES
C_TEXT:C284($1;$sourcePath;$destinationPath)
ARRAY TEXT:C222($aDocs;0)
ARRAY TEXT:C222($aFolders;0)
If (Count parameters:C259=2)
	$sourcePath:=$1
	$destinationPath:=$2
End if 

  //CUERPO
If (Test path name:C476($sourcePath)=Is a folder:K24:2)  //es una carpeta
	If (Test path name:C476($destinationPath)=Is a folder:K24:2)
		SYS_DeleteFolder ($destinationPath)
	End if 
	SYS_CreateFolder ($destinationPath)
	
	FOLDER LIST:C473($sourcePath;$aFolders)
	For ($i;Size of array:C274($aFolders);1;-1)
		$sourceSubPath:=$sourcePath+Folder separator:K24:12+$aFolders{$i}
		$destinationSubPath:=$destinationPath+Folder separator:K24:12+$aFolders{$i}
		If (Test path name:C476($sourceSubPath)=Is a folder:K24:2)
			SYS_CopyFolder ($sourceSubPath;$destinationSubPath)
		End if 
	End for 
	
	DOCUMENT LIST:C474($sourcePath;$aDocs;Ignore invisible:K24:16)
	For ($i;Size of array:C274($aDocs);1;-1)
		$sourceSubPath:=$sourcePath+Folder separator:K24:12+$aDocs{$i}
		$destinationSubPath:=$destinationPath+Folder separator:K24:12+$aDocs{$i}
		If (Test path name:C476($sourceSubPath)=Is a document:K24:1)
			COPY DOCUMENT:C541($sourceSubPath;$destinationSubPath)
		End if 
	End for 
Else 
	  //ALERT($path+"\ris not a folder")
End if 


  //LIMPIEZA
