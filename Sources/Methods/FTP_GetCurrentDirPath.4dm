//%attributes = {}
  //FTP_GetCurrentDirPath

C_TEXT:C284($0;$tCurrPath)

For ($i;1;Size of array:C274(<>arrCurrPath))
	$tCurrPath:=$tCurrPath+<>arrCurrPath{$i}
End for 

$0:=Replace string:C233($tCurrPath;"//";"/")