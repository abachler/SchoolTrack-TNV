//%attributes = {"executedOnServer":true}
  // SYS_CalculaConfigMemoria()
  // Por: Alberto Bachler K.: 25-09-15, 09:45:00
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305(<>sys_is64bitOS_B;$b_guardar;$b_Salir;$b_server4D64bits;$b_webServerActive)
C_LONGINT:C283($l_Cache;$l_cacheUtilizado;$l_maximoCache;$l_MaxUsuarios;$l_memoriaDisponible;$l_memoriaFisica_MB;$l_MemoriaLibre;$l_memoriaPorUsuario;$l_memoriaProcesosClientes;$l_MemoriaProcesosWeb)
C_LONGINT:C283($l_MemoriaUtilizada;$l_minimoCache;$l_porcentajeCache;$l_procesosWeb;$l_reservaSistema)
C_POINTER:C301($y_conflictos;$y_maximoCache;$y_maxProcesosWeb;$y_memoriaProcesosClientes;$y_memoriaProcesosWeb;$y_minimoCache;$y_porcentajeCache;$y_reservaSistema)
C_TEXT:C284($t_conflictos;$t_MachineName;$t_OS;$t_refElemento;$t_rutaElemento;$t_uuidDB;$t_Valor;$t_XMLrefPropiedades)

$y_reservaSistema:=$1
$y_porcentajeCache:=$2
$y_minimoCache:=$3
$y_maximoCache:=$4
$y_memoriaProcesosClientes:=$5
$y_memoriaProcesosWeb:=$6
$y_conflictos:=$7

  //TRACE
$t_XMLrefPropiedades:=SYS_ParseXMLDatabaseSettings 
$t_rutaElemento:="preferences/com.4d/web/standalone_server/configuration"
$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;$t_rutaElemento)
DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"publish_at_startup";$t_Valor)
$b_webServerActive:=($t_Valor="True")
$t_rutaElemento:="preferences/com.4d/web/standalone_server/options/web_processes"
$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;$t_rutaElemento)
DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"max_concurrent";$t_Valor)
$l_procesosWeb:=Num:C11($t_Valor)


$t_rutaElemento:="preferences/schooltrack/uuid_db"
$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;$t_rutaElemento)
If (OK=0)
	$t_refElemento:=DOM Create XML element:C865($t_XMLrefPropiedades;$t_rutaElemento)
	DOM SET XML ELEMENT VALUE:C868($t_refElemento;$t_uuidDB)
	$b_guardar:=True:C214
Else 
	DOM GET XML ELEMENT VALUE:C731($t_refElemento;$t_uuidDB)
End if 

$t_rutaElemento:="preferences/schooltrack/machine_name"
$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;$t_rutaElemento)
If (OK=0)
	$t_refElemento:=DOM Create XML element:C865($t_XMLrefPropiedades;$t_rutaElemento)
	DOM SET XML ELEMENT VALUE:C868($t_refElemento;$t_MachineName)
	$b_guardar:=True:C214
Else 
	DOM GET XML ELEMENT VALUE:C731($t_refElemento;$t_MachineName)
End if 

If ($b_guardar)
	SYS_SaveXMLDatabaseSettings ($t_XMLrefPropiedades)
Else 
	DOM CLOSE XML:C722($t_XMLrefPropiedades)
End if 


SYS_GetServerMemory (->$l_memoriaFisica_MB;->$l_MemoriaUtilizada;->$l_MemoriaLibre;->$l_Cache;->$l_cacheUtilizado)
$t_OS:=SYS_GetServerOS 

