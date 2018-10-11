//%attributes = {}
  // VC4D_GetLogPath()
  // Por: Alberto Bachler K.: 01-10-14, 09:17:52
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_index;$l_logSize;$l_posicion)
C_TIME:C306($h_logRef)
C_POINTER:C301($y_CodeRepositoryPath)
C_TEXT:C284($t_VC4DcodeChangeLog;$t_VC4DcodeFolder;$t_VC4Dfolder)

ARRAY TEXT:C222($at_logs;0)

$y_CodeRepositoryPath:=$1

$t_VC4Dfolder:=Get 4D folder:C485(Database folder:K5:14)+"VC4D"+Folder separator:K24:12
$t_VC4DcodeFolder:=$t_VC4Dfolder+"CodeRepository"+Folder separator:K24:12
SYS_CreateFolder ($t_VC4DcodeFolder)
DOCUMENT LIST:C474($t_VC4Dfolder;$at_logs;Absolute path:K24:14+Ignore invisible:K24:16)
If (Size of array:C274($at_logs)=0)
	$h_logRef:=Create document:C266($t_VC4Dfolder+"CodeChangeLog_"+String:C10(1;"000")+".json")
	CLOSE DOCUMENT:C267($h_logRef)
	$t_VC4DcodeChangeLog:=document
Else 
	$l_posicion:=Find in array:C230($at_logs;$t_VC4DcodeFolder)
	If ($l_posicion>0)
		DELETE FROM ARRAY:C228($at_logs;$l_posicion)
	End if 
	SORT ARRAY:C229($at_logs;<)
	$l_logSize:=Get document size:C479($at_logs{1})
	If ($l_logSize>1000000)
		$l_index:=Num:C11(SYS_Path2FileName ($at_logs{1}))+1
		$h_logRef:=Create document:C266($t_VC4Dfolder+"CodeChangeLog_"+String:C10($l_index;"000")+".json")
		CLOSE DOCUMENT:C267($h_logRef)
		$t_VC4DcodeChangeLog:=document
	Else 
		$t_VC4DcodeChangeLog:=$at_logs{1}
	End if 
	
End if 
$y_CodeRepositoryPath->:=$t_VC4DcodeFolder
$0:=$t_VC4DcodeChangeLog
