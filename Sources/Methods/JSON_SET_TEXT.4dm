//%attributes = {}
  // JSON_SET_TEXT(refObjeto:Y; texto:T; propiedad:T)
  // Añade un elemento de tipo longint a un objeto json usando un objeto 4D o a una referencia Json creada con el plugin oAuth
  //
  // creado por: Alberto Bachler Klein: 24-11-15, 17:39:49
  // -----------------------------------------------------------

C_TEXT:C284($2)
C_TEXT:C284($3)
C_TEXT:C284($t_nombrePropiedad;$t_texto)


$t_texto:=$2
$t_nombrePropiedad:=$3

If (Application version:C493>="15@")
	$ob_objeto:=$1
	OB_SET ($ob_objeto;->$t_texto;$t_nombrePropiedad)
Else 
	  //C_TEXT($1)
	  //C_TEXT($t_refJson)
	  //$t_refJson:=$1
	  //JSON_AgregaElemento ($t_refJson;->$t_texto;$t_nombrePropiedad)
End if 