//%attributes = {}
  //FTP_UpdateList

If (Count parameters:C259=1)
	$line:=$1
Else 
	$line:=0
End if 

AL_UpdateArrays (xALP_FtpContents;0)
For ($i;Size of array:C274(alFTP_ObjectSize);1;-1)
	Case of 
		: ((atFTP_ObjectNames{$i}=".") | (atFTP_ObjectNames{$i}=".."))
			AT_Delete ($i;1;->atFTP_ObjectNames;->alFTP_ObjectSize;->aiFTP_ObjectKind;->adFTP_ObjectDate)
		: (aiFTP_ObjectKind{$i}=1)
			atFTP_ObjectNames{$i}:="^10001 "+Replace string:C233(atFTP_ObjectNames{$i};"^10001 ";"")
		Else 
			atFTP_ObjectNames{$i}:="^152 "+Replace string:C233(atFTP_ObjectNames{$i};"^152 ";"")
	End case 
End for 
AL_UpdateArrays (xALP_FtpContents;-2)
AL_SetSort (xALP_FtpContents;1)


AL_SetLine (xALP_FtpContents;$line)

$line:=AL_GetLine (xALP_FtpContents)
If ($line>0)
	_O_ENABLE BUTTON:C192(*;"DownloadButton")
	_O_ENABLE BUTTON:C192(*;"RemoveButton")
	_O_ENABLE BUTTON:C192(*;"RenameButton")
Else 
	_O_DISABLE BUTTON:C193(*;"DownloadButton")
	_O_DISABLE BUTTON:C193(*;"RemoveButton")
	_O_DISABLE BUTTON:C193(*;"RenameButton")
End if 



