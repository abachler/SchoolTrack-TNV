AL_ExitCell (xALP_Bancos)
AL_UpdateArrays (xALP_Bancos;0)
AT_Insert (1;1;->atACT_BankID;->atACT_BankName;->abACT_BankEstandar;->alACT_BankRecNum;->abACT_BankModified;->atACT_BankNumConvenio)
abACT_BankEstandar{1}:=False:C215
alACT_BankRecNum{1}:=-1
abACT_BankModified{1}:=True:C214
AL_UpdateArrays (xALP_Bancos;-2)
For ($i;1;Size of array:C274(abACT_BankModified))
	ARRAY LONGINT:C221($LongArray;2;0)
	If (abACT_BankEstandar{$i})
		$enterable:=Num:C11(<>lUSR_CurrentUserID<0)
		AL_SetCellEnter (xALP_Bancos;1;$i;2;$i;$LongArray;$enterable)
		AL_SetCellStyle (xALP_Bancos;1;$i;2;$i;$LongArray;2;"")
	End if 
End for 
GOTO OBJECT:C206(xALP_Bancos)
AL_GotoCell (xALP_Bancos;1;1)
AL_SetCellHigh (xALP_Bancos;1;80)