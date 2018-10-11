//%attributes = {}
  //ST_Coerce_to_Text

C_TEXT:C284($0)
C_POINTER:C301($varPtr)
C_BOOLEAN:C305($2;$alert)

$varPtr:=$1
$alert:=True:C214
If (Count parameters:C259=2)
	$alert:=$2
End if 
$type:=Type:C295($varPtr->)
$0:=""
Case of 
	: (($type=Is alpha field:K8:1) | ($type=Is string var:K8:2) | ($type=Is text:K8:3))
		$0:=$varPtr->
	: (($type=Is real:K8:4) | ($type=Is longint:K8:6) | ($type=Is integer:K8:5) | ($type=Is integer 64 bits:K8:25) | ($type=Is float:K8:26))
		$0:=String:C10($varPtr->)
	: ($type=Is date:K8:7)
		$0:=String:C10($varPtr->;7)
	: ($type=Is time:K8:8)
		$0:=String:C10($varPtr->;1)
	: ($type=Is boolean:K8:9)
		$0:=String:C10(Num:C11($varPtr->);"Verdadero;;Falso")
	Else 
		$0:=""
		If ($alert)
			ALERT:C41("Tipo no soportado")
		End if 
End case 