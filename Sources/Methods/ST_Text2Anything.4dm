//%attributes = {}
  //MONO
  //ST_Text2Anything
C_POINTER:C301($1;$ptr_target)
C_TEXT:C284($2;$vt_text2convert)
$ptr_target:=$1
$vt_text2convert:=$2

$type:=Type:C295($ptr_target->)

Case of 
	: (($type=Is alpha field:K8:1) | ($type=Is string var:K8:2) | ($type=Is text:K8:3))
		$ptr_target->:=$vt_text2convert
	: (($type=Is real:K8:4) | ($type=Is longint:K8:6) | ($type=Is integer:K8:5))
		$ptr_target->:=Num:C11($vt_text2convert)
	: ($type=Is date:K8:7)
		$ptr_target->:=Date:C102($vt_text2convert)
	: ($type=Is time:K8:8)
		$ptr_target->:=Time:C179($vt_text2convert)
	: ($type=Is boolean:K8:9)
		If (($vt_text2convert="true") | ($vt_text2convert="verdadero") | ($vt_text2convert="1") | ($vt_text2convert="Si"))
			$ptr_target->:=True:C214
		Else 
			$ptr_target->:=False:C215
		End if 
	Else 
		
End case 