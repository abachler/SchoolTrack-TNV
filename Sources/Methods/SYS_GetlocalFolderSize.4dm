//%attributes = {}
  // MÉTODO: SYS_GetlocalFolderSize
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 09/06/11, 13:31:02
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // SYS_GetlocalFolderSize()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES
C_REAL:C285($r_Size;$r_SizeKB;$r_SizeMB;$r_SizeGB;$0)
C_TEXT:C284($t_folderPath;$1)

$r_Size:=0
$t_folderPath:=$1

Case of 
	: (Test path name:C476($t_folderPath)=Is a folder:K24:2)
		
		ARRAY TEXT:C222($at_Folders;0)
		ARRAY TEXT:C222($at_documents;0)
		
		  // CODIGO PRINCIPAL
		FOLDER LIST:C473($t_folderPath;$at_Folders)
		For ($i;1;Size of array:C274($at_Folders))
			$t_path:=$t_folderPath+Folder separator:K24:12+$at_Folders{$i}
			$r_Size:=$r_Size+SYS_GetServerFolderSize ($t_Path)
		End for 
		
		DOCUMENT LIST:C474($t_folderPath;$at_documents)
		For ($i;1;Size of array:C274($at_documents))
			$t_path:=$t_folderPath+Folder separator:K24:12+$at_documents{$i}
			$r_Size:=$r_Size+Get document size:C479($t_path)
		End for 
		
		$0:=$r_Size
	: (Test path name:C476($t_folderPath)=Is a document:K24:1)
		$0:=Get document size:C479($t_folderPath)
		
		
End case 
