//%attributes = {}
  //ACTwa_RespuestaError

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
		$t_descripcion:="Página no encontrada."
		
	: ($r_idError=-2)
		$t_descripcion:="Hay más de un id de Apoderado para los ids de avisos de cobranza."
		
	: ($r_idError=-4)
		$t_descripcion:="El cálculo de la llave no corresponde."
		
	: ($r_idError=-5)
		$t_descripcion:="Mes cerrado."
		
	: ($r_idError=-6)
		$t_descripcion:="Apoderado no encontrado en la base de datos."
		
	: ($r_idError=-7)
		$t_descripcion:="Apoderado no encontrado."
		
	: ($r_idError=-8)
		$t_descripcion:="Fecha cerrada."
		
	: ($r_idError=-9)
		$t_descripcion:="Id recibido con valor 0."
		
	: ($r_idError=-10)
		$t_descripcion:="Fecha recibida con valor 00/00/0000"
		
	: ($r_idError=-11)
		$t_descripcion:="Error al procesar pagos por día."
		
	: ($r_idError=-12)
		$t_descripcion:="Error al enviar resumen por día."
		
	: ($r_idError=-13)
		$t_descripcion:="Llave no corresponde."
		
	: ($r_idError=-14)
		$t_descripcion:="Fechas no válidas."
		
	: ($r_idError=-15)
		$t_descripcion:="Fechas 1 y 2 no válidas."
		
	: ($r_idError=-16)
		$t_descripcion:="Pago duplicado."
		
	: ($r_idError=-17)
		$t_descripcion:="Proceso en ejecución. Intente nuevamente."
		
	Else 
		$t_descripcion:="Código no clasificado."
		
End case 

  //$t_principal:=JSON New 
  //$t_err:=JSON Append node ($t_principal;"estado")
  //$node:=JSON Append real ($t_err;"codigo";$r_idError)
  //$node:=JSON Append text ($t_err;"descripcion";$t_descripcion)
  //If ($b_conFormato)
  //$json:=JSON Export to text ($t_principal;JSON_WITH_WHITE_SPACE)
  //Else 
  //$json:=JSON Export to text ($t_principal;JSON_WITHOUT_WHITE_SPACE)
  //End if 
  //JSON CLOSE ($t_principal)

C_OBJECT:C1216($ob_raiz;$ob_contenido)

OB SET:C1220($ob_contenido;"codigo";$r_idError;"descripcion";$t_descripcion)
OB SET:C1220($ob_raiz;"estado";$ob_contenido)
If ($b_conFormato)
	$json:=JSON Stringify:C1217($ob_raiz;*)
Else 
	$json:=JSON Stringify:C1217($ob_raiz)
End if 


$0:=$json


  //$err:=JSON New 
  //$node:=JSON Append real ($err;"Error";-1)
  //$json:=JSON Export to text ($err;JSON_WITHOUT_WHITE_SPACE)

