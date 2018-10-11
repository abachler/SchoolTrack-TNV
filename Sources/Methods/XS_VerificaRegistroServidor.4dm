//%attributes = {}
  // XS_VerificaRegistroServidor()
  //
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 21/08/12, 17:25:28
  // ---------------------------------------------
C_LONGINT:C283($0)

C_LONGINT:C283($l_servidorRegistrado)
C_POINTER:C301($y_Nil)
C_TEXT:C284($t_version;$t_DateStamp;$t_MacAddress;$t_MacAddressRegistro;$t_resultado;$t_wsError)
C_BOOLEAN:C305($b_registrarNotificacion)

  //MONO ticket 144984
C_OBJECT:C1216($ob_request;$ob_response)
C_TEXT:C284($t_jsonRequest;$t_errormsg;$t_json)
C_LONGINT:C283($httpStatus_l)
C_BOOLEAN:C305($b_errorResponse)

If (False:C215)
	C_LONGINT:C283(XS_VerificaRegistroServidor ;$0)
End if 


ARRAY TEXT:C222($at_direccionesMAC;0)
$t_MacAddress:=SYS_GetServerMAC (->$at_direccionesMAC)
$t_version:=SYS_LeeVersionEstructura 

$ob_request:=OB_Create 
OB_SET ($ob_request;-><>GROLBD;"rolbd")
OB_SET ($ob_request;-><>GCOUNTRYCODE;"codpais")
OB_SET ($ob_request;->$t_MacAddress;"macAddressServidor")
OB_SET ($ob_request;->$t_version;"versionSchoolTrack")

$t_jsonRequest:=OB_Object2Json ($ob_request;True:C214)
$httpStatus_l:=Intranet3_LlamadoWS ("WSget_RegistroServidor";$t_jsonRequest;->$t_json)

If ($httpStatus_l=200)
	  // si fue posible establecer la comunicación con el web service en la Intranet Colegium
	  // obtengo la respuesta del web service
	$ob_response:=JSON Parse:C1218($t_json;Is object:K8:27)
	OB_GET ($ob_response;->$b_errorResponse;"error")
	OB_GET ($ob_response;->$t_wsError;"mensaje")
	OB_GET ($ob_response;->$t_MacAddressRegistro;"resultado")
End if 

