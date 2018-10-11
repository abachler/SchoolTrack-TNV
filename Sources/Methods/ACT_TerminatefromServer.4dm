//%attributes = {}
  //ACT_TerminatefromServer

If (Count parameters:C259>0)
	vpXS_IconModule:=$1
	vsBWR_CurrentModule:=$2
End if 
$ACTPosition:=Find in array:C230(<>atXS_ModuleNames;"AccountTrack")
If ($ACTPosition#-1)
	CD_Dlog (0;__ ("AccountTrack terminó de reconfigurarse."))
	$moduleProcessIDACT:=<>alXS_ModuleProcessID{$ACTPosition}
	BRING TO FRONT:C326($moduleProcessIDACT)
	POST KEY:C465(27;0;$moduleProcessIDACT)
End if 