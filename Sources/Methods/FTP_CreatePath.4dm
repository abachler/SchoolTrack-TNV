//%attributes = {}
  //FTP_CreatePath

$ftpConnectionID:=$1
$path:=$2
$0:=0
If ($path[[Length:C16($path)]]="/")
	$path:=Substring:C12($path;1;Length:C16($path)-1)
End if 
$dirs:=ST_CountWords ($path;0;"/")
$workingpath:=$path
For ($i;2;$dirs)
	$workingpath:=ST_LeftWords ($path;$i;"/")
	$err:=FTP_ChangeDir ($ftpConnectionID;$workingpath)
	If ($err#0)
		$err:=FTP_MakeDir ($ftpConnectionID;$workingpath)
		If ($err#0)
			$0:=$err
			$i:=$dirs+1
		End if 
	End if 
	$workingpath:=$path
End for 