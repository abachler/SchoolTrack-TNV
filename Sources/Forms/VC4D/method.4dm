  // VC4D()
  // Por: Alberto Bachler K.: 13-09-14, 16:47:25
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_isSuperUser;$b_localMethod2Send)
C_LONGINT:C283($i;$l_anchoColMetodo;$l_AnchoLista;$l_bottom;$l_height;$l_left;$l_right;$l_top;$l_width)
C_POINTER:C301($y_alias;$y_integrar;$y_listaServidores;$y_namespace;$y_NS;$y_password;$y_status;$y_URL;$y_url_lista;$y_userName)
C_POINTER:C301($y_webserviceName;$y_WSN)
C_TEXT:C284($t_alias;$t_areaProgreso;$t_namespace;$t_nameSpaceIntranet;$t_password;$t_soapActionIntranet;$t_url;$t_URLintranet;$t_username;$t_webserviceName)
C_OBJECT:C1216($ob_config)

ARRAY OBJECT:C1221($ao_servers;0)

$y_userName:=OBJECT Get pointer:C1124(Object named:K67:5;"userName")
$y_password:=OBJECT Get pointer:C1124(Object named:K67:5;"password")
$y_integrar:=OBJECT Get pointer:C1124(Object named:K67:5;"integrar")
$y_servidorSeleccionado:=OBJECT Get pointer:C1124(Object named:K67:5;"servidorSeleccionado")

$y_alias:=OBJECT Get pointer:C1124(Object named:K67:5;"aliasServidor_lista")
$y_url_lista:=OBJECT Get pointer:C1124(Object named:K67:5;"url_lista")
$y_webserviceName:=OBJECT Get pointer:C1124(Object named:K67:5;"webServiceName_lista")
$y_namespace:=OBJECT Get pointer:C1124(Object named:K67:5;"namespace_lista")
$y_userName:=OBJECT Get pointer:C1124(Object named:K67:5;"username_lista")
$y_password:=OBJECT Get pointer:C1124(Object named:K67:5;"password_lista")
$y_status:=OBJECT Get pointer:C1124(Object named:K67:5;"statusServer_lista")

(OBJECT Get pointer:C1124(Object named:K67:5;"universo"))->:=1

Case of 
	: (Form event:C388=On Load:K2:1)
		SET WINDOW TITLE:C213(SYS_GetServerProperty (XS_StructureName))
		vDate:=Current date:C33
		vTime:=?00:00:00?
		$y_URL:=OBJECT Get pointer:C1124(Object named:K67:5;"URL")
		$y_WSN:=OBJECT Get pointer:C1124(Object named:K67:5;"webServiceName")
		$y_NS:=OBJECT Get pointer:C1124(Object named:K67:5;"nameSpace")
		
		
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
		
		AT_Initialize ($y_servidorSeleccionado)
		If (Size of array:C274($y_alias->)>0)
			$l_elemento:=Find in array:C230($y_status->;"Disponible")
			If ($l_elemento>0)
				APPEND TO ARRAY:C911($y_servidorSeleccionado->;$y_alias->{$l_elemento})
				(OBJECT Get pointer:C1124(Object named:K67:5;"url"))->:=$y_url_lista->{$l_elemento}
				(OBJECT Get pointer:C1124(Object named:K67:5;"webServiceName"))->:=$y_webserviceName->{$l_elemento}
				(OBJECT Get pointer:C1124(Object named:K67:5;"namespace"))->:=$y_namespace->{$l_elemento}
				(OBJECT Get pointer:C1124(Object named:K67:5;"userName"))->:=$y_userName->{$l_elemento}
				(OBJECT Get pointer:C1124(Object named:K67:5;"password"))->:=$y_password->{$l_elemento}
			Else 
				(OBJECT Get pointer:C1124(Object named:K67:5;"url"))->:=""
				(OBJECT Get pointer:C1124(Object named:K67:5;"webServiceName"))->:=""
				(OBJECT Get pointer:C1124(Object named:K67:5;"namespace"))->:=""
				(OBJECT Get pointer:C1124(Object named:K67:5;"userName"))->:=""
				(OBJECT Get pointer:C1124(Object named:K67:5;"password"))->:=""
			End if 
			If (Size of array:C274($y_servidorSeleccionado->)>0)
				$y_servidorSeleccionado->:=1
			End if 
		End if 
		
		
		
		If ($y_servidorSeleccionado->>=1)
			(OBJECT Get pointer:C1124(Object named:K67:5;"userName"))->:=USR_GetUserName (USR_GetUserID ;1)
			OBJECT SET FONT:C164(*;"password";"%Password")
			OBJECT SET TITLE:C194(*;"devServerName";OBJECT Get title:C1068(*;"devServerAlias"))
			OBJECT SET TITLE:C194(*;"botonIntegrar";__ ("Integrar en ")+OBJECT Get title:C1068(*;"devServerAlias"))
			OBJECT GET BEST SIZE:C717(*;"botonIntegrar";$l_width;$l_height;300)
			OBJECT GET COORDINATES:C663(*;"botonIntegrar";$l_left;$l_top;$l_right;$l_bottom)
			IT_SetNamedObjectRect ("botonIntegrar";$l_right-$l_width;$l_top;$l_right;$l_bottom)
			
			OBJECT SET ENABLED:C1123(*;"botonBuscar";(OBJECT Get pointer:C1124(Object named:K67:5;"url"))->#"")
			OBJECT SET ENABLED:C1123(*;"exportar";False:C215)
			
			$b_isSuperUser:=USR_IsSuperUser ($y_userName->;$y_password->)
			OBJECT SET ENABLED:C1123(*;"botonIntegrar";((OBJECT Get pointer:C1124(Object named:K67:5;"userName"))->#"") & ((OBJECT Get pointer:C1124(Object named:K67:5;"password"))->#""))
			
			OBJECT SET TITLE:C194(*;"universo";"")
			
		End if 
		
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
		
	: (Form event:C388=On Resize:K2:27)
		$l_anchoColMetodo:=LISTBOX Get column width:C834(*;"nombreObjeto")
		$l_AnchoLista:=IT_Objeto_Ancho ("listboxMetodos")
		LISTBOX SET COLUMN WIDTH:C833(*;"nombreObjeto";$l_AnchoLista-520)
		
	: (Form event:C388=On After Keystroke:K2:26)
		
End case 



