//%attributes = {}
C_TEXT:C284($error;$mensaje;$json)

$error:=$1
$mensaje:=$2

If (Count parameters:C259>2)
	$y_tags:=$3
	$y_values:=$4
End if 



C_OBJECT:C1216($ob_raiz;$ob_data)
$ob_raiz:=OB_Create 
OB_SET ($ob_raiz;->$error;"error")
OB_SET ($ob_raiz;->$mensaje;"mensaje")

If (Count parameters:C259>2)
	$ob_data:=OB_Create 
	For ($i;1;Size of array:C274($y_tags->))
		OB_SET ($ob_data;$y_values->{$i};$y_tags->{$i})
	End for 
End if 
OB_SET ($ob_raiz;->$ob_data;"data")
$json:=OB_Object2Json ($ob_raiz)
$0:=$json

