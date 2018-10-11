//%attributes = {}
  // JSON_SET_LONG(refObjeto:Y; longint:L; propiedad:T)
  // Añade un elemento de tipo longint a un objeto json usando un objeto 4D o a una referencia Json creada con el plugin oAuth
  //
  // creado por: Alberto Bachler Klein: 24-11-15, 18:42:58
  // -----------------------------------------------------------
C_LONGINT:C283($2)
C_TEXT:C284($3)
C_LONGINT:C283($l_long)
C_TEXT:C284($t_nombrePropiedad)

$l_long:=$2
$t_nombrePropiedad:=$3

If (Application version:C493>="15@")
	C_OBJECT:C1216($1)
	C_OBJECT:C1216($ob_objeto)
	$ob_objeto:=$1
	OB_SET ($ob_objeto;->$l_long;$t_nombrePropiedad)
Else 
	  //C_TEXT($1)
	  //C_TEXT($t_refJson)
	  //$t_refJson:=$1
	  //JSON_AgregaElemento ($t_refJson;->$t_texto;$t_nombrePropiedad)
End if 