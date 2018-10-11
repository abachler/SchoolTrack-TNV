//%attributes = {}
  //BBLw_addLine

$linea:=$1
If (Count parameters:C259=2)
	$estilo:=$2
Else 
	$estilo:=3
End if 
$linea:=String:C10(Num:C11($linea)+1)
BBLw_more ($linea;$estilo)