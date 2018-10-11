//%attributes = {}
  //BWR_ModifyRecord

C_POINTER:C301($1)
C_TEXT:C284($2)
C_LONGINT:C283($n;$3)
FORM SET INPUT:C55($1->;$2)
If (Records in selection:C76($1->)#0)
	$locked:=KRL_IsRecordLocked ($1)
	If (Not:C34($locked))
		FORM SET INPUT:C55($1->;$2)
		If (Count parameters:C259=2)
			MODIFY RECORD:C57($1->;*)
		Else 
			If ($3=1)
				MODIFY RECORD:C57($1->)
			Else 
				MODIFY RECORD:C57($1->;*)
			End if 
		End if 
	End if 
	KRL_ReloadAsReadOnly ($1)
End if 