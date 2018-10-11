//%attributes = {}
  //FTP_SetCurrentDirPath

C_TEXT:C284($1;$tCurrPath)
C_BOOLEAN:C305($2;$bIsGoingDown)
$tCurrPath:=$1
$bIsGoingDown:=$2
$vlElem:=Size of array:C274(<>arrCurrPath)
If ($vlElem>0)
	If ($bIsGoingDown)
		If (<>arrCurrPath{$vlElem}="/")
			<>arrCurrPath{$vlElem}:=$tCurrPath
		Else 
			$vlElem:=$vlElem+1
			INSERT IN ARRAY:C227(<>arrCurrPath;$vlElem)
			<>arrCurrPath{$vlElem}:=$tCurrPath
		End if 
	Else 
		If ($vlElem>1)
			DELETE FROM ARRAY:C228(<>arrCurrPath;$vlElem;1)
		Else 
			<>arrCurrPath{$vlElem}:="/"
		End if 
	End if 
End if 