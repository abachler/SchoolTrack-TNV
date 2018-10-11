//%attributes = {}
  //SYS_NormalizePath

C_LONGINT:C283($p;$m)
C_LONGINT:C283($s)
_O_PLATFORM PROPERTIES:C365($p;$s;$m)
If ($p=3)
	$0:=$1[[1]]+":"+Replace string:C233(Substring:C12($1;3);":";"\\")
Else 
	$0:=Replace string:C233($1;"\\";":")
End if 
