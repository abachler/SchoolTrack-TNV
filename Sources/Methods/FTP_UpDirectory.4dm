//%attributes = {}
  //FTP_UpDirectory

C_LONGINT:C283($lLastChar)
C_BOOLEAN:C305($0;$Done;$success)

$lLastChar:=Length:C16(vtFTP_CurrentDirectory)
If ($lLastChar>1)
	Repeat 
		If (vtFTP_CurrentDirectory[[$lLastChar]]="/")
			$Done:=True:C214
		Else 
			$lLastChar:=$lLastChar-1
		End if 
	Until (($Done) | ($lLastChar=1))
	Case of 
		: ($lLastChar=1)
			vtFTP_CurrentDirectory:=Delete string:C232(vtFTP_CurrentDirectory;$lLastChar+1;32000)
		: ($lLastChar>1)
			vtFTP_CurrentDirectory:=Delete string:C232(vtFTP_CurrentDirectory;$lLastChar;32000)
	End case 
	$success:=FTP_ChangeDirectory (vlFTP_ConectionID;vtFTP_CurrentDirectory)
	If ($success)
		FTP_SetCurrentDirPath ("";False:C215)
		vtFTP_CurrentDirectory:=FTP_GetCurrentDirPath 
		$0:=$success
	End if 
End if 