//%attributes = {}
  //HTML_mseOver

C_TEXT:C284($0;$1)
$apostrophe:=Position:C15("'";$1)
While ($apostrophe>0)
	$1[[$apostrophe]]:="´"
	$apostrophe:=Position:C15("'";$1)
End while 
$quotes:=Position:C15(Char:C90(34);$1)
While ($quotes>0)
	$1[[$quotes]]:=" "
	$quotes:=Position:C15(Char:C90(34);$1)
End while 
$0:=" onmouseover="+ST_Qte ("window.status='"+_O_Mac to ISO:C519($1)+"'; return true")

