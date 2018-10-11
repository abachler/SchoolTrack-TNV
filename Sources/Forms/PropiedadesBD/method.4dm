  // AdministracionServidor()
  // Por: Alberto Bachler K.: 07-09-15, 15:09:21
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BLOB:C604($x_blob)
C_BOOLEAN:C305($b_es64bits)
C_LONGINT:C283($i_macs;$l_buildNumber;$l_Cache;$l_cacheUtilizado;$l_error;$l_idxIpAddress;$l_ipAddress;$l_LogMemoryUsage;$l_maximoCache;$l_MaxUsuarios)
C_LONGINT:C283($l_memoriaDisponible;$l_memoriaFisica_MB;$l_MemoriaLibre;$l_memoriaPorUsuario;$l_memoriaProcesosClientes;$l_MemoriaProcesosWeb;$l_memoriaServidorReservada;$l_MemoriaUtilizada;$l_minimoCache;$l_porcentajeCache)
C_LONGINT:C283($l_reservaSistema)
C_POINTER:C301($y_appVersion;$y_logMemoryUsage;$y_maxProcesosWeb;$y_memAdaptative_T;$y_memFlushDelay_L;$y_memMaximum_L;$y_memMaximumCache_R;$y_memMinimum_L;$y_memMinimumCache_R;$y_memPercentCache_L)
C_POINTER:C301($y_memPercentCache_R;$y_memProcesosUsuario;$y_memProcesosWeb;$y_memReserved_L;$y_memReserved_R;$y_minutosLogMemoria;$y_propiedadesModificadas;$y_publicationName_T;$y_publicationPort_L;$y_Stamp_L)
C_POINTER:C301($y_timeoutCS_T;$y_timeoutRuler_L;$y_webAllowSSL_L;$y_webCacheSize_L;$y_webCurrentIPAddress;$y_webIpAddressList_AT;$y_webLogTokens_T;$y_webLogWebActive;$y_webMaxProcess_L;$y_webMaxRequests_L)
C_POINTER:C301($y_webPortHTTPS_L;$y_webPortTCP_L;$y_webPublishAtStartup_L;$y_webTimeoutInactives_L;$y_webTimeoutInactivesRuler_L;$y_webTimeoutKeepAlive_L;$y_webUse4DCache_L;$y_webUseKeepAlive_L)
C_TEXT:C284($t_;$t_conflictos;$t_ipAddress;$t_LogMemoryUsage;$t_machineName;$t_objectName;$t_OS;$t_refElemento;$t_rutaCarpetaTemporal;$t_rutaElemento)
C_TEXT:C284($t_rutaPropiedadesXML;$t_serverName;$t_titulo;$t_uuidDB;$t_uuidPrefsDB;$t_Valor;$t_version;$t_XMLrefPropiedades)
C_REAL:C285($r_valor)

ARRAY LONGINT:C221($al_ipAddress;0)

$y_Stamp_L:=OBJECT Get pointer:C1124(Object named:K67:5;"stamp")
  //$y_memAdaptative_T:=OBJECT Get pointer(Object named;"memAdaptative")
$y_memReserved_L:=OBJECT Get pointer:C1124(Object named:K67:5;"memReserved")
$y_memPercentCache_L:=OBJECT Get pointer:C1124(Object named:K67:5;"memPercentCache")
$y_memMinimum_L:=OBJECT Get pointer:C1124(Object named:K67:5;"memMinimum")
$y_memMaximum_L:=OBJECT Get pointer:C1124(Object named:K67:5;"memMaximum")
$y_memFlushDelay_L:=OBJECT Get pointer:C1124(Object named:K67:5;"memFlushDelay")
$y_logMemoryUsage:=OBJECT Get pointer:C1124(Object named:K67:5;"logMemory_active")
$y_minutosLogMemoria:=OBJECT Get pointer:C1124(Object named:K67:5;"logMemory_Delay")
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
$y_propiedadesModificadas:=OBJECT Get pointer:C1124(Object named:K67:5;"propiedadesModificadas")
  //$y_propiedadesModificadas->:=0