Case of 
		
	: (($t_wsError="") & ((<>gMacAddressServidorOficial#$t_MacAddress) & ($t_MacAddress=$t_MacAddressRegistro)))
		  // La MAC registrada en la Intranet y la MAC actual son las mismas pero la MAC de servidor oficial registrada en la BD es distinta:
		  // Actualizamos la MAC del servidor oficial en la BD
		$l_servidorRegistrado:=1
		<>gMacAddressServidorOficial:=$t_MacAddress
		READ WRITE:C146([Colegio:31])
		ALL RECORDS:C47([Colegio:31])
		FIRST RECORD:C50([Colegio:31])
		[Colegio:31]MacAddress_ServidorOficial:59:=<>gMacAddressServidorOficial
		SAVE RECORD:C53([Colegio:31])
		
		
	: (($t_wsError="") & ($t_MacAddress#$t_MacAddressRegistro))
		  // La MAC registrada en la Intranet es distinta de la MAC actual y distinta de la MAC de servidor oficial:
		  // Activo el registro de servidor oficial 
		$l_servidorRegistrado:=-1
		
		
		
		
	: (($t_wsError#"") & (<>gMacAddressServidorOficial=$t_MacAddress))
		  // No fue posible establecer la comunicación con el web service pero la MAC address es la misma que la última registrada como servidor oficial de la institución.
		  // El servidor continua actuando como servidor oficial
		  // Esto permite que en caso de problema de red puntual el servidor pueda seguir operando como servidor oficial,
		$l_servidorRegistrado:=1
		
		
		
	: (($t_wsError#"") & (<>gMacAddressServidorOficial#$t_MacAddress))
		  // No fue posible establecer la comunicación con el web service de registro de servidor oficial y la última MAC address registrada es distinta de la MAC address actual
		  // Se activa el registro de servidor oficial 
		$l_servidorRegistrado:=-1
		
End case 


$b_CorriendoComoServicio:=SYS_IsServerRunningAsWINService 
If ($l_servidorRegistrado=-1)
	  //If (Application version>="1400@")
	  //$b_registrarNotificacion:=True
	  //Else 
	If (Not:C34($b_CorriendoComoServicio))
		$l_refVentana:=Open form window:C675("RegistroServidor";Movable form dialog box:K39:8;Horizontally centered:K39:1;Vertically centered:K39:4)
		SET WINDOW TITLE:C213(__ ("Registro del servidor actual"))
		DIALOG:C40("RegistroServidor")
		CLOSE WINDOW:C154
		
		Case of 
			: (bNuevoServer=1)
				$l_servidorRegistrado:=1
				<>gMacAddressServidorOficial:=$t_MacAddress
				READ WRITE:C146([Colegio:31])
				ALL RECORDS:C47([Colegio:31])
				FIRST RECORD:C50([Colegio:31])
				[Colegio:31]MacAddress_ServidorOficial:59:=<>gMacAddressServidorOficial
				SAVE RECORD:C53([Colegio:31])
				
				
			: (bNuevoServerTemporal=1)
				$t_usuario:=vt_nombreUsuario
				$t_mensaje:=__ ("El usuario $t_usuario registró este servidor (Indentificador de red $t_MacAddress) como servidor oficial temporal.\r")
				$t_mensaje:=$t_mensaje+__ ("Por favor seleccione la opción \"Registrar Servidor Oficial...\" en la rueda de tareas para registrar este servidor en los servicios de Colegium.")
				$t_mensaje:=Replace string:C233($t_mensaje;"$t_MacAddress";$t_MacAddress)
				$t_mensaje:=Replace string:C233($t_mensaje;"$t_usuario";$t_usuario)
				$t_UUID:=NTC_CreaMensaje ("";__ ("Identificación del servidor");__ ("Un error de red impidió registrar este servidor como servidor oficial."))
				NTC_Mensaje_Texto ($t_UUID;$t_mensaje)
				
				$t_mensajeExito:=__ ("El servidor actual, Identificador de Red $t_MacAddress fue registrado como servidor oficial")
				$t_mensajeExito:=Replace string:C233($t_mensajeExito;"$t_MacAddress";$t_MacAddress)
				$t_mansajeFalla:=__ ("El servidor actual no fue registrado como servidor oficial. Se inhabilitaron las funciones de envío de información a los servicios de Colegium.")
				$t_TextoEjecucion:=__ ("Registrar Servidor Oficial...")
				NTC_Mensaje_MetodoAsociado ($t_UUID;Current method name:C684;$t_mansajeFalla;$t_mensajeExito;$t_TextoEjecucion)
				$l_servidorRegistrado:=1
				
				
			: (bSalir=1)
				$l_servidorRegistrado:=-3
				QUIT 4D:C291
				
			: (btestServer=1)
				$l_servidorRegistrado:=-1
				
		End case 
		
	Else 
		$b_registrarNotificacion:=True:C214
	End if 
	  //End if 
	
End if 



If ($b_registrarNotificacion)
	$l_servidorRegistrado:=-1
	$t_mensaje:=__ ("El identificador de red del servidor es distinto del identificador de red registrado como servidor oficial.\r")
	$t_mensaje:=$t_mensaje+__ ("Como SchoolTrack Server se está ejecutando como servicio no fue posible solicitar el registro de servidor oficial al iniciar.\r")
	$t_mensaje:=$t_mensaje+__ ("Por razones de seguridad SchoolTrack no enviará ninguna información a los servicios de Colegium mientras no pueda verificar que este es el servidor oficial.\r")
	$t_mensaje:=$t_mensaje+__ ("Por favor seleccione la opción \"Registrar Servidor Oficial...\" en la rueda de tareas para registrar este servidor.")
	$t_UUID:=NTC_CreaMensaje ("";__ ("Identificación del servidor");__ ("No fue posible verificar la identidad de este servidor"))
	NTC_Mensaje_Texto ($t_UUID;$t_mensaje)
	
	$t_mensajeExito:=__ ("El servidor actual, Identificador de Red $t_MacAddress fue registrado como servidor oficial")
	$t_mensajeExito:=Replace string:C233($t_mensajeExito;"$t_MacAddress";$t_MacAddress)
	$t_mansajeFalla:=__ ("El servidor actual no fue registrado como servidor oficial. Se inhabilitaron las funciones de envío de información a los servicios de Colegium.")
	$t_TextoEjecucion:=__ ("Registrar Servidor Oficial...")
	NTC_Mensaje_MetodoAsociado ($t_UUID;Current method name:C684;$t_mansajeFalla;$t_mensajeExito;$t_TextoEjecucion)
End if 

$0:=$l_servidorRegistrado

