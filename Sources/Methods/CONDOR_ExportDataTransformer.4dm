//%attributes = {}
C_TEXT:C284($0;$valor;$text)
C_POINTER:C301($1)
C_BOOLEAN:C305($transformed)
C_BLOB:C604($blob)

$transformed:=dhSync_HandleSendingChanges ($1;->$valor)
If ($transformed)
	$0:=$valor
Else 
	$type:=Type:C295($1->)
	Case of 
		: (($type=Is text:K8:3) | ($type=Is alpha field:K8:1))
			$text:=$1->
			$text:=Replace string:C233($text;Char:C90(0);"";*)
			If (Position:C15("<";$text)=1)
				$0:=""
			Else 
				$0:=$text
			End if 
		: ($type=Is object:K8:27)
			$0:=JSON Stringify:C1217($1->)
		: (($type=Is real:K8:4) | ($type=Is integer:K8:5) | ($type=Is integer 64 bits:K8:25) | ($type=Is longint:K8:6) | ($type=Is float:K8:26))
			$0:=String:C10($1->)
		: ($type=Is date:K8:7)
			$0:=SN3_MakeDateInmune2LocalFormat ($1->)
		: ($type=Is time:K8:8)
			$0:=String:C10($1->;HH MM SS:K7:1)
		: ($type=Is BLOB:K8:12)
			BASE64 ENCODE:C895($1->;$0)
		: ($type=Is picture:K8:10)
			PICTURE TO BLOB:C692($1->;$blob;".jpg")
			BASE64 ENCODE:C895($blob;$0)
		: ($type=Is boolean:K8:9)
			$0:=String:C10(Num:C11($1->))
	End case 
End if 