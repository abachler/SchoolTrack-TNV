//%attributes = {}
  //XDOC_OpenAttachedDoc

$recNum:=$1
If (Count parameters:C259=2)
	$selectApp:=$2
Else 
	$selectApp:=False:C215
End if 

_O_PLATFORM PROPERTIES:C365($platform)

READ ONLY:C145([xShell_Documents:91])
GOTO RECORD:C242([xShell_Documents:91];$recNum)
If ([xShell_Documents:91]RefType:10="URL")
	SYS_OpenExternalDocument ([xShell_Documents:91]URL:11)
Else 
	$extension:=[xShell_Documents:91]DocumentType:5
	If ($extension#"")
		$fileName:=String:C10([xShell_Documents:91]DocID:9)+"."+$extension
	Else 
		$fileName:=String:C10([xShell_Documents:91]DocID:9)
	End if 
	$serverFolder:=<>vtXS_CountryCode+"."+<>gRolBD+"."+"DocsPlan"
	$filepath:=SYS_RetrieveFile_v11 ($serverFolder;$fileName)
	SYS_OpenExternalDocument ($filepath)
End if 