//%attributes = {"executedOnServer":true}
  // SYS_VerifyDataBaseProperties()
  // Por: Alberto Bachler K.: 05-10-15, 18:29:57
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_actualizarPrefs;<>sys_is64bitOS_B;$b_guardar;$b_respaldarPrefs;$b_ReVerificar;$b_server4D64bits;$b_usarRecomendaciones)
C_LONGINT:C283($l_Cache;$l_cacheUtilizado;$l_FlushDelayPrefs;$l_intervaloLogUsoMemoria;$l_logMemoryActive;$l_maximoCache;$l_maximoCachePrefs;$l_memoriaFisica_MB;$l_MemoriaLibre;$l_memoriaProcesosClientes)
C_LONGINT:C283($l_MemoriaProcesosWeb;$l_memoriaReservadaPrefs;$l_MemoriaUtilizada;$l_minimoCache;$l_minimoCachePrefs;$l_opcion;$l_porcentajeCache;$l_porcentajeCachePrefs;$l_reservaSistema;$l_stamp)
C_TEXT:C284($t_conflictos;$t_machineName;$t_mensaje;$t_ref;$t_refElemento;$t_rutaDestino;$t_rutaElemento;$t_rutaOrigen;$t_uuidColegio;$t_uuidPrefsDB)
C_TEXT:C284($t_Valor;$t_XMLrefPropiedades)
C_OBJECT:C1216($ob_resultado)

OB SET:C1220($ob_resultado;"reiniciar";False:C215)
OB SET:C1220($ob_resultado;"";False:C215)
  //TRACE

$b_server4D64bits:=(Version type:C495 ?? 64 bit version:K5:25)
SYS_GetServerMemory (->$l_memoriaFisica_MB;->$l_MemoriaUtilizada;->$l_MemoriaLibre;->$l_Cache;->$l_cacheUtilizado)


READ ONLY:C145([Colegio:31])
ALL RECORDS:C47([Colegio:31])
$t_uuidColegio:=[Colegio:31]UUID:58
UNLOAD RECORD:C212([Colegio:31])

$t_XMLrefPropiedades:=SYS_ParseXMLDatabaseSettings 

  // stamp
$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;"preferences")
DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"stamp";$t_Valor)
$l_stamp:=Num:C11($t_Valor)

  // schooltrack
$t_rutaElemento:="preferences/schooltrack"
$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;$t_rutaElemento)
If (OK=0)
	$t_machineName:=Current machine:C483
	$t_refElemento:=DOM Create XML element:C865($t_XMLrefPropiedades;$t_rutaElemento)
End if 

$t_rutaElemento:="preferences/schooltrack/uuid_db"
$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;$t_rutaElemento)
If (OK=0)
	$t_refElemento:=DOM Create XML element:C865($t_XMLrefPropiedades;$t_rutaElemento)
	DOM SET XML ELEMENT VALUE:C868($t_refElemento;$t_uuidColegio)
	$b_guardar:=True:C214
End if 

$t_rutaElemento:="preferences/schooltrack/machine_name"
$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;$t_rutaElemento)
If (OK=0)
	$t_refElemento:=DOM Create XML element:C865($t_XMLrefPropiedades;$t_rutaElemento)
	DOM SET XML ELEMENT VALUE:C868($t_refElemento;Current machine:C483)
	$b_guardar:=True:C214
End if 

$t_rutaElemento:="preferences/schooltrack/logMemory_active"
$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;$t_rutaElemento)
If (OK=0)
	$t_refElemento:=DOM Create XML element:C865($t_XMLrefPropiedades;$t_rutaElemento)
	DOM SET XML ELEMENT VALUE:C868($t_refElemento;0)
	$b_guardar:=True:C214
End if 

$t_rutaElemento:="preferences/schooltrack/logMemory_Delay"
$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;$t_rutaElemento)
If (OK=0)
	$t_refElemento:=DOM Create XML element:C865($t_XMLrefPropiedades;$t_rutaElemento)
	DOM SET XML ELEMENT VALUE:C868($t_refElemento;0)
	$b_guardar:=True:C214
End if 

  //If ($b_guardar)
  //SYS_SaveXMLDatabaseSettings ($t_XMLrefPropiedades)
  //$t_XMLrefPropiedades:=SYS_ParseXMLDatabaseSettings 
  //End if 


$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;"preferences/schooltrack/uuid_db")
DOM GET XML ELEMENT VALUE:C731($t_refElemento;$t_uuidPrefsDB)
$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;"preferences/schooltrack/machine_name")
DOM GET XML ELEMENT VALUE:C731($t_refElemento;$t_machineName)
$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;"preferences/schooltrack/logMemory_Delay")
DOM GET XML ELEMENT VALUE:C731($t_refElemento;$l_intervaloLogUsoMemoria)
$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;"preferences/schooltrack/logMemory_active")
DOM GET XML ELEMENT VALUE:C731($t_refElemento;$l_logMemoryActive)

  // caché
$t_rutaElemento:="preferences/com.4d/database/cache"
$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;$t_rutaElemento)
DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"size_reserved";$t_Valor)
$l_memoriaReservadaPrefs:=Num:C11($t_Valor)
DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"percentage";$t_Valor)
$l_porcentajeCachePrefs:=Num:C11($t_Valor)
DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"size_minimum";$t_Valor)
$l_minimoCachePrefs:=Num:C11($t_Valor)
DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"size_maximum";$t_Valor)
$l_maximoCachePrefs:=Num:C11($t_Valor)
DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"flush_buffer_delay";$t_Valor)
$l_FlushDelayPrefs:=Num:C11($t_Valor)

