//%attributes = {}
  //KRL_ExecuteMethod


C_LONGINT:C283($0;$methodID)
C_TEXT:C284($1;$methodName)
C_BOOLEAN:C305($use_ApiPack)
$methodName:=$1
$use_ApiPack:=True:C214
If (Count parameters:C259=2)
	$use_ApiPack:=$2
End if 



If ($use_ApiPack)
	If (API Does Method Exist ($methodName)=1)
		$methodID:=API Get Method ID ($methodName)
		$err:=API Execute Method By ID ($methodID)
		If ($err#0)
			EXECUTE FORMULA:C63($methodName)
		End if 
	Else 
		$err:=-3
	End if 
Else 
	$err:=0
	EXECUTE FORMULA:C63($methodName)
End if 
$0:=$err