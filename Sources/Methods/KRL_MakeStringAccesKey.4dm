//%attributes = {}
  //KRL_MakeStringAccesKey


$delim:="."

$text:=""

For ($i;1;Count parameters:C259)
	
	$type:=Type:C295(${$i}->)
	
	Case of 
		: (($type=Is pointer:K8:14) | ($type=Is picture:K8:10))
			ALERT:C41("Type "+String:C10($type)+" is not supported by the KRL_MakeStringAccesKey function.")
		: ($type=Is boolean:K8:9)
			$text:=$text+String:C10(Num:C11(${$i}->))+$delim
		: (($type#Is alpha field:K8:1) & ($type#Is string var:K8:2) & ($type#Is text:K8:3))
			$text:=$text+String:C10(${$i}->)+$delim
		: (($type=Is alpha field:K8:1) | ($type=Is string var:K8:2) | ($type=Is text:K8:3))
			$text:=$text+${$i}->+$delim
	End case 
End for 
$0:=Substring:C12($text;1;Length:C16($text)-1)