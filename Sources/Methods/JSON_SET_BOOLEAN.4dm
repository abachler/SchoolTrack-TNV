//%attributes = {}
  // JSON_SET_BOOLEAN()
  // 
  //
  // creado por: Alberto Bachler Klein: 26-11-15, 19:13:11
  // -----------------------------------------------------------

C_BOOLEAN:C305($2)
C_TEXT:C284($3)

C_POINTER:C301($y_RefObjeto)
C_BOOLEAN:C305($b_booleano)
C_TEXT:C284($t_nombrePropiedad)

$b_booleano:=$2
$t_nombrePropiedad:=$3

If (Application version:C493>="15@")
	C_OBJECT:C1216($1)
	C_OBJECT:C1216($ob_objeto)
	$ob_objeto:=$1
	OB_SET ($ob_objeto;->$b_booleano;$t_nombrePropiedad)
Else 
	  //C_TEXT($1)
	  //C_TEXT($t_refJson)
	  //$t_refJson:=$1
	  //JSON_AgregaElemento ($t_refJson;->$r_real;$t_nombrePropiedad)
End if 