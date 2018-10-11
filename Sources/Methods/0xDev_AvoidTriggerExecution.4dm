//%attributes = {}
  //0xDev_AvoidTriggerExecution

C_BOOLEAN:C305($1)
If (Application type:C494=4D Remote mode:K5:5)
	SET PROCESS VARIABLE:C370(-1;<>vb_AvoidTriggerExecution;$1)
	DELAY PROCESS:C323(Current process:C322;15)
Else 
	<>vb_AvoidTriggerExecution:=$1
End if 