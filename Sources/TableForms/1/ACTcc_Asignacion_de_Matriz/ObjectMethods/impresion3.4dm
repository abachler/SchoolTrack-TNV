vbSpell_StopChecking:=True:C214
C_LONGINT:C283($choice)
IT_Clairvoyance (Self:C308;->atACTcc_MatrixName;"";False:C215)
If (Form event:C388=On Data Change:K2:15)
	$choice:=Find in array:C230(<>atACT_MatrixName;Self:C308->)
	If ($choice#-1)
		Self:C308->:=<>atACT_MatrixName{$choice}
	Else 
		Self:C308->:="Ninguna"
	End if 
End if 