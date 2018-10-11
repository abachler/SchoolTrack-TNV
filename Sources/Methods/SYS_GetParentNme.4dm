//%attributes = {}
  //SYS_GetParentNme

C_TEXT:C284($1;$0)
C_LONGINT:C283($i;$platform;$system;$machine)
_O_PLATFORM PROPERTIES:C365($platform;$system;$machine)

If ($1[[Length:C16($1)]]=Folder separator:K24:12)
	$1:=Substring:C12($1;1;Length:C16($1)-1)
End if 

If (($platform=1) | ($platform=2))
	$sep:=":"
Else 
	$sep:="\\"
End if 
For ($i;Length:C16($1);1;-1)
	If ($1[[$i]]=$sep)
		$i:=0
	Else 
		$1:=Substring:C12($1;1;$i-1)
	End if 
End for 
$0:=$1
