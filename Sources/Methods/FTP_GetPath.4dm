//%attributes = {}
  //FTP_GetPath

C_TEXT:C284($0;$1;$targetDirPath)
C_LONGINT:C283($lLastChar;$error)
$targetDirPath:=$1
$lLastChar:=Length:C16($targetDirPath)
If ($targetDirPath[[$lLastChar]]="/")
	$targetDirPath:=Delete string:C232($targetDirPath;$lLastChar;1)
End if 
$0:=$targetDirPath