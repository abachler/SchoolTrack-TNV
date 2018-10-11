//%attributes = {}
  //SYS_cleanCrossPlatformFileName

$fullpath:=$1
$fileName:=SYS_Path2FileName ($fullpath)  //
$extension:=_o_Document type:C528($fullPath)
_O_PLATFORM PROPERTIES:C365($platForm)

$fileName:=ST_CleanSpecifiedChars ($fileName;":<>/|(-“”?¿*"+Char:C90(34))

If ($platform=Windows:K25:3)
	$extension:="."+$extension
	$fileName:=Replace string:C233($fileName;$extension;"")
End if 

$fileName:=ST_ClearSpaces ($fileName)

If (Length:C16($fileName)>27)
	$fileName:=ST_Uppercase ($fileName[[1]])+Substring:C12($fileName;2)
	$spacePosition:=Position:C15(" ";$fileName)
	While ($spacePosition>0)
		$s2:=ST_Uppercase ($fileName[[$spaceposition+1]])+Substring:C12($fileName;$spacePosition+2)
		$s1:=Substring:C12($fileName;1;$spacePosition-1)
		$fileName:=$s1+$s2
		$spacePosition:=Position:C15(" ";$fileName)
	End while 
End if 

If (Length:C16($fileName)>27)
	$fileName:=ST_CleanSpecifiedChars ($fileName;"u")
End if 
If (Length:C16($fileName)>27)
	$fileName:=ST_CleanSpecifiedChars ($fileName;"o")
End if 
If (Length:C16($fileName)>27)
	$fileName:=ST_CleanSpecifiedChars ($fileName;"i")
End if 
If (Length:C16($fileName)>27)
	$fileName:=ST_CleanSpecifiedChars ($fileName;"e")
End if 
If (Length:C16($fileName)>27)
	$fileName:=ST_CleanSpecifiedChars ($fileName;"a")
End if 
If (Length:C16($fileName)>27)
	$fileName:=Substring:C12($fileName;1;26)+"˜"
End if 

$0:=$fileName
