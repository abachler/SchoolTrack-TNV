//%attributes = {}
  //xALCB_EX_Conexiones

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2)
If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	If (AL_GetCellMod (xALP_Connexions)=1)
		vb_ConnectionsModified:=True:C214
	End if 
End if 