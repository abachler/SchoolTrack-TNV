//%attributes = {}
  //SYS_GetFileList

  // Project Method: Get_Files

C_TEXT:C284($1;$directory)
C_POINTER:C301($2;$pa_files)
C_LONGINT:C283($vlElem)
$directory:=$1
$pa_files:=$2

ARRAY TEXT:C222($arr_documents;0)
DOCUMENT LIST:C474($directory;$arr_documents)


For ($i;1;Size of array:C274($arr_documents))
	If ($arr_documents{$i}#".@")
		APPEND TO ARRAY:C911($pa_files->;$directory+Folder separator:K24:12+$arr_documents{$i})
	End if 
End for 