Case of 
	: (($t_uuidColegio#$t_uuidPrefsDB) & ($t_machineName=Current machine:C483))
		  //el archivo .4Dsettings corresponde a otra base de datos pero se ejecuta en la misma maquina (probablemente QA, DT, o desarrollo)
		  // respaldo el archivo .4D Settings
		$b_actualizarPrefs:=True:C214
		$b_respaldarPrefs:=True:C214
		
	: (($t_uuidColegio#$t_uuidPrefsDB) & ($t_machineName#Current machine:C483))
		  //el archivo .4Dsettings corresponde a otra base de datos y se ejecuta en una máquina distinta de la referenciada en las preferencias
		  // respaldo el archivo .4D Settings
		$b_actualizarPrefs:=True:C214
		$b_usarRecomendaciones:=True:C214
		$b_respaldarPrefs:=True:C214
		
	: ($t_machineName#Current machine:C483)
		$b_actualizarPrefs:=True:C214
		$b_usarRecomendaciones:=True:C214
		$b_respaldarPrefs:=True:C214
	Else 
		  //$b_actualizarPrefs:=False
		  //$b_usarRecomendaciones:=False
End case 

If ($b_guardar)
	SYS_SaveXMLDatabaseSettings ($t_XMLrefPropiedades)
Else 
	DOM CLOSE XML:C722($t_XMLrefPropiedades)
End if 

If ($b_respaldarPrefs)
	$t_rutaOrigen:=Get 4D folder:C485(Database folder:K5:14)+"Preferences"+Folder separator:K24:12+"settings.4DSettings"
	$t_rutaDestino:=Get 4D folder:C485(Database folder:K5:14)+"Preferences"+Folder separator:K24:12+"settings{"+$t_uuidColegio+"}.4DSettings"
	If (Test path name:C476($t_rutaDestino)=Is a document:K24:1)
		DELETE DOCUMENT:C159($t_rutaDestino)
		COPY DOCUMENT:C541($t_rutaOrigen;$t_rutaDestino)
	Else 
		COPY DOCUMENT:C541($t_rutaOrigen;$t_rutaDestino)
	End if 
End if 


If ($b_usarRecomendaciones)
	SYS_CalculaConfigMemoria (->$l_reservaSistema;->$l_porcentajeCache;->$l_minimoCache;->$l_maximoCache;->$l_memoriaProcesosClientes;->$l_MemoriaProcesosWeb;->$t_conflictos)
	Case of 
		: ($l_memoriaReservadaPrefs<$l_reservaSistema)
			
		: ($l_porcentajeCachePrefs<$l_porcentajeCache)
			
		: ($l_minimoCachePrefs<$l_minimoCache)
			
		: ($l_maximoCachePrefs<$l_maximoCache)
			
		Else 
			$b_usarRecomendaciones:=False:C215
	End case 
End if 

If ($b_actualizarPrefs)
	$t_XMLrefPropiedades:=SYS_ParseXMLDatabaseSettings 
	$t_rutaElemento:="preferences/schooltrack/uuid_db"
	$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;$t_rutaElemento)
	DOM SET XML ELEMENT VALUE:C868($t_refElemento;<>GUUID)
	$t_rutaElemento:="preferences/schooltrack/machine_name"
	$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;$t_rutaElemento)
	DOM SET XML ELEMENT VALUE:C868($t_refElemento;Current machine:C483)
	If ($b_usarRecomendaciones)
		  // ********** STAMP **********
		$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;"preferences")
		$l_stamp:=$l_stamp+1
		DOM SET XML ATTRIBUTE:C866($t_refElemento;"stamp";String:C10($l_stamp))
		
		  // ********** CACHE **********
		$t_rutaElemento:="preferences/com.4d/database/cache"
		$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;$t_rutaElemento)
		DOM SET XML ATTRIBUTE:C866($t_refElemento;"size_reserved";String:C10($l_reservaSistema))
		DOM SET XML ATTRIBUTE:C866($t_refElemento;"percentage";String:C10($l_porcentajeCache))
		DOM SET XML ATTRIBUTE:C866($t_refElemento;"size_minimum";String:C10($l_minimoCache))
		DOM SET XML ATTRIBUTE:C866($t_refElemento;"size_maximum";String:C10($l_maximoCache))
		DOM SET XML ATTRIBUTE:C866($t_refElemento;"flush_buffer_delay";String:C10(10))
		SYS_SaveXMLDatabaseSettings ($t_XMLrefPropiedades)
		  //If (sys_IsAppRunningAsService =0)
		  //$t_mensaje:=__ ("Los ajustes de memoria actuales corresponden a otro servidor (^0)\rLos ajustes de memoria fueron actualizados de acuerdo a la características del servidor actual (^1).\r\r¿Desea revisar los ajustes antes de iniciar el servidor?")
		  //$t_mensaje:=Replace string($t_mensaje;"^0";$t_machineName)
		  //$t_mensaje:=Replace string($t_mensaje;"^1";Current machine)
		  //CONFIRM($t_mensaje;__ ("Revisar");__ ("Continuar"))
		  //If (OK=1)
		  //MNU_Propiedades
		  //End if
		  //CIM_ReiniciaAplicacion
		  //Else
		  //CIM_ReiniciaAplicacion
		  //End if
	Else 
		SYS_SaveXMLDatabaseSettings ($t_XMLrefPropiedades)
	End if 
	
End if 
