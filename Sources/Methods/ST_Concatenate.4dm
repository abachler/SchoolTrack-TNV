//%attributes = {}
  //ST_Concatenate

C_TEXT:C284($text;$0)
_O_C_STRING:C293(255;$1;$delim)
C_LONGINT:C283($i)

If (False:C215)
	
	  //Parametro $1 corresponde al delimitador que se quiere usar. Si se pasa "" como parametro se usara ";" por defecto.
	  //Los siguientes parametros son punteros sobre campos o variables a concatenar.
	
End if 

If ($1="")
	$delim:=";"
Else 
	$delim:=$1
End if 

$text:=""

For ($i;2;Count parameters:C259)
	$type:=Type:C295(${$i}->)
	Case of 
		: (($type=Is pointer:K8:14) | ($type=Is picture:K8:10))
			ALERT:C41("Type "+String:C10($type)+" is not supported by the st_Concatenate function.")
		: ($type=Is boolean:K8:9)
			$text:=$text+String:C10(Num:C11(${$i}->))+$delim
		: (($type#Is alpha field:K8:1) & ($type#Is string var:K8:2) & ($type#Is text:K8:3))
			$text:=$text+String:C10(${$i}->)+$delim
		: (($type=Is alpha field:K8:1) | ($type=Is string var:K8:2) | ($type=Is text:K8:3))
			$text:=$text+${$i}->+$delim
	End case 
End for 
$0:=$text