//%attributes = {}
  //KRL_GotoSelectedRecord

C_POINTER:C301($1)
C_LONGINT:C283($2)
C_BOOLEAN:C305($3)


$0:=True:C214
$testIfLocked:=False:C215
If (Count parameters:C259=3)
	If ($3)
		$testIfLocked:=True:C214
		READ WRITE:C146($1->)
	Else 
		READ ONLY:C145($1->)
	End if 
End if 
If ($2>0)
	GOTO SELECTED RECORD:C245($1->;$2)
	If ($testIfLocked)
		$0:=Not:C34(Locked:C147($1->))
	End if 
End if 
