//%attributes = {}
  //ST_clearUnNecessaryCR

$text:=ST_ClearExtraCR (ST_ClearSpaces ($1))
$result:=""
$pos:=Position:C15("\r";$text)
While ($pos>0)
	Case of 
		: (Substring:C12($text;$pos-2;2)=". ")
			$result:=$result+Substring:C12($text;1;$pos-1)+"\r"
		: (Substring:C12($text;$pos-1;1)=".")
			$result:=$result+Substring:C12($text;1;$pos-1)+"\r"
		: (Substring:C12($text;$pos-2;2)=": ")
			$result:=$result+Substring:C12($text;1;$pos-2)+"\r"
		: (Substring:C12($text;$pos-1;1)=":")
			$result:=$result+Substring:C12($text;1;$pos-1)+"\r"
		: (Substring:C12($text;$pos-2;2)="! ")
			$result:=$result+Substring:C12($text;1;$pos-2)+"\r"
		: (Substring:C12($text;$pos-1;1)="!")
			$result:=$result+Substring:C12($text;1;$pos-1)+"\r"
		: (Substring:C12($text;$pos-2;2)="? ")
			$result:=$result+Substring:C12($text;1;$pos-2)+"\r"
		: (Substring:C12($text;$pos-1;1)="?")
			$result:=$result+Substring:C12($text;1;$pos-1)+"\r"
		Else 
			$result:=$result+Substring:C12($text;1;$pos-1)+" "
	End case 
	$text:=Substring:C12($text;$pos+1)
	$pos:=Position:C15("\r";$text)
End while 
$0:=ST_ClearSpaces ($result+$text)