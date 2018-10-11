  // VC4D_Config.in_ok()
  //
  //
  // creado por: Alberto Bachler Klein: 05-02-16, 18:26:32
  // -----------------------------------------------------------
C_BOOLEAN:C305($b_inArray)
C_LONGINT:C283($l_fin;$l_inicio)
C_POINTER:C301($y_alias;$y_namespace;$y_password;$y_status;$y_url;$y_userName;$y_webserviceName)
C_TEXT:C284($t_alias;$t_namespace;$t_password;$t_respuesta;$t_url;$t_username;$t_webserviceName)

ARRAY TEXT:C222($at_alias;0)
ARRAY TEXT:C222($at_urls;0)

$t_alias:=(OBJECT Get pointer:C1124(Object named:K67:5;"in_aliasServidor"))->
$t_url:=(OBJECT Get pointer:C1124(Object named:K67:5;"in_url"))->
$t_webserviceName:=(OBJECT Get pointer:C1124(Object named:K67:5;"in_webServiceName"))->
$t_namespace:=(OBJECT Get pointer:C1124(Object named:K67:5;"in_namespace"))->
$t_username:=(OBJECT Get pointer:C1124(Object named:K67:5;"in_username"))->
$t_password:=(OBJECT Get pointer:C1124(Object named:K67:5;"in_password"))->

$y_alias:=OBJECT Get pointer:C1124(Object named:K67:5;"aliasServidor")
$y_url:=OBJECT Get pointer:C1124(Object named:K67:5;"url")
$y_webserviceName:=OBJECT Get pointer:C1124(Object named:K67:5;"webServiceName")
$y_namespace:=OBJECT Get pointer:C1124(Object named:K67:5;"namespace")
$y_userName:=OBJECT Get pointer:C1124(Object named:K67:5;"username")
$y_password:=OBJECT Get pointer:C1124(Object named:K67:5;"password")
$y_status:=OBJECT Get pointer:C1124(Object named:K67:5;"statusServer")

$t_respuesta:=VC4D_CheckServerConnection ($t_username;$t_password;$t_url;$t_webserviceName;$t_namespace)
Case of 
	: ($t_respuesta="Disponible")
		OK:=1
	: ($t_respuesta="Sin Conexión")
		CONFIRM:C162("La conexión con el servidor no está disponible";"Añadir de todos modos";"Cancelar")
	: ($t_respuesta="Error login")
		CONFIRM:C162("Nombre de usuario o contraseña incorrecta";"Añadir de todos modos";"Cancelar")
End case 


If (OK=1)
	COPY ARRAY:C226($y_alias->;$at_alias)
	SORT ARRAY:C229($at_alias;>)
	$b_inArray:=Find in sorted array:C1333($at_alias;$t_alias;>;$l_inicio;$l_fin)
	Case of 
		: (Not:C34($b_inArray))  // la url no está registrada
			APPEND TO ARRAY:C911($y_alias->;$t_alias)
			APPEND TO ARRAY:C911($y_url->;$t_url)
			APPEND TO ARRAY:C911($y_webserviceName->;$t_webserviceName)
			APPEND TO ARRAY:C911($y_namespace->;$t_namespace)
			APPEND TO ARRAY:C911($y_userName->;$t_username)
			APPEND TO ARRAY:C911($y_password->;$t_password)
			APPEND TO ARRAY:C911($y_status->;$t_respuesta)
			
		: ($l_inicio=$l_fin)
			$y_alias->{$l_inicio}:=$t_alias
			$y_url->{$l_inicio}:=$t_url
			$y_webserviceName->{$l_inicio}:=$t_webserviceName
			$y_namespace->{$l_inicio}:=$t_namespace
			$y_userName->{$l_inicio}:=$t_username
			$y_password->{$l_inicio}:=$t_password
			$y_status->{$l_inicio}:=$t_respuesta
		Else 
			BEEP:C151
	End case 
End if 




FORM GOTO PAGE:C247(1)