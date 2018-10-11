//%attributes = {}
  //CTRY_CL_GetShortName

_O_C_STRING:C293(80;$0;$1;$2;$3;$nombres;$apellidoPaterno;$apellidoMaterno)
$0:=""
$nombres:=$1
$apellidoPaterno:=$2
$apellidoMaterno:=$3

Case of 
	: (($nombres#"") & ($apellidoPaterno#"") & ($apellidoMaterno#""))
		$0:=Substring:C12($nombres+" ";1;Position:C15(" ";$nombres+" ")-1)+" "+$apellidoPaterno+" "+$apellidoMaterno[[1]]+"."
	: (($nombres="") & ($apellidoPaterno#"") & ($apellidoMaterno#""))
		$0:=$apellidoPaterno+" "+$apellidoMaterno[[1]]+"."
	: (($nombres#"") & ($apellidoPaterno#"") & ($apellidoMaterno=""))
		$0:=Substring:C12($1+" ";1;Position:C15(" ";$nombres+" ")-1)+" "+$apellidoPaterno+" "
	: ($apellidoPaterno="")
		$0:=""
End case 

