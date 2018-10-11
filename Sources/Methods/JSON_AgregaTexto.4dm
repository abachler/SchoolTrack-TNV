//%attributes = {}
  // Json_AgregaTexto()
  // Por: Alberto Bachler K.: 17-02-15, 12:17:37
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_OBJECT:C1216($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_OBJECT:C1216($ob_objeto)
C_TEXT:C284($t_nombreElemento;$t_refNodo;$t_valorElemento)


If (False:C215)
	  //C_TEXT(JSON_AgregaTexto ;$1)
	C_TEXT:C284(JSON_AgregaTexto ;$2)
	C_TEXT:C284(JSON_AgregaTexto ;$3)
End if 

  //$t_refNodo:=$1
$ob_objeto:=$1
$t_valorElemento:=$2
$t_nombreElemento:=$3

  //JSON Append text ($t_refNodo;$t_nombreElemento;$t_valorElemento)
OB_SET ($ob_objeto;->$t_valorElemento;$t_nombreElemento)
