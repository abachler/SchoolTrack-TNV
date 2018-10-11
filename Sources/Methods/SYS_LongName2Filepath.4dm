//%attributes = {}
  //SYS_LongName2Filepath

  // Long name to path name Project Name
  // Long name to path name ( String ) -> String
  // Long name to path name ( Long file name ) -> Path name

_O_C_STRING:C293(255;$1;$0)

C_LONGINT:C283($viLen;$viPos;$viChar)

$viLen:=Length:C16($1)
$viPos:=0
For ($viChar;$viLen;1;-1)
	If ($1[[$viChar]]=Folder separator:K24:12)
		$viPos:=$viChar
		$viChar:=0
	End if 
	
End for 
If ($viPos>0)
	$0:=Substring:C12($1;1;$viPos)
Else 
	$0:=$1
End if 