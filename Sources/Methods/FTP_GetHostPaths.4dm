//%attributes = {}
  // Project Method: FTP_GetHostPaths
  // Description: Get all directories path within the selected directory

C_LONGINT:C283($1;$FTP_ID;$next)
C_POINTER:C301($2;$3;$pa_directories;$pa_files)
$FTP_ID:=$1
$pa_directories:=$2
$pa_files:=$3
$next:=0

Repeat 
	$next:=$next+1
	FTP_GetHostSubPaths ($pa_directories->{$next};$pa_directories;$pa_files)
Until ($next>=Size of array:C274($pa_directories->))
