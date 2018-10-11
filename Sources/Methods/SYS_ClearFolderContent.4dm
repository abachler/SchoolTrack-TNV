//%attributes = {}
  // Método: SYS_ClearFolderContent
  //
  //
  // creado por Alberto Bachler Klein
  // el 11/07/18, 11:07:08
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_BOOLEAN:C305($0)
C_TEXT:C284($1)

C_LONGINT:C283($i;$l_contenido)
C_TEXT:C284($t_onErrCal;$t_path;$t_ruta)

ARRAY TEXT:C222($at_documents;0)
ARRAY TEXT:C222($at_folders;0)



If (False:C215)
	C_BOOLEAN:C305(SYS_ClearFolderContent ;$0)
	C_TEXT:C284(SYS_ClearFolderContent ;$1)
End if 

$t_path:=$1

If ($t_path#"")
	If ($t_path[[Length:C16($t_path)]]=Folder separator:K24:12)
		$t_path:=Substring:C12($t_path;1;Length:C16($t_path)-1)
	End if 
End if 


If (Test path name:C476($t_path)=Is a folder:K24:2)
	$t_onErrCal:=Method called on error:C704
	ON ERR CALL:C155("ERR_GenericOnError")
	DELETE FOLDER:C693($t_ruta;$l_contenido)
	
	
	If (error#0)
		DOCUMENT LIST:C474($t_path;$at_documents;Absolute path:K24:14)
		For ($i;1;Size of array:C274($at_documents))
			error:=0
			DELETE DOCUMENT:C159($at_documents{$i})
		End for 
		
		FOLDER LIST:C473($t_path;$at_folders)
		For ($i;1;Size of array:C274($at_folders))
			error:=0
			DELETE FOLDER:C693($t_path+Folder separator:K24:12+$at_folders{$i};Delete with contents:K24:24)
		End for 
	End if 
	
	FOLDER LIST:C473($t_path;$at_folders)
	DOCUMENT LIST:C474($t_path;$at_documents)
	$0:=Choose:C955((Size of array:C274($at_folders)+Size of array:C274($at_documents))>0;False:C215;True:C214)
	
	ON ERR CALL:C155($t_onErrCal)
End if 