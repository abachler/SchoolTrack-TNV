//%attributes = {}
  // VC4D_Setup()
  //
  //
  // creado por: Alberto Bachler Klein: 14-02-16, 17:37:38
  // -----------------------------------------------------------
C_LONGINT:C283($l_windowRef)
C_POINTER:C301($y_alias;$y_namespace;$y_password;$y_servidorSeleccionado;$y_status;$y_url_lista;$y_userName;$y_webserviceName)
C_TEXT:C284($t_alias;$t_namespace;$t_password;$t_url;$t_username;$t_webserviceName)
C_OBJECT:C1216($ob_config)

ARRAY OBJECT:C1221($ao_servers;0)



$y_alias:=OBJECT Get pointer:C1124(Object named:K67:5;"aliasServidor_lista")
$y_url_lista:=OBJECT Get pointer:C1124(Object named:K67:5;"url_lista")
$y_webserviceName:=OBJECT Get pointer:C1124(Object named:K67:5;"webServiceName_lista")
$y_namespace:=OBJECT Get pointer:C1124(Object named:K67:5;"namespace_lista")
$y_userName:=OBJECT Get pointer:C1124(Object named:K67:5;"username_lista")
$y_password:=OBJECT Get pointer:C1124(Object named:K67:5;"password_lista")
$y_status:=OBJECT Get pointer:C1124(Object named:K67:5;"statusServer_lista")
$y_servidorSeleccionado:=OBJECT Get pointer:C1124(Object named:K67:5;"servidorSeleccionado")
$l_windowRef:=Open form window:C675("VC4D_Config";Plain form window:K39:10;Horizontally centered:K39:1;Vertically centered:K39:4)


DIALOG:C40("VC4D_Config")
CLOSE WINDOW:C154

AT_Initialize ($y_alias;$y_url_lista;$y_webserviceName;$y_namespace;$y_userName;$y_password;$y_status)
$ob_config:=VC4D_ReadConfigFile 
If (Not:C34(OB Is empty:C1297($ob_config)))
	OB GET ARRAY:C1229($ob_config;"servers";$ao_servers)
	For ($i;1;Size of array:C274($ao_servers))
		$t_alias:=OB Get:C1224($ao_servers{$i};"alias")
		$t_url:=OB Get:C1224($ao_servers{$i};"url")
		$t_webserviceName:=OB Get:C1224($ao_servers{$i};"webservice_name")
		$t_namespace:=OB Get:C1224($ao_servers{$i};"namespace")
		$t_username:=OB Get:C1224($ao_servers{$i};"username")
		$t_password:=OB Get:C1224($ao_servers{$i};"password")
		APPEND TO ARRAY:C911($y_alias->;$t_alias)
		APPEND TO ARRAY:C911($y_url_lista->;$t_url)
		APPEND TO ARRAY:C911($y_webserviceName->;$t_webserviceName)
		APPEND TO ARRAY:C911($y_namespace->;$t_namespace)
		APPEND TO ARRAY:C911($y_userName->;$t_username)
		APPEND TO ARRAY:C911($y_password->;$t_password)
		APPEND TO ARRAY:C911($y_status->;VC4D_CheckServerConnection ($t_username;$t_password;$t_url;$t_webserviceName;$t_namespace))
	End for 
End if 