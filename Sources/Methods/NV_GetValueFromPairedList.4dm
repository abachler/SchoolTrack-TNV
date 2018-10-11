//%attributes = {}
  //NV_GetValueFromPairedList

  //`xShell, Alberto Bachler
  //Metodo: NV_GetValueFromPairedList
  //Por abachler
  //Creada el 26/11/2005, 11:47:07
  //Modificaciones:
If ("DESCRIPCION"="")
	  // Retorna el valor de un item nombrado (nombre=valor)
	  // $1: TEXTO, lista de pares de valores nombrados
	  // $2: TEXTO, nombre del valor buscado
	  // $3: TEXTO, separador entre elementos de la lista - opcional, por defecto punto y coma
	  // $4: TEXTO, separador de pares - opcional, por defecto signo igual
	  // (retorna texto vacio si no encuentra el nombre)
	
	  // $valor:=NV_GetValueFromPairedList(lista de pares;nombrebuscado{;separador de lista{;separador de pares}})
End if 

  //****DECLARACIONES****
C_TEXT:C284($1;$stringList;$2;$name;$0;$value;$3;$listseparator;$pairSeparator)

  //****INICIALIZACIONES****
$stringList:=$1
$name:=$2
$listSeparator:=";"
$pairSeparator:="="
If (Count parameters:C259=3)
	$listSeparator:=$3
End if 
If (Count parameters:C259=4)
	$pairSeparator:=$4
End if 

  //****CUERPO****
ARRAY TEXT:C222($tempArray;0)
AT_Text2Array (->$tempArray;$stringList;$listSeparator)
$value:=NV_GetValueFromTextArray (->$tempArray;$name;$pairSeparator)
$0:=$value