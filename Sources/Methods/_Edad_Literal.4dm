//%attributes = {}
  //_Edad_Literal

C_DATE:C307($1;$2)
C_TEXT:C284($0)

If (Count parameters:C259=1)
	$0:=DT_ReturnAge ($1)
Else 
	$0:=DT_ReturnAge ($1;$2)
End if 
$0:=Replace string:C233($0;":";" años, ")+" mes(es)"
