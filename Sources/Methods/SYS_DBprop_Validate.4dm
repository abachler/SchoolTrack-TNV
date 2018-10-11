//%attributes = {"executedOnServer":true}
  // SYS_DBprop_Validate()
  //
  //
  // creado por: Alberto Bachler Klein: 18-03-16, 17:37:51
  // -----------------------------------------------------------
C_BOOLEAN:C305($b_actualizarPrefs;<>sys_is64bitOS_B;$b_guardar;$b_respaldarPrefs;$b_ReVerificar;$b_server4D64bits;$b_usarRecomendaciones)
C_LONGINT:C283($l_Cache;$l_cacheUtilizado;$l_FlushDelayPrefs;$l_intervaloLogUsoMemoria;$l_logMemoryActive;$l_maximoCache;$l_maximoCachePrefs;$l_memoriaFisica_MB;$l_MemoriaLibre;$l_memoriaProcesosClientes)
C_LONGINT:C283($l_MemoriaProcesosWeb;$l_memoriaReservadaPrefs;$l_MemoriaUtilizada;$l_minimoCache;$l_minimoCachePrefs;$l_opcion;$l_porcentajeCache;$l_porcentajeCachePrefs;$l_reservaSistema;$l_stamp)
C_TEXT:C284($t_conflictos;$t_machineName;$t_mensaje;$t_ref;$t_refElemento;$t_rutaDestino;$t_rutaElemento;$t_rutaOrigen;$t_uuidColegio;$t_uuidPrefsDB)
C_TEXT:C284($t_Valor;$t_XMLrefPropiedades)
C_OBJECT:C1216($ob_resultado)

OB SET:C1220($ob_resultado;"reiniciar";False:C215)
OB SET:C1220($ob_resultado;"";False:C215)


READ ONLY:C145([Colegio:31])
ALL RECORDS:C47([Colegio:31])
$t_uuidColegio:=[Colegio:31]UUID:58
UNLOAD RECORD:C212([Colegio:31])


SYS_DBprop_CheckConfigFile ($t_uuidColegio)

$b_server4D64bits:=(Version type:C495 ?? 64 bit version:K5:25)
SYS_GetServerMemory (->$l_memoriaFisica_MB;->$l_MemoriaUtilizada;->$l_MemoriaLibre;->$l_Cache;->$l_cacheUtilizado)

$t_XMLrefPropiedades:=SYS_DBprop_ParseXML 

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
		$b_respaldarPrefs:=True:C214
		
	: ($t_machineName#Current machine:C483)
		$b_actualizarPrefs:=True:C214
		$b_respaldarPrefs:=True:C214
	Else 
		  //$b_actualizarPrefs:=False
End case 
DOM CLOSE XML:C722($t_XMLrefPropiedades)


If ($b_actualizarPrefs)
	SYS_DBprop_CalculateMemConfig (->$l_reservaSistema;->$l_porcentajeCache;->$l_minimoCache;->$l_maximoCache;->$l_memoriaProcesosClientes;->$l_MemoriaProcesosWeb;->$t_conflictos)
	
	$t_XMLrefPropiedades:=SYS_DBprop_ParseXML 
	$t_rutaElemento:="preferences/schooltrack/uuid_db"
	$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;$t_rutaElemento)
	DOM SET XML ELEMENT VALUE:C868($t_refElemento;<>GUUID)
	$t_rutaElemento:="preferences/schooltrack/machine_name"
	$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;$t_rutaElemento)
	DOM SET XML ELEMENT VALUE:C868($t_refElemento;Current machine:C483)
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
	SYS_DBprop_SaveXML ($t_XMLrefPropiedades)
	
	RESTART 4D:C1292
End if 