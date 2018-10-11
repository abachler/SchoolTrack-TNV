//%attributes = {}
  //xALCB_EX_TablasConversion_EVS

C_LONGINT:C283($1;$2;$3)
C_BOOLEAN:C305($0)
C_LONGINT:C283($Column;$line)

If ($2=8)
	$0:=False:C215
Else 
	$0:=True:C214
	AL_GetCurrCell (xALP_ConversionTable;$Column;$line)
	If (AL_GetCellMod (xALP_ConversionTable)=1)
		EVS_SetModified 
	End if 
End if 