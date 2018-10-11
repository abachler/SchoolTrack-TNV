//%attributes = {}
  //ACT_SetTotalsColorInputForm

C_POINTER:C301($1;$2)
C_POINTER:C301($ptr_saldo;$ptr_vencido)
$ptr_saldo:=$1
$ptr_vencido:=$2

If ($ptr_saldo-><0)
	OBJECT SET COLOR:C271($ptr_saldo->;-3)
Else 
	OBJECT SET COLOR:C271($ptr_saldo->;-6)
End if 
If ($ptr_vencido-><0)
	OBJECT SET COLOR:C271($ptr_vencido->;-3)
Else 
	OBJECT SET COLOR:C271($ptr_vencido->;-6)
End if 