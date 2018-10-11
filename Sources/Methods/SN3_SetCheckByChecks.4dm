//%attributes = {}
  //SN3_SetCheckByChecks

C_POINTER:C301($1;$resultvar)
C_TEXT:C284($2;$booleanRel)
C_POINTER:C301(${3})

$resultvar:=$1
$booleanRel:=$2

Case of 
	: ($booleanRel="&")
		$result:=False:C215
		For ($i;3;Count parameters:C259)
			$result:=$result & (${$i}->=1)
		End for 
	: ($booleanRel="|")
		$result:=False:C215
		For ($i;3;Count parameters:C259)
			$result:=$result | (${$i}->=1)
		End for 
End case 
$resultvar->:=Num:C11($result)
SN3_SetPubInterfaceObjects 