<>sys_is64bitOS_B:=<>sys_is64bitOS_B
$b_server4D64bits:=(Version type:C495 ?? 64 bit version:K5:25)
$t_conflictos:=""
Case of 
		  // XP & Windows 2003 Server
	: (($t_OS="Windows XP@") | ($t_OS="Windows Server 2003@"))
		$t_conflictos:=__ ("Sistema operativo no compatible")
		
		  // Windows 2008 Server (no R2)
	: (($t_OS="Windows Server 2008@") | ($t_OS="Windows Vista@"))
		$t_conflictos:=__ ("Sistema operativo no compatible")
		
		
		  // Windows Vista & Windows 2008 Server R2
	: ($t_OS="Windows Server 2008 Release 2@")
		Case of 
			: ($l_memoriaFisica_MB<4000)
				$b_Salir:=True:C214
				$l_reservaSistema:=512
				$t_conflictos:=__ ("La memoria física instalada es insuficiente.")
				
			: ($l_memoriaFisica_MB<=6000)
				$l_reservaSistema:=512
				$t_conflictos:=__ ("La memoria física instalada en el equipo podría no ser suficiente")
				
			Else 
				$l_reservaSistema:=1024
		End case 
		
		
	: (($t_OS="Windows 7@") | ($t_OS="Windows Server 2012@") | ($t_OS="Windows 8.1@") | ($t_OS="Windows 10@"))
		Case of 
			: ($l_memoriaFisica_MB<4096)
				If (<>sys_is64bitOS_B)
					$l_reservaSistema:=512
					$t_conflictos:=__ ("La memoria física instalada en el equipo podría no ser suficiente")
				Else 
					$l_reservaSistema:=512
					  //$t_conflictos:=__ ("La memoria física instalada en el equipo podría no ser suficiente")
				End if 
				
			: ($l_memoriaFisica_MB<=8000)
				$l_reservaSistema:=1024
				
			: ($l_memoriaFisica_MB<=16000)
				$l_reservaSistema:=2048
				
			Else 
				$l_reservaSistema:=2048
		End case 
		
		
	: ($t_OS="Windows 8@")
		$t_conflictos:=__ ("Sistema operativo no compatible")
		
		
	: ($t_OS="Mac@")
		Case of 
			: ($l_memoriaFisica_MB<=4000)
				$l_reservaSistema:=1024
				If (Application type:C494=4D Server:K5:6)
					$t_conflictos:=__ ("La memoria física instalada en el servidor podría no ser suficiente")
				Else 
					$t_conflictos:=__ ("La memoria física instalada en el equipo podría no ser suficiente")
				End if 
				
			: ($l_memoriaFisica_MB<=8000)
				$l_reservaSistema:=1024
				  //$t_conflictos:=__ ("La memoria física instalada en el equipo podría no ser suficiente")
				
			: ($l_memoriaFisica_MB<=16000)
				$l_reservaSistema:=2048
				
			Else 
				$l_reservaSistema:=2048
				
		End case 
End case 

$y_maxProcesosWeb:=OBJECT Get pointer:C1124(Object named:K67:5;"webMaxProcess")
$l_MaxUsuarios:=60
$l_memoriaDisponible:=$l_memoriaFisica_MB-$l_reservaSistema
$l_memoriaPorUsuario:=5
$l_memoriaProcesosClientes:=$l_memoriaPorUsuario*$l_MaxUsuarios
$l_MemoriaDisponible:=$l_memoriaDisponible-$l_memoriaProcesosClientes
$l_MemoriaProcesosWeb:=$l_procesosWeb*256/1024  // tamaño proceso (Kbytes*NumeroProcesos/1024): reservado web en MB
$l_MemoriaDisponible:=$l_MemoriaDisponible-$l_MemoriaProcesosWeb


Case of 
	: ($l_memoriaDisponible<2048)
		$l_porcentajeCache:=50
		$l_maximoCache:=$l_memoriaDisponible*($l_porcentajeCache/100)
		$l_minimoCache:=1024
		
	: ($l_memoriaDisponible<=4096)
		$l_porcentajeCache:=50
		$l_maximoCache:=$l_memoriaDisponible*($l_porcentajeCache/100)
		$l_minimoCache:=1024
		
	: ($l_memoriaDisponible<=8192)
		$l_porcentajeCache:=60
		$l_maximoCache:=$l_memoriaDisponible*($l_porcentajeCache/100)
		
	Else 
		$l_porcentajeCache:=80
		$l_maximoCache:=$l_memoriaDisponible*($l_porcentajeCache/100)
		$l_minimoCache:=1024
End case 

Case of 
	: (Not:C34(<>sys_is64bitOS_B))
		$l_maximoCache:=6000
		
	: (($l_maximoCache>2048) & (Not:C34($b_server4D64bits)))
		$l_maximoCache:=2048
		
End case 

$y_reservaSistema->:=$l_reservaSistema
$y_porcentajeCache->:=$l_porcentajeCache
$y_minimoCache->:=$l_minimoCache
$y_maximoCache->:=$l_maximoCache
$y_memoriaProcesosClientes->:=$l_memoriaProcesosClientes
$y_memoriaProcesosWeb->:=$l_MemoriaProcesosWeb
$y_conflictos->:=$t_conflictos