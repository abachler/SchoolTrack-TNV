//%attributes = {}
  //ACTcm_LoadYear

C_LONGINT:C283($añolong;$1)
$añolong:=$1
For ($i;1;12)
	$ptr:=Get pointer:C304("vMesNombre"+String:C10($i))
	$ptr->:=<>atXS_MonthNames{$i}
	$ptr:=Get pointer:C304("cb_Cerrado"+String:C10($i))
	$ptr2:=Get pointer:C304("vb_BloqDef"+String:C10($i))
	$ptr->:=Num:C11(Not:C34(ACTcm_IsMonthOpenFromMonthYear ($i;$añolong;$ptr2)))
	IT_SetButtonState (Not:C34($ptr2->);$ptr)
	If ($ptr2->)
		OBJECT SET COLOR:C271($ptr->;-3)
	Else 
		OBJECT SET COLOR:C271($ptr->;-15)
	End if 
End for 
modBloqueos:=False:C215
_O_DISABLE BUTTON:C193(bRevertir)