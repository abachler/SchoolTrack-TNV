//%attributes = {}
  //SYS_GetAllSubpaths

  // Project Method: Get_All_Subpath
  // Description: Insert all directories into an array

C_POINTER:C301($1;$pa_rootdir)
$pa_rootdir:=$1

C_LONGINT:C283($next)
$next:=0

Repeat 
	$next:=$next+1
	SYS_GetSubdirectories ($pa_rootdir->{$next};$pa_rootdir)
Until ($next>=Size of array:C274($pa_rootdir->))

