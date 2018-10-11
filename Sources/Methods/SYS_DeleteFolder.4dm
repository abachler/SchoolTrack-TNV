//%attributes = {}
  // Método: SYS_DeleteFolder
  // código original de: ABK
  // modificado por Alberto Bachler Klein, 11/07/18, 15:05:27
  // 
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––



C_TEXT:C284($0)
C_TEXT:C284($1)
C_LONGINT:C283($2)

C_LONGINT:C283($l_eliminarContenido)
C_TEXT:C284($t_error;$t_metodoOnError;$t_rutaCarpeta)
C_OBJECT:C1216($o_errorStack)

ARRAY TEXT:C222($at_carpetas;0)
ARRAY TEXT:C222($at_documentos;0)



If (False:C215)
	C_TEXT:C284(SYS_DeleteFolderOnServer ;$0)
	C_TEXT:C284(SYS_DeleteFolderOnServer ;$1)
	C_LONGINT:C283(SYS_DeleteFolderOnServer ;$2)
End if 

$t_rutaCarpeta:=$1


$l_eliminarContenido:=1
If (Count parameters:C259=2)
	$l_eliminarContenido:=$2
End if 

If ($t_rutaCarpeta#"")
	If ($t_rutaCarpeta[[Length:C16($t_rutaCarpeta)]]=Folder separator:K24:12)
		$t_rutaCarpeta:=Substring:C12($t_rutaCarpeta;1;Length:C16($t_rutaCarpeta)-1)
	End if 
End if 

If (Test path name:C476($t_rutaCarpeta)=Is a folder:K24:2)
	$t_metodoOnError:=Method called on error:C704
	ON ERR CALL:C155("ERR_GenericOnError")
	Case of 
		: (Test path name:C476($t_rutaCarpeta)#Is a folder:K24:2)
			
		: ($l_eliminarContenido=0)
			DOCUMENT LIST:C474($t_rutaCarpeta;$at_documentos)
			DOCUMENT LIST:C474($t_rutaCarpeta;$at_carpetas)
			If ((Size of array:C274($at_documentos)+Size of array:C274($at_carpetas))=0)
				DELETE FOLDER:C693($t_rutaCarpeta;Delete only if empty:K24:23)
			Else 
				$t_error:=__ ("La carpeta no está vacía. No puede ser eliminada.")
			End if 
			
		: ($l_eliminarContenido=1)
			DELETE FOLDER:C693($t_rutaCarpeta;Delete with contents:K24:24)
	End case 
	
	If (error#0)
		$t_error:=ERR_LogExecutionError (->$o_errorStack)
	End if 
	
	ON ERR CALL:C155($t_metodoOnError)
	
	$0:=$t_error
End if 