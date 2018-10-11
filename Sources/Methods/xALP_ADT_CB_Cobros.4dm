//%attributes = {}
  //xALP_ADT_CB_Cobros

C_LONGINT:C283($1;$2)
C_BOOLEAN:C305($0)

AL_GetCurrCell (xALP_ItemsADTCdd;$col;$row)
If (AL_GetCellMod (xALP_ItemsADTCdd)=1)
	Case of 
		: ($col=3)
			arADT_Monto{$row}:=Round:C94(arADT_Monto{$row};<>vlACT_Decimales)
	End case 
End if 