//%attributes = {"executedOnServer":true}
  // WEB_StartWebServer2()
  // Modificado por: Alberto Bachler K.: 18-06-15, 12:44:09
  //  ---------------------------------------------
  // se ejecuta en el servidor 
  // llama a STWA2_Session_Init, detiene el servidor y lo reinicia
  //
  //  ---------------------------------------------
C_BLOB:C604($x_blob)
C_TEXT:C284($t_texto;$t_output)

mdt_Licensed:=LICENCIA_esModuloAutorizado (1;MediaTrack)
stw_Licensed:=LICENCIA_esModuloAutorizado (1;SchoolTrack Web Access)

WEB_LoadSettings 

WEB SET ROOT FOLDER:C634(SYS_CarpetaAplicacion (CLG_Estructura)+"Carpeta Web")

$t_rutaRaizWebServer:=Get 4D folder:C485(HTML Root folder:K5:20)
$t_rutaTempleta:=$t_rutaRaizWebServer+"portalTemp.shtml"


If (Not:C34(stw_Licensed))
	  // si la licencia no permite el uso de STWA se eliminan todos los registros de la 
	READ WRITE:C146([STWA2_SessionManager:290])
	TRUNCATE TABLE:C1051([STWA2_SessionManager:290])
	READ ONLY:C145([STWA2_SessionManager:290])
	If (SYS_TestPathName ($t_rutaRaizWebServer+"portal.shtml")=Is a document:K24:1)
		DELETE DOCUMENT:C159($t_rutaRaizWebServer+"portal.shtml")
	End if 
End if 

If (mdt_Licensed | stw_Licensed)
	  // lectura de certificados si se usa SSL
	SET DATABASE PARAMETER:C642(Maximum Web requests size:K37:27;52*1024*1024)
	SET DATABASE PARAMETER:C642(Port ID:K37:15;Num:C11(<>web_server_puertoHTTP))
	SET DATABASE PARAMETER:C642(HTTPS port ID:K37:38;Num:C11(<>web_server_https_puertoHTTPS))
	If (<>web_server_usarSSL=1)
		$pathCert:=Get 4D folder:C485(Database folder:K5:14)+"cert.pem"
		$pathKey:=Get 4D folder:C485(Database folder:K5:14)+"key.pem"
		
		$doesCertExist:=(SYS_TestPathName ($pathCert)=Is a document:K24:1)
		$doesKeyExist:=(SYS_TestPathName ($pathKey)=Is a document:K24:1)
		
		If ((Not:C34($doesCertExist)) | (Not:C34($doesKeyExist)))
			If ($doesCertExist)
				DELETE DOCUMENT:C159($pathCert)
			End if 
			If ($doesKeyExist)
				DELETE DOCUMENT:C159($pathKey)
			End if 
			If (BLOB size:C605(<>web_server_https_certDoc)>32)
				BLOB TO DOCUMENT:C526($pathCert;<>web_server_https_certDoc)
			End if 
			If (BLOB size:C605(<>web_server_https_keyDoc)>32)
				BLOB TO DOCUMENT:C526($pathKey;<>web_server_https_keyDoc)
			End if 
		End if 
		If ($doesCertExist)
			DOCUMENT TO BLOB:C525($pathCert;<>web_server_https_certDoc)
		End if 
		If ($doesKeyExist)
			DOCUMENT TO BLOB:C525($pathKey;<>web_server_https_keyDoc)
		End if 
		WEB_SaveSettings 
	End if 
	
	  // se establece la página web inicial
	DOCUMENT TO BLOB:C525($t_rutaTempleta;$x_blob)
	$t_texto:=BLOB to text:C555($x_blob;UTF8 text without length:K22:17)
	PROCESS 4D TAGS:C816($t_texto;$t_output)
	SET BLOB SIZE:C606($x_blob;0)
	TEXT TO BLOB:C554($t_output;$x_blob;UTF8 text without length:K22:17)
	BLOB TO DOCUMENT:C526($t_rutaRaizWebServer+"portal.shtml";$x_blob)
	WEB SET HOME PAGE:C639("portal.shtml")
	DELAY PROCESS:C323(Current process:C322;60)
	
	  // se reinicia el servidor web
	WEB STOP SERVER:C618  // si no está corriendo no hace nada
	WEB START SERVER:C617
	  // inicicio del demonio que STWA 2 Session Manager si es necesario
	$p:=New process:C317("STWA2_Session_Init";Pila_128K;"STWA 2 Session Manager";*)
	  // registro en el log de actividades
	If (OK=1)
		LOG_RegisterEvt (__ ("Servidor HTTP iniciado."))
	Else 
		LOG_RegisterEvt (__ ("El servidor HTTP no pudo ser iniciado."))
	End if 
End if 
