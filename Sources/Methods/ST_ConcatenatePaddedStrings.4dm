//%attributes = {}
  //ST_ConcatenatePaddedStrings

C_POINTER:C301($1;$textPointer;$2;$lengthPointer;$3;$padPointer;$4;$positionPointer)
C_TEXT:C284($0;$padString;$separador)
If (Count parameters:C259=5)
	C_POINTER:C301($5;$delimiter)
	$textPointer:=$1
	$padPointer:=$2
	$lengthPointer:=$3
	$positionPointer:=$4
	$delimiter:=$5
Else 
	$textPointer:=$1
	$padPointer:=$2
	$lengthPointer:=$3
	$positionPointer:=$4
End if 
$0:=""
For ($i;1;Size of array:C274($textPointer->))
	$minLength:=$lengthPointer->{$i}
	$padString:=$padPointer->{$i}
	$position:=$positionPointer->{$i}
	$textlength:=Length:C16($textPointer->{$i})
	$text:=Substring:C12($textPointer->{$i};1;$minLength)
	$padText:=$padString*($minLength-$textLength)
	If (Count parameters:C259=5)
		$separador:=$delimiter->{$i}
	End if 
	If ($padText#"")
		If (($position="L") | ($position="I"))
			$0:=$0+$padText+$text+$separador
		Else 
			$0:=$0+$text+$padText+$separador
		End if 
	Else 
		$0:=$0+$text+$separador
	End if 
End for 
If ($separador#"")
	$0:=Substring:C12($0;1;Length:C16($0)-1)
End if 