//%attributes = {}
  //xALCB_EX_Hospitalizaciones

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2)
C_LONGINT:C283($Col;$Row)
If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	If (AL_GetCellMod (xALP_Hospitalizaciones)=1)
		$stop:=False:C215
		vl_ModSalud:=vl_ModSalud ?+ 1
		AL_GetCurrCell (xALP_Hospitalizaciones;$Col;$Row)
	End if 
End if 