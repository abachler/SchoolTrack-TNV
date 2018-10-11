//%attributes = {}
  // JSON_SET_REAL(refObjeto:Y; real:R; propiedad:T)
  // Añade un elemento de tipo real a un objeto json usando un objeto 4D o a una referencia Json creada con el plugin oAuth
  //
  // creado por: Alberto Bachler Klein: 24-11-15, 18:39:50
  // -----------------------------------------------------------
C_REAL:C285($2)
C_TEXT:C284($3)

C_POINTER:C301($y_RefObjeto)
C_REAL:C285($r_real)
C_TEXT:C284($t_nombrePropiedad)

$r_real:=$2
$t_nombrePropiedad:=$3

If (Application version:C493>="15@")
	C_OBJECT:C1216($1)
	C_OBJECT:C1216($ob_objeto)
	$ob_objeto:=$1
	OB_SET ($ob_objeto;->$r_real;$t_nombrePropiedad)
Else 
	  //C_TEXT($1)
	  //C_TEXT($t_refJson)
	  //$t_refJson:=$1
	  //JSON_AgregaElemento ($t_refJson;->$r_real;$t_nombrePropiedad)
End if 