//%attributes = {}
  //ST_Deconcatenate

C_TEXT:C284($text;$0)
_O_C_STRING:C293(255;$1;$delim)
C_LONGINT:C283($i)

If (False:C215)
	
	  //Parametro $1 corresponde al delimitador que se quiere usar. Si se pasa "" como parametro se usara ";" por defecto.
	  //El parametro $2 es una cadena de texto donde los valores a asignar a las variables o campos estan
	  //separadas por el delimitador pasado en $1.
	  //Los siguientes parametros son punteros sobre campos o variables a llenar.
	
End if 

If ($1="")
	$delim:=";"
Else 
	$delim:=$1
End if 

$text:=$2

For ($i;3;Count parameters:C259)
	$type:=Type:C295(${$i}->)
	Case of 
		: (($type=Is pointer:K8:14) | ($type=Is picture:K8:10))
			ALERT:C41("Type "+String:C10($type)+" is not supported by the st_Concatenate function.")
		: ($type=Is boolean:K8:9)
			${$i}->:=Num:C11(Substring:C12($text;1;Position:C15($delim;$text)-1))
			$text:=Substring:C12($text;Position:C15($delim;$text)+1)
		: ($type=Is date:K8:7)
			${$i}->:=Date:C102(Substring:C12($text;1;Position:C15($delim;$text)-1))
			$text:=Substring:C12($text;Position:C15($delim;$text)+1)
		: (($type#Is alpha field:K8:1) & ($type#Is string var:K8:2) & ($type#Is text:K8:3))
			${$i}->:=Num:C11(Substring:C12($text;1;Position:C15($delim;$text)-1))
			$text:=Substring:C12($text;Position:C15($delim;$text)+1)
		: (($type=Is alpha field:K8:1) | ($type=Is string var:K8:2) | ($type=Is text:K8:3))
			${$i}->:=Substring:C12($text;1;Position:C15($delim;$text)-1)
			$text:=Substring:C12($text;Position:C15($delim;$text)+1)
	End case 
End for 