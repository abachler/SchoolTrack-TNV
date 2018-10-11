//%attributes = {}
  //DASHwa_RespuestaError

C_REAL:C285($1;$r_idError)
C_BOOLEAN:C305($b_conFormato;$2)

C_TEXT:C284($0;$json;$t_principal;$t_err;$node;$t_descripcion)
C_BOOLEAN:C305($b_conFormato)

$r_idError:=$1
If (Count parameters:C259>=2)
	$b_conFormato:=$2
End if 

Case of 
	: ($r_idError=0)
		$t_descripcion:="ok."
		
	: ($r_idError=-1)
		$t_descripcion:="Error al obtener los parámetros para el servicio."
		
	: ($r_idError=-2)
		$t_descripcion:="Autenticación rechazada."
		
	: ($r_idError=-3)
		$t_descripcion:="Página no encontrada."
		
	: ($r_idError=-4)
		$t_descripcion:="Parámetros no válidos."
		
	Else 
		$t_descripcion:="Código "+String:C10($r_idError)+" no clasificado."
		
End case 

C_OBJECT:C1216($ob;$ob_contenido)
OB SET:C1220($ob_contenido;"codigo";$r_idError)
OB SET:C1220($ob_contenido;"descripcion";$t_descripcion)
OB SET:C1220($ob;"estado";$ob_contenido)
If ($b_conFormato)
	$json:=JSON Stringify:C1217($ob;*)
Else 
	$json:=JSON Stringify:C1217($ob)
End if 

$0:=$json