//%attributes = {}
  //SN3_GenerateUniqueName


C_TEXT:C284($0)
C_DATE:C307($1;$init)
  //C_LONGINT($secs)
C_REAL:C285($secs)

$init:=!2009-01-01!
If (Count parameters:C259=1)
	$init:=$1
End if 
$days:=Current date:C33(*)-$init
$secs:=$days*24*60*60+(Current time:C178(*)*1)

  //20120306 RCH Se hace cambio a pedido de JHB
  //$0:=String($secs;"00000000")
  //$0:=String($secs;"000000000000000")
$0:=String:C10(Abs:C99($secs))