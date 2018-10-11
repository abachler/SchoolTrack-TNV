//%attributes = {}
  //KRL_SendRecord

C_BLOB:C604($blob)
C_POINTER:C301($tablePointer;$1)
C_BOOLEAN:C305($use_ApiPack)

$tablePointer:=$1
If (Count parameters:C259=2)
	$use_ApiPack:=$2
End if 


If ($use_ApiPack)
	$err:=API Record To Blob (Table:C252($tablePointer);$blob)
	SEND VARIABLE:C80($blob)
Else 
	SEND RECORD:C78($tablePointer->)
End if 