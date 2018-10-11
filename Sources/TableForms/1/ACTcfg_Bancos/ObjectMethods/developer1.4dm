$line:=AL_GetLine (xALP_Bancos)
If ($line>0)
	abACT_BankEstandar{$line}:=Not:C34(abACT_BankEstandar{$line})
	abACT_BankModified{$line}:=True:C214
	For ($i;1;Size of array:C274(abACT_BankModified))
		ARRAY LONGINT:C221($LongArray;2;0)
		If (abACT_BankEstandar{$i})
			$enterable:=Num:C11(<>lUSR_CurrentUserID<0)
			AL_SetCellEnter (xALP_Bancos;1;$i;2;$i;$LongArray;$enterable)
			AL_SetCellStyle (xALP_Bancos;1;$i;2;$i;$LongArray;2;"")
		Else 
			AL_SetCellEnter (xALP_Bancos;1;$i;2;$i;$LongArray;1)
			AL_SetCellStyle (xALP_Bancos;1;$i;2;$i;$LongArray;0;"")
		End if 
	End for 
	AL_UpdateArrays (xALP_Bancos;-1)
	If ($line>0)
		If (abACT_BankEstandar{$line})
			IT_SetButtonState ((<>lUSR_CurrentUserID<0);->bClearBank)
			OBJECT SET TITLE:C194(bEstandar;__ ("Marcar como no estándar"))
		Else 
			_O_ENABLE BUTTON:C192(bClearBank)
			OBJECT SET TITLE:C194(bEstandar;__ ("Marcar como estándar"))
		End if 
		_O_ENABLE BUTTON:C192(bEstandar)
	Else 
		_O_DISABLE BUTTON:C193(bClearBank)
		_O_DISABLE BUTTON:C193(bEstandar)
	End if 
End if 