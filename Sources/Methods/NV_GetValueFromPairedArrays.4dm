//%attributes = {}
  //NV_GetValueFromPairedArrays

  //xShell, Alberto Bachler
  //Metodo: NV_GetValueFromPairedArrays
  //Por abachler
  //Creada el 26/11/2005, 11:22:56
  //Modificaciones:
If ("DESCRIPCION"="")
	  //Retorna el valor de un item nombrado desde arreglos pareados (nombre=valor)
	  // $1: PUNTERO, puntero sobre el arreglo texto o string que contiene los nombres de los valores
	  // $2: PUNTERO, puntero sobre el arreglo texto o string que contiene los valores 
	  // $3: TEXTO, nombre delvalor buscado
	  // (retorna texto vacio si no encuentra el nombre)
	  // $valor:=NV_GetValueFromPairedArrays(arrayPointer;nombre{;separador})
	
End if 

  //****DECLARACIONES****
C_POINTER:C301($1;$namesArrayPointer;$2;$valuesArrayPointer)
C_TEXT:C284($3;$0;$name;$value)

  //****INICIALIZACIONES****
$namesArrayPointer:=$1
$valuesArrayPointer:=$2
$name:=$3

  //****CUERPO****
$el:=Find in array:C230($namesArrayPointer->;$name)

If ($el>0)
	$value:=$valuesArrayPointer->{$el}
End if 

$0:=$value



  //****LIMPIEZA****