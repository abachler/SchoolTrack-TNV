//%attributes = {}
  //NV_SetValueInPairedList

  //`xShell, Alberto Bachler
  //Metodo: NV_SetValueInPairedList
  //Por abachler
  //Creada el 26/11/2005, 12:00:00
  //Modificaciones:
If ("DESCRIPCION"="")
	  // establece el valor de un item nombrado (nombre=valor) en una lista
	  // $1: PUNTERO, lista de pares de valores nombrados
	  // $2: TEXTO, nombre del valor buscado
	  // $3: TEXTO, valor a establecer
	  // $4: TEXTO, separador entre elementos de la lista - opcional, por defecto punto y coma
	  // $5: TEXTO, separador de pares - opcional, por defecto signo igual
	  // => indice del elemento establecido
	
	  // $indice:=NV_SetValueInPairedList(lista de pares;nombrebuscado{;separador de lista{;separador de pares}})
End if 

  //****DECLARACIONES****
C_POINTER:C301($1;$pairedList)
C_TEXT:C284($2;$name;$3;$value;$4;$listseparator;$5;$pairSeparator)

  //****INICIALIZACIONES****
$pairedList:=$1
$name:=$2
$value:=$3
$listSeparator:=";"
$pairSeparator:="="
If (Count parameters:C259=4)
	$listSeparator:=$4
End if 
If (Count parameters:C259=5)
	$pairSeparator:=$5
End if 

  //****CUERPO****
ARRAY TEXT:C222($tempArray;0)
AT_Text2Array (->$tempArray;$pairedList->;$listSeparator)
$index:=NV_SetValueInTextArray (->$tempArray;$name;$value;$pairSeparator)
$pairedList->:=AT_array2text (->$tempArray;$listSeparator)
$0:=$index