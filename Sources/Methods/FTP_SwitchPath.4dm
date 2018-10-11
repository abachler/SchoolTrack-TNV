//%attributes = {}
  //FTP_SwitchPath

C_TEXT:C284($1;$tCurrPath)
$tCurrPath:=$1

ARRAY TEXT:C222(<>arrCurrPath;0)
AT_Text2Array (-><>arrCurrPath;$tCurrPath;"/")
  //GetStringToken($tCurrPath;"/";-><>arrCurrPath)

C_LONGINT:C283($arrSize)
$arrSize:=Size of array:C274(<>arrCurrPath)

For ($i;1;$arrSize)
	$firstChar:=Substring:C12(<>arrCurrPath{$i};1;1)
	If ($firstChar#"/")
		<>arrCurrPath{$i}:="/"+<>arrCurrPath{$i}
	End if 
End for 

