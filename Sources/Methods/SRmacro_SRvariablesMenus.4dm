//%attributes = {}
  //SRmacro_SRvariablesMenus

$text:=Get text from pasteboard:C524

ARRAY TEXT:C222(aText;0)
AT_Text2Array (->aText;$text;"\r")
$index:=0
For ($i;1;Size of array:C274(aText))
	If (aText{$i}="@asSRVariables@")
		If (Position:C15("{$i+";aText{$i})>0)
			$t1:=Substring:C12(aText{$i};1;Position:C15("{$i+";aText{$i})+3)
			$t2:=Substring:C12(aText{$i};Position:C15("}";aText{$i}))
			aText{$i}:=$t1+String:C10($index)+$t2
			$index:=$index+12
		Else 
			$index:=$index+1
			$t1:=Substring:C12(aText{$i};1;Position:C15("{";aText{$i}))
			$t2:=Substring:C12(aText{$i};Position:C15("}";aText{$i}))
			aText{$i}:=$t1+String:C10($index)+$t2
		End if 
		
	End if 
End for 

$text:=AT_array2text (->aText;"\r")
SET TEXT TO PASTEBOARD:C523($text)

