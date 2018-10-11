//%attributes = {}
  // SYS_EliminaArchivos_DS_Store()
  // Por: Alberto Bachler: 20/08/13, 08:35:05
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)

C_LONGINT:C283($i)
C_TEXT:C284($t_rutaDirectorio;$t_rutaSubdirectorio)

ARRAY TEXT:C222($aDocs;0)
ARRAY TEXT:C222($at_rutaSubDirectorios;0)
If (False:C215)
	C_TEXT:C284(SYS_EliminaArchivos_DS_Store ;$1)
End if 

$t_rutaDirectorio:=$1
If ($t_rutaDirectorio#"")
	
	If ($t_rutaDirectorio[[Length:C16($t_rutaDirectorio)]]=Folder separator:K24:12)
		$t_rutaDirectorio:=Substring:C12($t_rutaDirectorio;1;Length:C16($t_rutaDirectorio)-1)
	End if 
	
	If (Test path name:C476($t_rutaDirectorio)=Is a folder:K24:2)
		FOLDER LIST:C473($t_rutaDirectorio;$at_rutaSubDirectorios)
		For ($i;Size of array:C274($at_rutaSubDirectorios);1;-1)
			$t_rutaSubdirectorio:=$t_rutaDirectorio+Folder separator:K24:12+$at_rutaSubDirectorios{$i}
			If (Test path name:C476($t_rutaSubdirectorio)=Is a folder:K24:2)
				SYS_EliminaArchivos_DS_Store ($t_rutaSubdirectorio)
			End if 
		End for 
		
		DOCUMENT LIST:C474($t_rutaDirectorio;$aDocs)
		If (Find in array:C230($aDocs;".DS_Store")>0)
			For ($i;Size of array:C274($aDocs);1;-1)
				If ($aDocs{$i}=".DS_Store")
					DELETE DOCUMENT:C159($t_rutaDirectorio+Folder separator:K24:12+$aDocs{$i})
				End if 
			End for 
		End if 
	Else 
	End if 
End if 

