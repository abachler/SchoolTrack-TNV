//%attributes = {}
  // UTIL_isIPAddress()
  // Por: Alberto Bachler K.: 10-09-15, 19:28:14
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

C_TEXT:C284($1;$t_expression)
C_BOOLEAN:C305($0;$b_isIPAddress)

C_TEXT:C284($t_pattern)

$t_expression:=$1

$t_pattern:="[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}"

$b_isIPAddress:=Match regex:C1019($t_pattern;$t_expression)

$0:=$b_isIPAddress

