//%attributes = {}
  // Project Method: FTP_UploadFolders

C_POINTER:C301($1;$pa_directories)
C_TEXT:C284($2;$3;$currentHostPath;$vtToBeDeleted;$sep)
$pa_directories:=$1
$currentHostPath:=$2
$vtToBeDeleted:=$3
$sep:=Folder separator:K24:12  // returns \ if Windows  or  : if Mac OS

C_LONGINT:C283($lastChar)
$lastChar:=Length:C16($currentHostPath)
If ($currentHostPath[[$lastChar]]="/")
	$currentHostPath:=Delete string:C232($currentHostPath;$lastChar;1)
End if 

C_LONGINT:C283($maxArray;$error)
$maxArray:=Size of array:C274($pa_directories->)
For ($i;1;$maxArray)
	$targetPath:=Replace string:C233($pa_directories->{$i};$vtToBeDeleted;"")
	$targetPath:=$currentHostPath+"/"+Replace string:C233($targetPath;$sep;"/")
	$error:=FTP_MakeDir (vlFTP_ConectionID;$targetPath)
	If ($error#0)
		CD_Dlog (0;IT_ErrorText ($error))
	End if 
End for 

