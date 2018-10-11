//%attributes = {}
C_TEXT:C284($1)

If (Position:C15("-";$1)=0)
	$0:=Lowercase:C14(Substring:C12($1;1;8)+"-"+Substring:C12($1;9;4)+"-"+Substring:C12($1;13;4)+"-"+Substring:C12($1;17;4)+"-"+Substring:C12($1;21))
Else 
	$0:=$1
End if 