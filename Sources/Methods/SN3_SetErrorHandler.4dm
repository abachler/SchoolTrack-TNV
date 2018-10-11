//%attributes = {}
  //SN3_SetErrorHandler

$accion:=$1
If (Count parameters:C259=2)
	$currentErrorHandler:=$2
Else 
	$currentErrorHandler:=""
End if 

Error:=0

Case of 
	: ($accion="set")
		$currentErrorHandler:=Method called on error:C704
		ON ERR CALL:C155("SN3_ErrorsCallBack")
		$0:=$currentErrorHandler
	: ($accion="clear")
		ON ERR CALL:C155($currentErrorHandler)
End case 
