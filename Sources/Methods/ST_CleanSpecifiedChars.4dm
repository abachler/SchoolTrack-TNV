//%attributes = {}
  //ST_CleanSpecifiedChars

$stringToBeCleaned:=$1
$charsToBeDeleted:=$2
$length:=Length:C16($charsToBeDeleted)


For ($i;1;$length)
	$char:=Character code:C91($charsToBeDeleted[[$i]])
	For ($j;Length:C16($stringToBeCleaned);1;-1)
		If ($j<=Length:C16($stringToBeCleaned))
			If ($char=Character code:C91($stringToBeCleaned[[$j]]))
				$stringToBeCleaned:=Delete string:C232($stringToBeCleaned;$j;1)
			End if 
		End if 
	End for 
End for 

$0:=$stringToBeCleaned
