  // VC4D_Config()
  //
  //
  // creado por: Alberto Bachler Klein: 05-02-16, 10:40:48
  // -----------------------------------------------------------
C_LONGINT:C283($i)
C_POINTER:C301($y_alias;$y_namespace;$y_password;$y_status;$y_url;$y_userName;$y_webserviceName)
C_TEXT:C284($t_alias;$t_namespace;$t_password;$t_url;$t_username;$t_webserviceName)
C_OBJECT:C1216($ob_config)

ARRAY OBJECT:C1221($ao_servers;0)

$y_alias:=OBJECT Get pointer:C1124(Object named:K67:5;"aliasServidor")
$y_url:=OBJECT Get pointer:C1124(Object named:K67:5;"url")
$y_webserviceName:=OBJECT Get pointer:C1124(Object named:K67:5;"webServiceName")
$y_namespace:=OBJECT Get pointer:C1124(Object named:K67:5;"namespace")
$y_userName:=OBJECT Get pointer:C1124(Object named:K67:5;"username")
$y_password:=OBJECT Get pointer:C1124(Object named:K67:5;"password")
$y_status:=OBJECT Get pointer:C1124(Object named:K67:5;"statusServer")

Case of 
	: (Form event:C388=On Load:K2:1)
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
				APPEND TO ARRAY:C911($y_url->;$t_url)
				APPEND TO ARRAY:C911($y_webserviceName->;$t_webserviceName)
				APPEND TO ARRAY:C911($y_namespace->;$t_namespace)
				APPEND TO ARRAY:C911($y_userName->;$t_username)
				APPEND TO ARRAY:C911($y_password->;$t_password)
				
				APPEND TO ARRAY:C911($y_status->;VC4D_CheckServerConnection ($t_username;$t_password;$t_url;$t_webserviceName;$t_namespace))
			End for 
		End if 
		OBJECT SET ENABLED:C1123(*;"remove";False:C215)
		
		
	: (Form event:C388=On Close Box:K2:21)
		$ob_config:=VC4D_ReadConfigFile 
		ARRAY OBJECT:C1221($ao_servers;Size of array:C274($y_alias->))
		For ($i;1;Size of array:C274($ao_servers))
			If (($y_alias->{$i}#"") & ($y_url->{$i}#"") & ($y_webserviceName->{$i}#"") & ($y_namespace->{$i}#"") & ($y_userName->{$i}#"") & ($y_password->{$i}#""))
				OB SET:C1220($ao_servers{$i};"alias";$y_alias->{$i})
				OB SET:C1220($ao_servers{$i};"url";$y_url->{$i})
				OB SET:C1220($ao_servers{$i};"webservice_name";$y_webserviceName->{$i})
				OB SET:C1220($ao_servers{$i};"namespace";$y_namespace->{$i})
				OB SET:C1220($ao_servers{$i};"username";$y_userName->{$i})
				OB SET:C1220($ao_servers{$i};"password";$y_password->{$i})
			End if 
		End for 
		OB SET ARRAY:C1227($ob_config;"servers";$ao_servers)
		VC4D_SaveConfigFile ($ob_config)
		CANCEL:C270
End case 


