  // AdministracionServidor.Botón()
  // Por: Alberto Bachler K.: 07-09-15, 10:16:46
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BLOB:C604($x_blob)
C_LONGINT:C283($i_macs;$l_error;$l_idxIpAddress;$l_ipAddress;$l_usuariosActuales)
C_POINTER:C301($y_logMemoryUsage;$y_memAdaptative_T;$y_memFlushDelay_L;$y_memMaximum_L;$y_memMinimum_L;$y_memPercentCache_L;$y_memReserved_L;$y_Minutos;$y_propiedadesModificadas;$y_publicationName_T)
C_POINTER:C301($y_publicationPort_L;$y_Stamp_L;$y_timeoutCS_T;$y_timeoutRuler_L;$y_webAllowSSL_L;$y_webCacheSize_L;$y_webCurrentIPAddress;$y_webIpAddress_AT;$y_webIpAddressList_AT;$y_webLogTokens_T)
C_POINTER:C301($y_webLogWebActive;$y_webMaxProcess_L;$y_webMaxRequests_L;$y_webPortHTTPS_L;$y_webPortTCP_L;$y_webPublishAtStartup_L;$y_webTimeoutInactives_L;$y_webTimeoutInactivesRuler_L;$y_webTimeoutKeepAlive_L;$y_webUse4DCache_L)
C_POINTER:C301($y_webUseKeepAlive_L)
C_TEXT:C284($t_desconexion;$t_ipAddress;$t_LogMemoryUsage;$t_mensaje;$t_refElemento;$t_rutaCarpetaTemporal;$t_rutaElemento;$t_rutaPropiedadesXML;$t_serverName;$t_text)
C_TEXT:C284($t_Valor;$t_XMLrefPropiedades)

vt_allowSSL:="false"
vt_autoSesionManagement:="false"
vl_httpsPortNumber:=443
vl_ipAddress:=0
vl_portNumber:=80
vt_publishAtStartup:="true"
vt_reuseContext:="false"
vl_hostId:=0
vl_hostName:="default"
vt_autoVariablesMngt:="false"



