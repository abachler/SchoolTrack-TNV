//%attributes = {}
  //xALCB_EX_CtasBancarias

C_LONGINT:C283($1;$2;$3)
C_BOOLEAN:C305($0)

If ($2=8)
	$0:=False:C215
Else 
	$0:=True:C214
	If (AL_GetCellMod (xALP_CtasBancarias)=1)
		AL_GetCurrCell (xALP_CtasBancarias;$col;$row)
		If ($col=1)
			$pos:=Find in array:C230(atACT_BankName;atACT_CtaColegioBanco{$row})
			If ($pos#-1)
				atACT_CtaColegioCod{$row}:=atACT_BankID{$pos}
			End if 
		End if 
	End if 
End if 