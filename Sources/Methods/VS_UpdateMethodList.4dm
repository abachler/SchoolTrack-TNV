//%attributes = {}
  //VS_UpdateMethodList

$ref:=Open document:C264("")
If (ok=1)
	$list:=New list:C375
	RECEIVE PACKET:C104($ref;$method;"\r")
	$methodNumber:=0
	While ((ok=1) & ($method#""))
		$methodNumber:=$methodNumber+1
		APPEND TO LIST:C376($list;$method;$methodNumber)
		RECEIVE PACKET:C104($ref;$method;"\r")
	End while 
	CLOSE DOCUMENT:C267($ref)
	SAVE LIST:C384($list;"Methods")
End if 