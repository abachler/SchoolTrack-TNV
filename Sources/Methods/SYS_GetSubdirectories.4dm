//%attributes = {}
  //SYS_GetSubdirectories

C_TEXT:C284($1;$root;$sep)
C_POINTER:C301($2;$pa_directories)
C_LONGINT:C283($vlElem)
$root:=$1
$pa_directories:=$2
$sep:=Folder separator:K24:12  // returns \ if Windows  or  : if Mac OS

ARRAY TEXT:C222($subdirectories;0)
FOLDER LIST:C473($root;$subdirectories)

For ($i;1;Size of array:C274($subdirectories))
	$vlElem:=Size of array:C274($pa_directories->)+1
	INSERT IN ARRAY:C227($pa_directories->;$vlElem)
	$pa_directories->{$vlElem}:=$root+Folder separator:K24:12+$subdirectories{$i}
End for 