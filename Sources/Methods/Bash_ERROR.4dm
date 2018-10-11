//%attributes = {}
  //Bash_ERROR

C_LONGINT:C283($1;$iErrorCode)
$iErrorCode:=$1
C_TEXT:C284($2;$xErrorOptional)
$xErrorOptional:=$2
C_TEXT:C284($3;$xMethodName)
$xMethodName:=$3
  //------------------------------------------------------------
  //method_wide_constants_declarations
  //------------------------------------------------------------
  //local_variable_declarations
  //============================================================
  //init
  //local_variable_initializations
  //============================================================

If (Is compiled mode:C492)
	ALERT:C41($xErrorOptional+" in method "+$xMethodName)
Else 
	TRACE:C157
End if 