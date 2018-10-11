//%attributes = {}
  //ACTit_MuestraPopUpMenu

C_POINTER:C301($vy_PArreglo)
C_TEXT:C284($vt_texto;$text)
C_LONGINT:C283($choice;$default)

$vy_PArreglo:=$1
If (Count parameters:C259=2)
	$vt_texto:=$2
Else 
	$vt_texto:="Seleccione una opción"
End if 

If (Size of array:C274($vy_PArreglo->)<=50)
	$text:=AT_array2text ($vy_PArreglo)
	$choice:=Pop up menu:C542($text;$default)
Else 
	SRtbl_ShowChoiceList (0;$vt_texto;2;->brepositorio;False:C215;$vy_PArreglo)
	If (ok=1)
		$choice:=choiceidx
	Else 
		$choice:=-1
	End if 
End if 
$0:=$choice

