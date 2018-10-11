//%attributes = {}
  //xALCB_EX_Alergias

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2)
C_LONGINT:C283($Col;$Row)

If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	If (AL_GetCellMod (xALP_Alergias)=1)
		$stop:=False:C215
		vl_ModSalud:=vl_ModSalud ?+ 2
		AL_GetCurrCell (xALP_Alergias;$Col;$Row)
	End if 
End if 
