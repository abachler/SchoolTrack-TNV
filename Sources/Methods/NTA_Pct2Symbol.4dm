//%attributes = {}
  //NTA_Pct2Symbol


$0:=""
$realNumber:=Round:C94($1;6)
For ($k;1;Size of array:C274(aSymbol)-1)
	If (($realNumber>=Round:C94(aSymbPctFrom{$k};11)) & ($realNumber<Round:C94(aSymbPctFrom{$k+1};11)))
		$0:=aSymbol{$k}
		$k:=Size of array:C274(aSymbol)
	End if 
End for 
If ($0="")
	If (($realNumber>=Round:C94(aSymbPctFrom{Size of array:C274(aSymbol)};11)) & ($realNumber<100))
		$0:=aSymbol{Size of array:C274(aSymbol)}
	Else 
		$0:="S?"
	End if 
End if 