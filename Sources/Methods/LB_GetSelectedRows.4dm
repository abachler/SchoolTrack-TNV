//%attributes = {}
  // Método: LB_GetSelectedRows
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha y hora: 23/01/11, 11:18:07
  // ----------------------------------------------------
  // Descripción
  // Retorna el número de la primera fila seleccionada en el list box 
  // y opcionalmente los números filas seleccionadas en un arreglo longint
  //
  // Parámetros
  // $1: puntero sobre listbox (arreglo booleano)
  // $2: puntero sobre arreglo longint en el que se retornan las lineas seleccionadas
  // 
  // Sintáxis
  // LB_GetSelectedRows(->listBox;->ArrayLong)
  // ----------------------------------------------------


C_POINTER:C301($listBox;$1)
C_POINTER:C301($returnArray;$2)
C_LONGINT:C283($firstSelected;$0)

$listBox:=$1
$firstSelected:=Find in array:C230($listBox->;True:C214)

If (Count parameters:C259=2)
	$returnArray:=$2
	AT_Initialize ($returnArray)
	For ($i;1;Size of array:C274($listBox->))
		If ($listBox->{$i})
			APPEND TO ARRAY:C911($returnArray->;$i)
		End if 
	End for 
End if 

$0:=$firstSelected



