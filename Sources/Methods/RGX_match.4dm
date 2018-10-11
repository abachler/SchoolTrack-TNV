//%attributes = {}
  // Método: RGX_match
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 23/12/10, 08:05:42
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_TEXT:C284($1;$text;$2;$pattern)
C_POINTER:C301($yTextArray;$yLongArray;$3;$4)

  // Código principal
$pattern:=$1
$text:=$2
$yTextArray:=$3
$yLongArray:=$4


AT_Initialize ($yTextArray;$yLongArray)

$searchFrom:=1
$vstart:=0
$vlength:=0
$founded:=Match regex:C1019($pattern;$text;$searchFrom;$vstart;$vlength)

While ($founded)
	APPEND TO ARRAY:C911($yLongArray->;$vstart)
	APPEND TO ARRAY:C911($yTextArray->;Substring:C12($text;$vStart;$vlength))
	$searchFrom:=$vstart+$vlength
	$founded:=Match regex:C1019($pattern;$text;$searchFrom;$vstart;$vlength)
End while 
