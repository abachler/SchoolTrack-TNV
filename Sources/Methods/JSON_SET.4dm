//%attributes = {}
  // JSON_Set(refObjeto:Y; valor:Y; nombrePropiedad)
  // agrega al objeto o referencia JSON el elemento pasado en nombrePropiedad
  //
  // creado por: Alberto Bachler Klein: 24-11-15, 12:02:00
  // -----------------------------------------------------------
C_POINTER:C301($2)
C_TEXT:C284($3)
C_TEXT:C284($4)

C_POINTER:C301($y_valor)
C_TEXT:C284($t_nombrePropiedad;$t_opcion)

$y_valor:=$2
$t_nombrePropiedad:=$3

If (Count parameters:C259=4)
	$t_opcion:=$4
End if 

If (Application version:C493>="15@")
	C_OBJECT:C1216($1)
	C_OBJECT:C1216($ob_Objeto)
	$ob_Objeto:=$1
	$ob_Objeto:=OB_SET ($ob_Objeto;$y_valor;$t_nombrePropiedad;$t_opcion)
Else 
	  //C_TEXT($1)
	  //C_TEXT($t_refJson)
	  //$t_refJson:=$1
	  //JSON_AgregaElemento ($t_refJson;$y_Valor;$t_nombrePropiedad)
End if 