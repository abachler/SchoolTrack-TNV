//%attributes = {}
  // STWA2_Arreglo_a_json()
  // Por: Alberto Bachler K.: 17-02-15, 11:44:11
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)
C_POINTER:C301($2)
C_TEXT:C284($3)
C_TEXT:C284($4)

C_LONGINT:C283($i)
C_POINTER:C301($y_arreglo)
C_TEXT:C284($t_formato;$t_item;$t_nombreNodo;$t_refNodo;$t_refNodoJson;$t_texto)


If (False:C215)
	C_TEXT:C284(STWA2_Arreglo_a_json ;$1)
	C_POINTER:C301(STWA2_Arreglo_a_json ;$2)
	C_TEXT:C284(STWA2_Arreglo_a_json ;$3)
	C_TEXT:C284(STWA2_Arreglo_a_json ;$4)
End if 

ARRAY TEXT:C222($t_textoArray;0)

$t_refNodoJson:=$1
$y_arreglo:=$2
$t_nombreNodo:=$3
$t_formato:=""
If (Count parameters:C259=4)
	$t_formato:=$4
End if 
If (AT_ArrayHasNonNulValues ($y_arreglo))
	$t_texto:=AT_array2text ($y_arreglo;Char:C90(61111);$t_formato)
	$t_texto:=$t_texto+Char:C90(61111)
	While (Position:C15(Char:C90(61111);$t_texto;*)>0)
		$t_item:=Substring:C12($t_texto;1;Position:C15(Char:C90(61111);$t_texto;*)-1)
		$t_texto:=Substring:C12($t_texto;Position:C15(Char:C90(61111);$t_texto;*)+1)
		  //APPEND TO ARRAY($t_textoArray;$t_item)
		APPEND TO ARRAY:C911($t_textoArray;"\""+$t_item+"\"")
	End while 
Else 
	AT_CopyArrayElements ($y_arreglo;->$t_textoArray)
End if 
  //For ($i;1;Size of array($t_textoArray))
  //$t_textoArray{$i}:=Replace string($t_textoArray{$i};Char(34);"&quot;")
  //End for 
JSON_AgregaElemento ($t_refNodoJson;->$t_textoArray;$t_nombreNodo)
