//%attributes = {}
  //IC_Error_Handling

C_LONGINT:C283($1;$Error)
C_TEXT:C284($2;$Command;vErrorMsg)

$Error:=$1
$Command:=$2
$ErrorMsg:=IT_ErrorText ($Error)

CD_Dlog (0;__ ("ERROR -- \rComando: ")+$Command+__ ("\rCódigo Error:")+String:C10($Error)+__ ("\rDescripción: ")+$ErrorMsg)
