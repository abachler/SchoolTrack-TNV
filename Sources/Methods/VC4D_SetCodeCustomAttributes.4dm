//%attributes = {}
  // VC4D_SetCodeCustomAttributes()
  // 
  //
  // creado por: Alberto Bachler Klein: 15-02-16, 11:30:40
  // -----------------------------------------------------------


C_DATE:C307($d_fecha)
C_TIME:C306($h_hora)
C_TEXT:C284($t_code;$t_codigo;$t_metodoOnErr;$t_ruta;$t_usuario)
C_OBJECT:C1216($ob_attributes)

ARRAY TEXT:C222($at_lineas;0)

$t_ruta:=$1

If ($t_ruta#Current method name:C684)
	DELAY PROCESS:C323(Current process:C322;5)
	METHOD GET MODIFICATION DATE:C1170($t_ruta;$d_fecha;$h_hora;*)
	METHOD GET CODE:C1190($t_ruta;$t_code;*)
	AT_Text2Array (->$at_lineas;$t_code;"\r")
	$l_elemento:=Find in array:C230($at_lineas;"//%XS_custom_attributes = ")
	If ($l_elemento<0)
		INSERT IN ARRAY:C227($at_lineas;2;1)
		$l_elemento:=0
	End if 
	
	$t_jsonAtributos:=$at_lineas{$l_elemento}
	$t_jsonAtributos:=Replace string:C233($t_jsonAtributos;"//%XS_custom_attributes = ";"")
	If ($t_jsonAtributos="{@}")
		$ob_attributes:=JSON Parse:C1218($t_jsonAtributos)
	End if 
	OB SET:C1220($ob_attributes;"XS_autor";<>tUSR_CurrentUser)
	OB SET:C1220($ob_attributes;"XS_ultimaModificacion";String:C10($d_fecha;ISO date:K1:8;$h_hora))
	$at_lineas{2}:="//%XS_custom_attributes = "+JSON Stringify:C1217($ob_attributes)
	$t_code:=AT_array2text (->$at_lineas;"\r")
	
	$t_metodoOnErr:=Method called on error:C704
	METHOD SET CODE:C1194($t_ruta;$t_code;*)
End if 
