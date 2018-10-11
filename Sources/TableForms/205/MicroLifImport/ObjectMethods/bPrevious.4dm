If (vlBBL_CurrentRecordNum>1)
	SET DOCUMENT POSITION:C482(vhBBL_DocRef;0)
	For ($i;1;(vlBBL_CurrentRecordNum-2))
		RECEIVE PACKET:C104(vhBBL_DocRef;vtBBL_CurrentRecord;"`")
	End for 
	vlBBL_CurrentRecordNum:=vlBBL_CurrentRecordNum-1
	RECEIVE PACKET:C104(vhBBL_DocRef;vtBBL_CurrentRecord;"`")
	POST KEY:C465(Character code:C91("'");256)
Else 
	BEEP:C151
End if 


