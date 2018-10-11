//%attributes = {}
  // STWA2_JSON_SendError()
  // Por: Alberto Bachler K.: 19-02-15, 10:27:02
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($0)
C_LONGINT:C283($1)
C_TEXT:C284($2)

C_LONGINT:C283($t_errorCode)
C_TEXT:C284($t_errorText)
C_OBJECT:C1216($ob_json)


If (False:C215)
	C_TEXT:C284(STWA2_JSON_SendError ;$0)
	C_LONGINT:C283(STWA2_JSON_SendError ;$1)
	C_TEXT:C284(STWA2_JSON_SendError ;$2)
End if 

$t_errorText:="ERR"
$t_errorCode:=$1
If (Count parameters:C259=2)
	$t_errorText:=$2
End if 

$ob_json:=OB_Create 
OB_SET_Text ($ob_json;String:C10($t_errorCode);$t_errorText)
$0:=OB_Object2Json ($ob_json)


