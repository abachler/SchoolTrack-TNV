//%attributes = {}
C_OBJECT:C1216($1;$object)
C_BOOLEAN:C305($hasProperty)
C_BOOLEAN:C305($errValue)
C_BOOLEAN:C305($0)

$object:=$1

$hasProperty:=OB Is defined:C1231($object;"ERR")

If ($hasProperty)
	$errValue:=OB Get:C1224($object;"ERR";Is boolean:K8:9)
Else 
	$errValue:=False:C215
End if 
$0:=$errValue
