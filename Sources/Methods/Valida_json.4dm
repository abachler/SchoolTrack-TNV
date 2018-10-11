//%attributes = {}
  // Valida_json()
  // Por: Alexis Bustamante.: 27-08-14, 16:01:59
  //para controlar error si Json es blanco o no esta correctamente creado.
  //  ---------------------------------------------
  //$1:=Cadena json a Evaluar
  //// $0:=False -> si json es erroneo 
  /// $0:= True -> json correcto
  //  ---------------------------------------------

C_OBJECT:C1216($ob)
C_TEXT:C284($1;$t_json)
$t_json:=$1
EM_ErrorManager ("Install")
EM_ErrorManager ("SetMode";"")
$ob:=JSON Parse:C1218($t_json;Is object:K8:27)
If (vl_ErrorCode=0)
	$0:=True:C214
Else 
	$0:=False:C215
End if 
EM_ErrorManager ("Clear")
