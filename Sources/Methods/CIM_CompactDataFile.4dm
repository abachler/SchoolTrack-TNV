//%attributes = {"executedOnServer":true}
  // CIM_CompactDataFile()
  // Por: Alberto Bachler K.: 07-04-15, 18:21:25
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)
C_BOOLEAN:C305($2)

C_BOOLEAN:C305($b_noReiniciar;$b_semaforoActivo)
C_LONGINT:C283($i;$l_elemento;$l_idProgress;$l_intentos;$l_proceso;$l_records)
C_POINTER:C301($y_ArregloErrores;$y_arregloNombresTablas;$y_ArregloNumerosTablas;$y_arregloRegistrosAntes;$y_arregloRegistrosColores;$y_arregloRegistrosDespues;$y_arregloRegistrosDiferencia)
C_REAL:C285($r_avanceCompactacion)
C_TEXT:C284($t_archivoEstructura;$t_archivosDatos;$t_asunto;$t_CarpetaCompactacion;$t_carpetaDestino;$t_cuerpo;$t_emailAviso;$t_etapaCompactacion;$t_mensaje;$t_rutaArchivoHistorial)



If (False:C215)
	C_TEXT:C284(CIM_CompactDataFile ;$0)
	C_TEXT:C284(CIM_CompactDataFile ;$1)
	C_BOOLEAN:C305(CIM_CompactDataFile ;$2)
End if 

C_TEXT:C284(vt_Client)
C_LONGINT:C283(vl_ClientProgressProcessID)
C_LONGINT:C283(vl_ServerProgressProcessID)
ARRAY TEXT:C222(at_DataFileError;0)  // para almacenar los errores detectados


vt_client:=""
vl_ClientProgressProcessID:=0

Case of 
	: (Count parameters:C259=3)
		$t_emailAviso:=$1
		$b_noReiniciar:=$2
		$t_carpetaDestino:=$3
		
	: (Count parameters:C259=2)
		$t_emailAviso:=$1
		$b_noReiniciar:=$2
		
	: (Count parameters:C259=1)
		$t_emailAviso:=$1
End case 

C_TEXT:C284(<>t_EtapaCompactacion)
C_REAL:C285(<>r_AvanceCompactacion)

  //If (Application type=4D Remote Mode)
  //$t_mensaje:=__ ("Compactando de base de datos")
  //$l_idProgress:=IT_Progress (1;0;0;$t_mensaje)
  //$l_proceso:=Execute on server(Current method name;Pila_512K;"Compactación de base de datos";$t_emailAviso;$b_noReiniciar)
  //DELAY PROCESS(Current process;60)
  //Repeat 
  //GET PROCESS VARIABLE($l_proceso;<>r_AvanceCompactacion;$r_avanceCompactacion)
  //GET PROCESS VARIABLE($l_proceso;<>t_EtapaCompactacion;$t_etapaCompactacion)
  //IT_Progress (0;$l_idProgress;$r_avanceCompactacion;$t_etapaCompactacion)
  //DELAY PROCESS(Current process;60)
  //Until ($r_avanceCompactacion=-1)
  //IT_Progress (-1;$l_idProgress)
  //QUIT 4D
  //
  //Else 

$b_semaforoActivo:=Semaphore:C143("CompactandoBD")
If ($t_carpetaDestino="")
	$t_fechaHora:=String:C10(Current date:C33;ISO date GMT:K1:10;Current time:C178)
	$t_fechaHora:=Replace string:C233($t_fechaHora;":";"-")
	$t_carpetaDestino:=SYS_GetServerProperty (XS_DataFileFolder)+"Bases de datos reemplazadas"+Folder separator:K24:12
	SYS_CreaCarpetaServidor ($t_carpetaDestino)
End if 

vl_ServerProgressProcessID:=IT_Progress (1;0;0;__ ("Compactando base de datos..."))


$t_archivoEstructura:=Structure file:C489
$t_archivosDatos:=Data file:C490

$t_rutaArchivoHistorial:=SYS_GetServerProperty (XS_LogFilePath)
If (Test path name:C476($t_rutaArchivoHistorial)=Is a document:K24:1)
	SELECT LOG FILE:C345(*)
	DELETE DOCUMENT:C159($t_rutaArchivoHistorial)
End if 

MESSAGES ON:C181
DELAY PROCESS:C323(Current process:C322;60)
OK:=0
$l_intentos:=3
While ($l_intentos>0)
	error:=0
	ON ERR CALL:C155("ERR_GenericOnError")
	$t_CarpetaCompactacion:=Compact data file:C937($t_archivoEstructura;$t_archivosDatos;$t_carpetaDestino;Compact address table:K57:13+Update records:K57:12;"CIM_CompactDatafile_callback")
	ON ERR CALL:C155("")
	If (OK=1)
		$l_intentos:=0
	Else 
		$l_intentos:=$l_intentos-1
		DELAY PROCESS:C323(Current process:C322;60)
	End if 
End while 
MESSAGES OFF:C175

<>r_AvanceCompactacion:=-1
DELAY PROCESS:C323(Current process:C322;60)


If ((OK=1) & (error=0))
	If (($t_CarpetaCompactacion#Data file:C490) & (Size of array:C274(at_DataFileError)=0))
		If (Application type:C494=4D Server:K5:6)
			$t_asunto:=__ ("Compactación exitosa de la base de datos")
			$t_cuerpo:=__ ("La compactación de la base de datos concluyó sin que se detectaran problemas. Schooltrack Server se está reiniciando y debiera estar disponible nuevamente en algunos minutos")
			Mail_EnviaNotificacion ($t_asunto;$t_cuerpo;$t_emailAviso)
			Notificacion_Mostrar ($t_asunto;$t_cuerpo)
		End if 
	Else 
		If (Application type:C494=4D Server:K5:6)
			$t_asunto:=__ ("Compactación fallida de la base de datos")
			$t_cuerpo:=__ ("No fue posible compactar la base de datos. Por favor intente reparar la base de datos en el Centro de Seguridad y Mantenimiento\r")
			Mail_EnviaNotificacion ($t_asunto;$t_cuerpo;$t_emailAviso)
			Notificacion_Mostrar ($t_asunto;$t_cuerpo)
		End if 
		QUIT 4D:C291
	End if 
	
	
	If ($t_rutaArchivoHistorial#"")
		If (Test path name:C476($t_rutaArchivoHistorial)#Is a document:K24:1)
			SELECT LOG FILE:C345($t_rutaArchivoHistorial)
			$t_metodoOnError:=Method called on error:C704
			ON ERR CALL:C155("ERR_GenericOnError")
			BACKUP:C887
			ON ERR CALL:C155($t_metodoOnError)
		End if 
	Else 
		  //TRACE
	End if 
	
	CLEAR SEMAPHORE:C144("CompactandoBD")
	If (Not:C34($b_noReiniciar))
		$l_IdProceso:=New process:C317("CIM_ReiniciaAplicacion";Pila_1024K;"Reinicio aplicación")
	End if 
	
	$0:=$t_CarpetaCompactacion
Else 
	$0:=""
End if 
  //End if 
