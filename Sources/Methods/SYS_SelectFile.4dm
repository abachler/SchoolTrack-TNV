//%attributes = {}
  //SYS_SelectFile

If (False:C215)
	  //Method SYS_SelectFileName
	  //by ABK
	  //30/12/97
	  //return the path for the selected file
	  //SYS_selectFileName{({$1}...{$n})}
End if 
C_TEXT:C284($0;$path;$types)
$path:=$1
If (Count parameters:C259=1)
	$types:="*"
Else 
	$types:=""
	For ($i;2;Count parameters:C259)
		$types:=$types+${$i}+";"
	End for 
End if 
$filepath:=Select document:C905($path;$types;__ ("Seleccione el documento...");0)
If ($filePath#"")
	$0:=document
End if 
