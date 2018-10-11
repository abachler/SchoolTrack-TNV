//%attributes = {}
  //KRL_SaveRecord

C_LONGINT:C283($0)
C_POINTER:C301($tablePointer;$1)

$tablePointer:=$1
$0:=0

  // Modificado por: Alexis Bustamante (12-07-2017)
  //KRL_RegistroFueModificado ($tablePointer)
If (USR_checkRights ("M";$tablePointer))
	If (Modified record:C314($tablePointer->))
		SAVE RECORD:C53($tablePointer->)
		KRL_ReloadAsReadOnly ($tablePointer)
		$0:=1
	Else 
		$0:=0
	End if 
End if 