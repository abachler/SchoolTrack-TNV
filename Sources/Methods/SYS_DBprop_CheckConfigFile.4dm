//%attributes = {}
  // SYS_DBprop_CheckConfigFile()
  //
  //
  // creado por: Alberto Bachler Klein: 18-03-16, 18:48:30
  // -----------------------------------------------------------
C_LONGINT:C283($l_stampActual)
C_TEXT:C284($t_metodoOnERR;$t_pathCurrentDBSettings;$t_pathDefaultSettings;$t_refElemento;$t_rutaElemento;$t_rutaPropiedadesXML;$t_uuidDB;$t_valor;$t_XMLrefPropiedades)

$t_uuidDB:=$1


  // verifico el documento actual
  // activo la gestion de errores para asegurarme de que todos los elementos y atributos de información necesarios estén incluidos en el xml
$t_rutaPropiedadesXML:=SYS_GetServer_4DFolder (Database folder:K5:14)+"Preferences"+SYS_FolderDelimiterOnServer +"settings.4DSettings"
If (Test path name:C476($t_rutaPropiedadesXML)=Is a document:K24:1)
	error:=0
	$t_metodoOnERR:=Method called on error:C704
	ON ERR CALL:C155("ERR_GenericOnError")
	
	$t_XMLrefPropiedades:=DOM Parse XML source:C719($t_rutaPropiedadesXML)
	
	$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;"preferences")
	DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"stamp";$l_stampActual)
	
	$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;"preferences/schooltrack/uuid_db")
	DOM GET XML ELEMENT VALUE:C731($t_refElemento;$t_valor)
	$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;"preferences/schooltrack/machine_name")
	DOM GET XML ELEMENT VALUE:C731($t_refElemento;$t_valor)
	$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;"preferences/schooltrack/logMemory_Delay")
	DOM GET XML ELEMENT VALUE:C731($t_refElemento;$t_valor)
	$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;"preferences/schooltrack/logMemory_active")
	DOM GET XML ELEMENT VALUE:C731($t_refElemento;$t_valor)
	
	  // caché
	$t_rutaElemento:="preferences/com.4d/database/cache"
	$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;$t_rutaElemento)
	DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"size_reserved";$t_Valor)
	DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"percentage";$t_Valor)
	DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"size_minimum";$t_Valor)
	DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"size_maximum";$t_Valor)
	DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"flush_buffer_delay";$t_Valor)
	
	$t_rutaElemento:="preferences/com.4d/server/network/options"
	$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;$t_rutaElemento)
	DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"publication_name";$t_Valor)
	DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"publication_port";$t_Valor)
	
	  // tiemeout conexiones clientes
	$t_rutaElemento:="preferences/com.4d/server/network/client_server"
	$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;$t_rutaElemento)
	DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"connections_timeout";$t_Valor)
	
	  // web
	$t_rutaElemento:="preferences/com.4d/web/standalone_server/configuration"
	$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;$t_rutaElemento)
	DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"publish_at_startup";$t_Valor)
	DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"ip_address";$t_Valor)
	DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"port_number";$t_Valor)
	DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"allow_ssl";$t_Valor)
	DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"https_port_number";$t_Valor)
	$t_rutaElemento:="preferences/com.4d/web/standalone_server/options/web_processes"
	$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;$t_rutaElemento)
	DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"max_concurrent";$t_Valor)
	DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"timeout_for_inactives";$t_Valor)
	$t_rutaElemento:="preferences/com.4d/web/standalone_server/options/keep_alive"
	$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;$t_rutaElemento)
	DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"with_keep_alive";$t_Valor)
	DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"requests_number";$t_Valor)
	DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"timeout";$t_Valor)
	
	$t_rutaElemento:="preferences/com.4d/web/standalone_server/options/cache"
	$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;$t_rutaElemento)
	DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"cache_max_size";$t_Valor)
	DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"use_4d_web_cache";$t_Valor)
	
	$t_rutaElemento:="preferences/com.4d/web/standalone_server/log"
	$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;$t_rutaElemento)
	DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"format";$t_Valor)
	DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"tokens";$t_Valor)
	
	DOM CLOSE XML:C722($t_XMLrefPropiedades)
	ON ERR CALL:C155($t_metodoOnERR)
Else 
	error:=-15001
End if 

  // =================================================================



  // si hay elemento o atributos faltantes la variable error será distinta de 0
  // necesitamos restaurar el respaldo o, si no existe, restablecer la configuración por defecto
If (error#0)
	  // determino la ruta del último respaldo de la configuración
	If (Util_isValidUUID ($t_uuidDB))
		$t_pathCurrentDBSettings:=SYS_GetServerProperty (XS_StructureFolder)+"Preferences"+Folder separator:K24:12+"settings{"+$t_uuidDB+"}.xml"
	End if 
	  // determino  la ruta del archivo de configuración por defecto
	$t_pathDefaultSettings:=SYS_GetServerProperty (XS_StructureFolder)+"Config"+Folder separator:K24:12+"dbSettings_default.xml"
	
	Case of 
		: (Test path name:C476($t_pathCurrentDBSettings)>Is a document:K24:1)
			  // si existe un respaldo de la última configuración utilizada lo utilizo
			  // [NOTA]
			  // si producto de una actualización necesitamos restablecer la configuración por defecto
			  // hay que tomar la precaución de eliminar este respaldo
			If (Test path name:C476($t_rutaPropiedadesXML)=Is a document:K24:1)
				DELETE DOCUMENT:C159($t_rutaPropiedadesXML)
			End if 
			COPY DOCUMENT:C541($t_pathCurrentDBSettings;$t_rutaPropiedadesXML)
			
		: (Test path name:C476($t_pathDefaultSettings)=Is a document:K24:1)
			  // si no hay respaldo reestablezco la configuración por defecto
			If (Test path name:C476($t_rutaPropiedadesXML)=Is a document:K24:1)
				DELETE DOCUMENT:C159($t_rutaPropiedadesXML)
			End if 
			COPY DOCUMENT:C541($t_pathDefaultSettings;$t_rutaPropiedadesXML)
		Else 
			
	End case 
	error:=0
End if 