$y_propiedadesModificadas:=OBJECT Get pointer:C1124(Object named:K67:5;"propiedadesModificadas")
If ($y_propiedadesModificadas->=1)
	$y_Stamp_L:=OBJECT Get pointer:C1124(Object named:K67:5;"stamp")
	$y_memReserved_L:=OBJECT Get pointer:C1124(Object named:K67:5;"memReserved")
	$y_memPercentCache_L:=OBJECT Get pointer:C1124(Object named:K67:5;"memPercentCache")
	$y_memMinimum_L:=OBJECT Get pointer:C1124(Object named:K67:5;"memMinimum")
	$y_memMaximum_L:=OBJECT Get pointer:C1124(Object named:K67:5;"memMaximum")
	$y_memFlushDelay_L:=OBJECT Get pointer:C1124(Object named:K67:5;"memFlushDelay")
	
	$y_publicationName_T:=OBJECT Get pointer:C1124(Object named:K67:5;"csPublicationName")
	$y_publicationPort_L:=OBJECT Get pointer:C1124(Object named:K67:5;"csPublicationPort")
	$y_timeoutCS_T:=OBJECT Get pointer:C1124(Object named:K67:5;"csTimeout")
	$y_timeoutRuler_L:=OBJECT Get pointer:C1124(Object named:K67:5;"csTimeoutRuler")
	
	$y_webPublishAtStartup_L:=OBJECT Get pointer:C1124(Object named:K67:5;"webPublishAtStartup")
	$y_webIpAddressList_AT:=OBJECT Get pointer:C1124(Object named:K67:5;"webIpAddressList")
	$y_webCurrentIPAddress:=OBJECT Get pointer:C1124(Object named:K67:5;"webCurrentIPAddress")
	$y_webPortTCP_L:=OBJECT Get pointer:C1124(Object named:K67:5;"webPortTCP")
	$y_webAllowSSL_L:=OBJECT Get pointer:C1124(Object named:K67:5;"webAlowSSL")
	$y_webPortHTTPS_L:=OBJECT Get pointer:C1124(Object named:K67:5;"webPortHTTPS")
	$y_webUse4DCache_L:=OBJECT Get pointer:C1124(Object named:K67:5;"webUse4DWebCache")
	$y_webCacheSize_L:=OBJECT Get pointer:C1124(Object named:K67:5;"webCacheSize")
	$y_webMaxProcess_L:=OBJECT Get pointer:C1124(Object named:K67:5;"webMaxProcess")
	$y_webTimeoutInactives_L:=OBJECT Get pointer:C1124(Object named:K67:5;"webTimeoutInactives")
	$y_webTimeoutInactivesRuler_L:=OBJECT Get pointer:C1124(Object named:K67:5;"webTimeoutInactivesRuler")
	$y_webUseKeepAlive_L:=OBJECT Get pointer:C1124(Object named:K67:5;"webUseKeeAlive")
	$y_webMaxRequests_L:=OBJECT Get pointer:C1124(Object named:K67:5;"webMaxKeepAliveRequests")
	$y_webTimeoutKeepAlive_L:=OBJECT Get pointer:C1124(Object named:K67:5;"webTimeoutKeepAlive")
	$y_webLogWebActive:=OBJECT Get pointer:C1124(Object named:K67:5;"webLogWebActive")
	$y_webLogTokens_T:=OBJECT Get pointer:C1124(Object named:K67:5;"webLogTokens")
	$y_logMemoryUsage:=OBJECT Get pointer:C1124(Object named:K67:5;"logMemory_active")
	$y_Minutos:=OBJECT Get pointer:C1124(Object named:K67:5;"logMemory_Delay")
	
	$t_XMLrefPropiedades:=SYS_DBprop_ParseXML 
	
	  // ********** STAMP **********
	$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;"preferences")
	$y_Stamp_L->:=$y_Stamp_L->+1
	DOM SET XML ATTRIBUTE:C866($t_refElemento;"stamp";String:C10($y_Stamp_L->))
	
	  // ********** CACHE **********
	$t_rutaElemento:="preferences/com.4d/database/cache"
	$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;$t_rutaElemento)
	DOM SET XML ATTRIBUTE:C866($t_refElemento;"size_reserved";String:C10($y_memReserved_L->))
	DOM SET XML ATTRIBUTE:C866($t_refElemento;"percentage";String:C10($y_memPercentCache_L->))
	DOM SET XML ATTRIBUTE:C866($t_refElemento;"size_minimum";String:C10($y_memMinimum_L->))
	DOM SET XML ATTRIBUTE:C866($t_refElemento;"size_maximum";String:C10($y_memMaximum_L->))
	DOM SET XML ATTRIBUTE:C866($t_refElemento;"flush_buffer_delay";String:C10($y_memFlushDelay_L->))
	
	  // ********** CLIENTE - SERVIDOR **********
	$t_rutaElemento:="preferences/com.4d/server/network/options"
	$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;$t_rutaElemento)
	DOM SET XML ATTRIBUTE:C866($t_refElemento;"publication_name";$y_PublicationName_T->)
	DOM SET XML ATTRIBUTE:C866($t_refElemento;"publication_port";String:C10($y_publicationPort_L->))
	  // timeout conexiones clientes
	$t_rutaElemento:="preferences/com.4d/server/network/client_server"
	$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;$t_rutaElemento)
	DOM SET XML ATTRIBUTE:C866($t_refElemento;"connections_timeout";String:C10($y_timeoutCS_T->))
	
	  // ********** WEB **********
	  // configuración
	$t_rutaElemento:="preferences/com.4d/web/standalone_server/configuration"
	$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;$t_rutaElemento)
	DOM SET XML ATTRIBUTE:C866($t_refElemento;"publish_at_startup";Choose:C955($y_webPublishAtStartup_L->=1;"true";"false"))
	DOM SET XML ATTRIBUTE:C866($t_refElemento;"ip_address";$y_webCurrentIPAddress->)
	DOM SET XML ATTRIBUTE:C866($t_refElemento;"port_number";String:C10($y_webPortTCP_L->))
	DOM SET XML ATTRIBUTE:C866($t_refElemento;"allow_ssl";Choose:C955($y_webAllowSSL_L->=1;"true";"false"))
	DOM SET XML ATTRIBUTE:C866($t_refElemento;"https_port_number";String:C10($y_webPortHTTPS_L->))
	  // web processes
	$t_rutaElemento:="preferences/com.4d/web/standalone_server/options/web_processes"
	$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;$t_rutaElemento)
	DOM SET XML ATTRIBUTE:C866($t_refElemento;"max_concurrent";String:C10($y_webMaxProcess_L->))
	DOM SET XML ATTRIBUTE:C866($t_refElemento;"timeout_for_inactives";String:C10($y_webTimeoutInactives_L->))
	  // keep alive
	$t_rutaElemento:="preferences/com.4d/web/standalone_server/options/keep_alive"
	$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;$t_rutaElemento)
	DOM SET XML ATTRIBUTE:C866($t_refElemento;"with_keep_alive";Choose:C955($y_webUseKeepAlive_L->=1;"true";"false"))
	DOM SET XML ATTRIBUTE:C866($t_refElemento;"requests_number";String:C10($y_webMaxRequests_L->))
	DOM SET XML ATTRIBUTE:C866($t_refElemento;"timeout";String:C10($y_webTimeoutKeepAlive_L->))
	  // cache web
	$t_rutaElemento:="preferences/com.4d/web/standalone_server/options/cache"
	$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;$t_rutaElemento)
	DOM SET XML ATTRIBUTE:C866($t_refElemento;"cache_max_size";String:C10($y_webCacheSize_L->))
	DOM SET XML ATTRIBUTE:C866($t_refElemento;"use_4d_web_cache";Choose:C955($y_webUse4DCache_L->=1;"true";"false"))
	  // log web
	$t_rutaElemento:="preferences/com.4d/web/standalone_server/log"
	$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;$t_rutaElemento)
	DOM SET XML ATTRIBUTE:C866($t_refElemento;"format";Choose:C955($y_webLogWebActive->=3;"3";"0"))
	DOM SET XML ATTRIBUTE:C866($t_refElemento;"tokens";$y_webLogTokens_T->)
	
	
	$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;"preferences/schooltrack/uuid_db")
	DOM SET XML ELEMENT VALUE:C868($t_refElemento;<>GUUID)
	$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;"preferences/schooltrack/machine_name")
	DOM SET XML ELEMENT VALUE:C868($t_refElemento;Current machine:C483)
	$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;"preferences/schooltrack/logMemory_Delay")
	DOM SET XML ELEMENT VALUE:C868($t_refElemento;$y_Minutos->)
	$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;"preferences/schooltrack/logMemory_active")
	DOM SET XML ELEMENT VALUE:C868($t_refElemento;$y_logMemoryUsage->)
	  //$t_rutaElemento:="preferences/schooltrack"
	  //$t_refElemento:=DOM Find XML element($t_XMLrefPropiedades;$t_rutaElemento)
	  //DOM SET XML ATTRIBUTE($t_refElemento;"uuid_db";<>GUUID)
	  //DOM SET XML ATTRIBUTE($t_refElemento;"machine_name";Current machine)
	  //If ($y_logMemoryUsage->=1)
	  //DOM SET XML ATTRIBUTE($t_refElemento;"logMemory_active";"true")
	  //DOM SET XML ATTRIBUTE($t_refElemento;"logMemory_Delay";$y_Minutos->)
	  //Else 
	  //DOM SET XML ATTRIBUTE($t_refElemento;"logMemory_active";"false")
	  //DOM SET XML ATTRIBUTE($t_refElemento;"logMemory_Delay";0)
	  //End if 
	
	
	SYS_DBprop_SaveXML ($t_XMLrefPropiedades)
	SYS_LogMemoryUsage 
	
	
	If (Application type:C494=4D Remote mode:K5:5)
		$l_usuariosActuales:=Count users:C342-1
		If ($l_usuariosActuales>0)
			$t_mensaje:=__ ("Usted modificó las propiedades de la base de datos.\rLas modificaciones solo serán tomadas en cuenta hasta el reinicio de la aplicación.\r¿Desea reiniciar el servidor ahora?")
			$t_desconexion:=String:C10($l_usuariosActuales)+__ (" usuario(s) serán desconectados ")
			$t_desconexion:=IT_SetTextColor_Name (->$t_desconexion;"red")+__ (" (incluido usted).")
			$t_mensaje:=$t_mensaje+"\r\r"+$t_desconexion
		Else 
			$t_mensaje:=__ ("Usted modificó las propiedades de la base de datos.\rLas modificaciones solo serán tomadas en cuenta hasta el reinicio de la aplicación.\r¿Desea reiniciar el servidor ahora?")
		End if 
		SYS_ReiniciarServidor (True:C214;$t_mensaje;10*60)
	End if 
Else 
	$y_logMemoryUsage:=OBJECT Get pointer:C1124(Object named:K67:5;"logMemory_active")
	$y_Minutos:=OBJECT Get pointer:C1124(Object named:K67:5;"logMemory_Delay")
	$t_XMLrefPropiedades:=SYS_DBprop_ParseXML 
	$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;"preferences/schooltrack/logMemory_Delay")
	DOM SET XML ELEMENT VALUE:C868($t_refElemento;$y_Minutos->)
	$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;"preferences/schooltrack/logMemory_active")
	DOM SET XML ELEMENT VALUE:C868($t_refElemento;$y_logMemoryUsage->)
	SYS_DBprop_SaveXML ($t_XMLrefPropiedades)
	SYS_LogMemoryUsage 
End if 