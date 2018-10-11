//%attributes = {}
  //NV_SetValueInTextArray

  //`xShell, Alberto Bachler
  //Metodo: NV_SetValueInTextArray
  //Por abachler
  //Creada el 26/11/2005, 11:15:20
  //Modificaciones:
If ("DESCRIPCION"="")
	  // Establece el valor de un item nombrado en el arreglo que contiene los pares nombre=valor
	  // $1: PUNTERO, puntero sobre el arreglo que contiene los pares de valores nombrados
	  // $2: TEXTO, nombre delvalor buscado
	  // $3: TEXTO, valor a establecer
	  // $4: TEXTO, separador - opcional, por defecto el signo igual a (=)
	  // => indice del elemento establecido
	
	  // NV_SetValueInTextArray(arrayPointer;nombre;valor{;separador}
End if 

  //****DECLARACIONES****
C_POINTER:C301($1;$textarraypointer)
C_TEXT:C284($2;$3;$4;$name;$value)
C_LONGINT:C283($0)

  //****INICIALIZACIONES****
$textArrayPointer:=$1
$name:=$2
$value:=$3
$separator:="="
If (Count parameters:C259=4)
	$separator:=$4
End if 

  //****CUERPO****
$el:=Find in array:C230($textArrayPointer->;$name+$separator+"@")
If ($el<0)
	AT_Insert (0;1;$textArrayPointer)
	$el:=Size of array:C274($textArrayPointer->)
End if 
$textArrayPointer->{$el}:=$name+$separator+$value


  //****LIMPIEZA****
$0:=$el



