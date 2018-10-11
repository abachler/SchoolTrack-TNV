//%attributes = {}
  //ADTcdd_LoadEstados2Arrays

ARRAY TEXT:C222(<>aSitFinales;0)
ARRAY TEXT:C222(<>aEstados;0)

$tempList:=New list:C375
$tempList:=ADTcfg_LoadEstados 
HL_ExpandAll ($tempList)
For ($i;1;Count list items:C380($tempList))
	GET LIST ITEM:C378($tempList;$i;$ref;$text)
	If ($ref<=-100)
		APPEND TO ARRAY:C911(<>aSitFinales;$text)
	Else 
		APPEND TO ARRAY:C911(<>aEstados;$text)
		APPEND TO ARRAY:C911(<>aSitFinales;$text)
	End if 
End for 
CLEAR LIST:C377($tempList)