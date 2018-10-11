//%attributes = {}
  //ST_Boolean2Text

C_TEXT:C284($0;$2;$3)
C_BOOLEAN:C305($1)
If ($1)
	$0:=$2
Else 
	If (Count parameters:C259=3)
		$0:=$3
	End if 
End if 