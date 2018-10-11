//%attributes = {"invisible":true}
C_POINTER:C301($1)
C_TEXT:C284($0)

ASSERT:C1129((Count parameters:C259>0);Get localized string:C991("a pointer was expected."))
ASSERT:C1129((Not:C34(Is nil pointer:C315($1)));Get localized string:C991("the pointer is invalid."))

C_TEXT:C284($json_t;$result_t)
C_LONGINT:C283($i)

Case of 
	: (Type:C295($1->)=LongInt array:K8:19) | (Type:C295($1->)=Real array:K8:17) | (Type:C295($1->)=Integer array:K8:18)
		
		$json_t:="["
		
		For ($i;1;Size of array:C274($1->))
			If ($i#1)
				$json_t:=$json_t+","
			End if 
			$json_t:=$json_t+String:C10($1->{$i})
		End for 
		
		$json_t:=$json_t+"]"
		
	: (Type:C295($1->)=Text array:K8:16)
		
		$json_t:="["
		
		For ($i;1;Size of array:C274($1->))
			If ($i#1)
				$json_t:=$json_t+","
			End if 
			If (PHP Execute:C1058("";"json_encode";$result_t;$1->{$i}))
				$json_t:=$json_t+$result_t
			End if 
		End for 
		
		$json_t:=$json_t+"]"
		
End case 

$0:=$json_t