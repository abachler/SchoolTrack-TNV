//%attributes = {}
  //SYS_GetFileSize

C_TEXT:C284($1;$path)

_O_PLATFORM PROPERTIES:C365($platForm)

$path:=$1
If (Count parameters:C259=2)
	Case of 
		: ($platForm=Windows:K25:3)
			$0:=Get document size:C479($path)
		Else 
			$Resource:=Get document size:C479($path;*)
			$Data:=Get document size:C479($path)
			$size:=$Resource+$Data
	End case 
Else 
	$size:=Get document size:C479($path)
End if 
$0:=$size
