//%attributes = {}
  //INIT_ClearObjects

C_POINTER:C301(${1})

For ($i;1;Count parameters:C259)
	$type:=Type:C295(${$i}->)
	Case of 
		: (($type=Is alpha field:K8:1) | ($type=Is string var:K8:2) | ($type=Is text:K8:3))
			${$i}->:=""
		: (($type=Is real:K8:4) | ($type=Is integer:K8:5) | ($type=Is longint:K8:6))
			${$i}->:=0
		: ($type=Is date:K8:7)
			${$i}->:=!00-00-00!
		: ($type=Is time:K8:8)
			${$i}->:=?00:00:00?
		: ($type=Is BLOB:K8:12)
			SET BLOB SIZE:C606(${$i}->;0)
		: ($type=Is picture:K8:10)
			${$i}->:=${$i}->*0
		: (($type=Boolean array:K8:21) | ($type=Text array:K8:16) | ($type=Integer array:K8:18) | ($type=LongInt array:K8:19) | ($type=Picture array:K8:22) | ($type=Pointer array:K8:23) | ($type=String array:K8:15))
			AT_ResizeArrays (${$i};0)
		Else 
			CD_Dlog (0;__ ("Type ")+String:C10($type)+__ (" not supported by method INIT_ClearObjects"))
	End case 
End for 