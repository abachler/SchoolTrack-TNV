//%attributes = {}
  //dhXS_CloseChildProcess

If (Count parameters:C259=1)
	$moduleRef:=$1
Else 
	$moduleRef:=vlBWR_currentModuleRef
End if 

Case of 
	: ($moduleRef=2)
		<>bMediaTrackIsRunning:=False:C215
		RESUME PROCESS:C320(<>lBBL_CircPcsID)
		POST OUTSIDE CALL:C329(<>lBBL_CircPcsID)
	: ($moduleRef=3)
		<>bAccountTrackIsRunning:=False:C215
		POST OUTSIDE CALL:C329(<>lACT_PagosCaja)
		POST OUTSIDE CALL:C329(<>lACT_Documentar)
		POST OUTSIDE CALL:C329(<>lACT_PagosRapidos)
End case 