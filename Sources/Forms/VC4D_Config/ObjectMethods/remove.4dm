  // VC4D_Config.add()
  //
  //
  // creado por: Alberto Bachler Klein: 05-02-16, 10:44:32
  // -----------------------------------------------------------
C_POINTER:C301($y_alias;$y_namespace;$y_password;$y_url;$y_userName;$y_webserviceName)

$y_alias:=OBJECT Get pointer:C1124(Object named:K67:5;"aliasServidor")
$y_url:=OBJECT Get pointer:C1124(Object named:K67:5;"url")
$y_webserviceName:=OBJECT Get pointer:C1124(Object named:K67:5;"webServiceName")
$y_namespace:=OBJECT Get pointer:C1124(Object named:K67:5;"namespace")
$y_userName:=OBJECT Get pointer:C1124(Object named:K67:5;"username")
$y_password:=OBJECT Get pointer:C1124(Object named:K67:5;"password")
$y_status:=OBJECT Get pointer:C1124(Object named:K67:5;"statusServer")

$l_fila:=$y_alias->
If ($l_fila>0)
	DELETE FROM ARRAY:C228($y_alias->;$l_fila)
	DELETE FROM ARRAY:C228($y_url->;$l_fila)
	DELETE FROM ARRAY:C228($y_webserviceName->;$l_fila)
	DELETE FROM ARRAY:C228($y_namespace->;$l_fila)
	DELETE FROM ARRAY:C228($y_userName->;$l_fila)
	DELETE FROM ARRAY:C228($y_password->;$l_fila)
	DELETE FROM ARRAY:C228($y_Status->;$l_fila)
End if 
