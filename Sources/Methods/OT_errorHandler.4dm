//%attributes = {}
  // OT_errorHandler()
  // Por: Alberto Bachler: 15/11/13, 11:41:02
  //  ---------------------------------------------
  // adaptado a OT 5.0
  //
  //  ---------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($2)
C_LONGINT:C283($3)
C_TEXT:C284($4)

C_LONGINT:C283($l_refObject)
C_TEXT:C284($t_errorDescription;$t_nombreMetodo;$t_tag)


If (False:C215)
	C_TEXT:C284(OT_errorHandler ;$1)
	C_TEXT:C284(OT_errorHandler ;$2)
	C_LONGINT:C283(OT_errorHandler ;$3)
	C_TEXT:C284(OT_errorHandler ;$4)
End if 

$t_errorDescription:=$1
$t_nombreMetodo:=$2
$l_refObject:=$3  // OT 5
$t_tag:=$4  // OT 5


TRACE:C157




