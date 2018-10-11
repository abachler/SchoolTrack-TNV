//%attributes = {}
  // Project Method: FTP_UploadMultipleFiles

C_POINTER:C301($1;$pa_filepath)
C_TEXT:C284($2;$3;$currentHostPath;$vtToBeDeleted;$targetPath;$sep)
$pa_filepath:=$1
$currentHostPath:=$2
$vtToBeDeleted:=$3
$sep:=Folder separator:K24:12  // returns \ if Windows  or  : if Mac OS
$error:=FTP_Progress (100;100;"Uploading...";"*";"*")
For ($i;1;Size of array:C274($pa_filepath->))
	
	$fileName:=SYS_Path2FileName ($pa_filepath->{$i})
	$targetPath:=Replace string:C233($pa_filepath->{$i};$vtToBeDeleted;"")
	$targetPath:=$currentHostPath+"/"+Replace string:C233($targetPath;$sep;"/")
	$error:=FTP_Send (vlFTP_ConectionID;$pa_filepath->{$i};$targetPath;1)
	If ($error#10000)  // Cancel by the user
		If ($error#0)
			ALERT:C41(IT_ErrorText ($error))
		End if 
	Else 
		ALERT:C41(IT_ErrorText ($error))
	End if 
	
End for 