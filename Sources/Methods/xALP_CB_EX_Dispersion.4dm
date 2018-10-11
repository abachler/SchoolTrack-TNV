//%attributes = {}
  //xALP_CB_EX_Dispersion

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2;$3)

If ($2=8)
	$0:=False:C215
Else 
	AL_GetCurrCell (xALP_Dispersion;$col;$row)
	If ($col=2)
		If ($row<=7)
			If ((atCU_DispersionTo{$row}="") & (atCU_DispersionTo{$row+1}#""))
				BEEP:C151
				atCU_DispersionTo{$row}:=atCU_DispersionTo{0}
			End if 
		End if 
		arCU_DispersionFrom{$row}:=NTA_StringValue2Percent (atCU_DispersionFrom{$row})
		arCU_Dispersionto{$row}:=NTA_StringValue2Percent (atCU_DispersionTo{$row})
	End if 
	$0:=True:C214
End if 