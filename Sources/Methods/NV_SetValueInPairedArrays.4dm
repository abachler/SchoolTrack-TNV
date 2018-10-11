//%attributes = {}
  //NV_SetValueInPairedArrays

  //xShell, Alberto Bachler
  //Metodo: `NV_SetValueInPairedArrays
  //Por abachler
  //Creada el 26/11/2005, 11:34:56
  //Modificaciones:
If ("DESCRIPCION"="")
	  //Establece el valor de un item nombrado desde arreglos pareados (nombre=valor)
	  // $1: PUNTERO, puntero sobre el arreglo texto o string que contiene los nombres de los valores
	  // $2: PUNTERO, puntero sobre el arreglo texto o string que contiene los valores 
	  // $3: TEXTO, nombre delvalor a establecer
	  // $4: TEXTO, valor a establecer
	  // $5: BOOLEANO, opcional (verdadero por defecto); si se omite o es falso no se agrega un par si no existe
	
	  // => indice del elemento establecido
	  // $indice:=NV_SetValueInPairedArrays(arrayPointer;arrayPointer;nombre;valor;insertarSiInexistente)
	
End if 

  //****DECLARACIONES****
C_POINTER:C301($1;$namesArrayPointer;$2;$valuesArrayPointer)
C_TEXT:C284($3;$4;$name;$value)
C_BOOLEAN:C305($5;$insertIfNotFound)
C_LONGINT:C283($0)

  //****INICIALIZACIONES****
$namesArrayPointer:=$1
$valuesArrayPointer:=$2
$name:=$3
$value:=$4
$insertIfNotFound:=True:C214
If (Count parameters:C259=5)
	$insertIfNotFound:=$5
End if 

  //****CUERPO****
$el:=Find in array:C230($namesArrayPointer->;$name)

If (($el<0) & ($insertIfNotFound))
	AT_Insert (0;1;$namesArrayPointer;$valuesArrayPointer)
	$el:=Size of array:C274($namesArrayPointer->)
End if 
If ($el>0)
	$namesArrayPointer->{$el}:=$name
	$valuesArrayPointer->{$el}:=$value
End if 

$0:=$el



  //****LIMPIEZA****