Case of 
	: (Form event:C388=On Load:K2:1)
		  // obtengo las direcciones IP del servidor y las asigno a la lista desplegable
		AT_Initialize ($y_webIpAddressList_AT)
		SYS_GetServerIPAddresses ($y_webIpAddressList_AT)
		APPEND TO ARRAY:C911($y_webIpAddressList_AT->;"-")
		APPEND TO ARRAY:C911($y_webIpAddressList_AT->;__ ("Todas"))
		
		$t_XMLrefPropiedades:=SYS_DBprop_ParseXML 
		
		
		  // datos Schooltrack
		$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;"preferences/schooltrack/uuid_db")
		DOM GET XML ELEMENT VALUE:C731($t_refElemento;$t_uuidPrefsDB)
		$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;"preferences/schooltrack/machine_name")
		DOM GET XML ELEMENT VALUE:C731($t_refElemento;$t_machineName)
		$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;"preferences/schooltrack/logMemory_Delay")
		DOM GET XML ELEMENT VALUE:C731($t_refElemento;$y_minutosLogMemoria->)
		$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;"preferences/schooltrack/logMemory_active")
		DOM GET XML ELEMENT VALUE:C731($t_refElemento;$l_LogMemoryUsage)
		$y_logMemoryUsage->:=$l_LogMemoryUsage
		$t_rutaElemento:="preferences/schooltrack"
		
		  //$t_refElemento:=DOM Find XML element($t_XMLrefPropiedades;$t_rutaElemento)
		  //DOM GET XML ATTRIBUTE BY NAME($t_refElemento;"machine_name";$t_machineName)
		  //DOM GET XML ATTRIBUTE BY NAME($t_refElemento;"logMemory_active";$t_LogMemoryUsage)
		  //DOM GET XML ATTRIBUTE BY NAME($t_refElemento;"logMemory_Delay";$y_minutosLogMemoria->)
		  //$y_logMemoryUsage->:=Num($t_LogMemoryUsage="true")
		
		  // stamp
		$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;"preferences")
		DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"stamp";$t_Valor)
		$y_Stamp_L->:=Num:C11($t_Valor)
		
		  // caché
		$t_rutaElemento:="preferences/com.4d/database/cache"
		$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;$t_rutaElemento)
		DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"size_reserved";$t_Valor)
		$y_memReserved_L->:=Num:C11($t_Valor)
		DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"percentage";$t_Valor)
		$y_memPercentCache_L->:=Num:C11($t_Valor)
		DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"size_minimum";$t_Valor)
		$y_memMinimum_L->:=Num:C11($t_Valor)
		DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"size_maximum";$t_Valor)
		$y_memMaximum_L->:=Num:C11($t_Valor)
		DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"flush_buffer_delay";$t_Valor)
		$y_memFlushDelay_L->:=Num:C11($t_Valor)
		
		  // cliente servidor
		$t_rutaElemento:="preferences/com.4d/server/network/options"
		$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;$t_rutaElemento)
		DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"publication_name";$t_Valor)
		$y_publicationName_T->:=$t_Valor
		DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"publication_port";$t_Valor)
		$y_publicationPort_L->:=Num:C11($t_Valor)
		  // tiemeout conexiones clientes
		$t_rutaElemento:="preferences/com.4d/server/network/client_server"
		$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;$t_rutaElemento)
		DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"connections_timeout";$t_Valor)
		$y_timeoutCS_T->:=$t_Valor
		$r_valor:=Num:C11($t_Valor)
		
		Case of 
			: ($y_timeoutCS_T->="0")
				$r_valor:=6
			: ($y_timeoutCS_T->="1")
				$r_valor:=1
			: ($y_timeoutCS_T->="5")
				$r_valor:=2
			: ($y_timeoutCS_T->="15")
				$r_valor:=3
			: ($y_timeoutCS_T->="30")
				$r_valor:=4
			: ($y_timeoutCS_T->="60")
				$r_valor:=5
		End case 
		$y_timeoutRuler_L->:=$r_valor
		
		  // web
		$t_rutaElemento:="preferences/com.4d/web/standalone_server/configuration"
		$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;$t_rutaElemento)
		DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"publish_at_startup";$t_Valor)
		$y_webPublishAtStartup_L->:=Num:C11($t_valor="true")
		DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"ip_address";$t_Valor)
		$y_webCurrentIPAddress->:=Num:C11($t_valor)
		If ($t_Valor="0")
			$y_webIpAddressList_AT->:=Size of array:C274($y_webIpAddressList_AT->)
		Else 
			$l_error:=NET_AddrToName (Num:C11($t_Valor);$t_serverName;$t_ipAddress)
			$l_idxIpAddress:=Find in array:C230($y_webIpAddressList_AT->;$t_ipAddress)
			If ($l_idxIpAddress>0)
				$y_webIpAddressList_AT->:=$l_idxIpAddress
			Else 
				$y_webIpAddressList_AT->:=Size of array:C274($y_webIpAddressList_AT->)
			End if 
		End if 
		DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"port_number";$t_Valor)
		$y_webPortTCP_L->:=Num:C11($t_Valor)
		DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"allow_ssl";$t_Valor)
		$y_webAllowSSL_L->:=Num:C11($t_valor="true")
		DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"https_port_number";$t_Valor)
		$y_webPortHTTPS_L->:=Num:C11($t_Valor)
		
		$t_rutaElemento:="preferences/com.4d/web/standalone_server/options/web_processes"
		$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;$t_rutaElemento)
		DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"max_concurrent";$t_Valor)
		$y_webMaxProcess_L->:=Num:C11($t_Valor)
		DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"timeout_for_inactives";$t_Valor)
		$y_webTimeoutInactives_L->:=Num:C11($t_Valor)
		Case of 
			: ($y_webTimeoutInactives_L->=0)
				$y_webTimeoutInactivesRuler_L->:=0
			: ($y_webTimeoutInactives_L->=-1)
				$y_webTimeoutInactivesRuler_L->:=7
			: ($y_webTimeoutInactives_L->=5)
				$y_webTimeoutInactivesRuler_L->:=1
			: ($y_webTimeoutInactives_L->=15)
				$y_webTimeoutInactivesRuler_L->:=2
			: ($y_webTimeoutInactives_L->=30)
				$y_webTimeoutInactivesRuler_L->:=3
			: ($y_webTimeoutInactives_L->=60)
				$y_webTimeoutInactivesRuler_L->:=4
			: ($y_webTimeoutInactives_L->=480)
				$y_webTimeoutInactivesRuler_L->:=5
			: ($y_webTimeoutInactives_L->=1440)
				$y_webTimeoutInactivesRuler_L->:=6
		End case 
		
		
		$t_rutaElemento:="preferences/com.4d/web/standalone_server/options/keep_alive"
		$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;$t_rutaElemento)
		DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"with_keep_alive";$t_Valor)
		$y_webUseKeepAlive_L->:=Num:C11($t_Valor="true")
		DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"requests_number";$t_Valor)
		$y_webMaxRequests_L->:=Num:C11($t_Valor)
		DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"timeout";$t_Valor)
		$y_webTimeoutKeepAlive_L->:=Num:C11($t_Valor)
		
		$t_rutaElemento:="preferences/com.4d/web/standalone_server/options/cache"
		$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;$t_rutaElemento)
		DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"cache_max_size";$t_Valor)
		$y_webCacheSize_L->:=Num:C11($t_Valor)
		DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"use_4d_web_cache";$t_Valor)
		$y_webUse4DCache_L->:=Num:C11($t_Valor="true")
		
		$t_rutaElemento:="preferences/com.4d/web/standalone_server/log"
		$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;$t_rutaElemento)
		DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"format";$t_Valor)
		$y_webLogWebActive->:=Num:C11($t_Valor="3")
		DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"tokens";$t_Valor)
		$y_webLogTokens_T->:=$t_valor
		
		DOM CLOSE XML:C722($t_XMLrefPropiedades)
		
		b1_Mem:=1
		
		If (Application type:C494=4D Remote mode:K5:5)
			OBJECT SET TITLE:C194(*;"OS_Version";"Sistema operativo del servidor: "+SYS_GetServerOS )
		Else 
			OBJECT SET TITLE:C194(*;"OS_Version";"Sistema operativo: "+SYS_GetServerOS )
		End if 
		$t_version:=SYS_GetServerProperty (XS_4DVersion)
		  //$t_version:=Application version($l_buildNumber)+Choose(Version type=64 bit version;" (64-bit)";" (32-bit)")
		  //$t_version:=Substring($t_version;1;2)+"."+Substring($t_version;3;1)
		  //OBJECT SET TITLE(*;"App_version";"Motor de base de datos: 4D "+$t_version+"."+String($l_buildNumber)+(" (64bits)"*Num(Version type ?? 64 bit version)))
		OBJECT SET TITLE:C194(*;"App_version";"Motor de base de datos: 4D "+$t_version)
		
		
		  // Recomendación de ajustes de memoria de acuerdo a los recursos disponibles
		$t_OS:=SYS_GetServerOS 
		SYS_GetServerMemory (->$l_memoriaFisica_MB;->$l_MemoriaUtilizada;->$l_MemoriaLibre;->$l_Cache;->$l_cacheUtilizado)
		(OBJECT Get pointer:C1124(Object named:K67:5;"memTotal"))->:=$l_memoriaFisica_MB
		(OBJECT Get pointer:C1124(Object named:K67:5;"memUtilizada"))->:=$l_MemoriaUtilizada
		(OBJECT Get pointer:C1124(Object named:K67:5;"memCacheTotal"))->:=$l_Cache
		(OBJECT Get pointer:C1124(Object named:K67:5;"memCacheUtilizada"))->:=$l_cacheUtilizado
		
		
		SYS_DBprop_CalculateMemConfig (->$l_reservaSistema;->$l_porcentajeCache;->$l_minimoCache;->$l_maximoCache;->$l_memoriaProcesosClientes;->$l_MemoriaProcesosWeb;->$t_conflictos)
		OBJECT SET TITLE:C194(*;"memReserved_R";String:C10($l_reservaSistema))
		OBJECT SET TITLE:C194(*;"memPercentCache_R";String:C10($l_porcentajeCache))
		OBJECT SET TITLE:C194(*;"memMinimumCache_R";String:C10($l_minimoCache))
		OBJECT SET TITLE:C194(*;"memMaximumCache_R";String:C10($l_maximoCache))
		OBJECT SET TITLE:C194(*;"memFlushDelay_R";String:C10(20))
		OBJECT SET TITLE:C194(*;"memProcesosUsuario";String:C10($l_memoriaProcesosClientes))
		
		$y_maxProcesosWeb:=OBJECT Get pointer:C1124(Object named:K67:5;"webMaxProcess")
		$t_titulo:=OBJECT Get title:C1068(*;"tituloProcesosWeb")
		$t_titulo:=Replace string:C233($t_titulo;"^0";String:C10($y_maxProcesosWeb->))
		OBJECT SET TITLE:C194(*;"tituloProcesosWeb";$t_titulo)
		OBJECT SET TITLE:C194(*;"memProcesosWeb";String:C10($l_MemoriaProcesosWeb))
		
		OBJECT SET TITLE:C194(*;"alerta";$t_conflictos)
		$t_:=OBJECT Get title:C1068(*;"alerta")
		
		OBJECT SET ENABLED:C1123(*;"btnGuardar";False:C215)
		
	: (Form event:C388=On Data Change:K2:15)
		$t_objectName:=OBJECT Get name:C1087(Object with focus:K67:3)
		If (($t_objectName="mem@") | ($t_objectName="cs@") | ($t_objectName="web@"))
			$y_propiedadesModificadas->:=1
			OBJECT SET ENABLED:C1123(*;"btnGuardar";True:C214)
			OBJECT SET FONT STYLE:C166(*;$t_objectName;Bold:K14:2)
		End if 
		
	: (Form event:C388=On After Keystroke:K2:26)
		$t_objectName:=OBJECT Get name:C1087(Object with focus:K67:3)
		Case of 
			: (($t_objectName="mem@") | ($t_objectName="cs@") | ($t_objectName="web@"))
				$y_propiedadesModificadas->:=1
				OBJECT SET ENABLED:C1123(*;"btnGuardar";True:C214)
				OBJECT SET FONT STYLE:C166(*;$t_objectName;Bold:K14:2)
			: ($t_objectName="intervaloLogMemoria")
				OBJECT SET ENABLED:C1123(*;"btnGuardar";True:C214)
		End case 
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
		
	: (Form event:C388=On Unload:K2:2)
		
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 
  //OBJECT SET ENABLED(*;"btnGuardar";$y_propiedadesModificadas->=1)
If (OBJECT Get enabled:C1079(*;"btnGuardar"))  //ASM 20170103
	$y_propiedadesModificadas:=OBJECT Get pointer:C1124(Object named:K67:5;"propiedadesModificadas")
	$y_propiedadesModificadas->:=1
End if 

