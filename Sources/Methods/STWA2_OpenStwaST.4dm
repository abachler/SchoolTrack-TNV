//%attributes = {}
  // STWA2_OpenStwaST()
  //
  //
  // creado por: Alberto Bachler Klein: 30-01-16, 17:03:35 (Adrian Sepúlveda; 29/01/2016)
  // -----------------------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($2)

C_BLOB:C604($x_llave)
C_BOOLEAN:C305($b_conUsuario)
C_LONGINT:C283($l_error;$l_puerto)
C_TEXT:C284($t_contraseña;$t_datos;$t_DatosConexion;$t_direccionIP;$t_export;$t_host;$t_llave;$t_password;$t_puerto;$t_url)
C_TEXT:C284($t_urlIntranet;$t_user;$t_userPass;$t_usuario)
C_OBJECT:C1216($ob_Datos;$ob_request;$ob_respuestaIntranet)

ARRAY TEXT:C222($at_respuestas;0)

If (False:C215)
	C_TEXT:C284(STWA2_OpenStwaST ;$1)
	C_TEXT:C284(STWA2_OpenStwaST ;$2)
End if 

ARRAY TEXT:C222($at_httpHeaderNames;1)
ARRAY TEXT:C222($at_httpHeaderValues;1)


Case of 
	: (Count parameters:C259=2)
		$t_usuario:=$1
		$t_contraseña:=$2
		$b_conUsuario:=True:C214
	Else 
		$b_conUsuario:=False:C215
End case 

  //20170601 RCH Se conecta siempre a la IP del server
  //  // acá pido los datos de conexión desde la intranet para generar la url
  //If (<>bXS_esServidorOficial)

  //  // creo el Json para enviar la petición
  //$ob_request:=OB_Create 
  //OB_SET ($ob_request;-><>gRolBD;"rolBD")
  //OB_SET ($ob_request;-><>vtXS_CountryCode;"codigoPais")
  //$t_jsonDatosColegio:=OB_Object2Json ($ob_request;True)

  //$y:=Intranet3_LlamadoWS ("traerDatosAccesoSTWA_xColegio";$t_jsonDatosColegio;->$t_DatosConexion)

  //If ($y=200)
  //  // extraigo el dato desde el Json.
  //$ob_respuestaIntranet:=OB_JsonToObject ($t_DatosConexion)
  //OB_GET ($ob_respuestaIntranet;->$t_datos;"datos")
  //$t_datos:=Replace string(Replace string($t_datos;"[";"");"]";"")
  //$ob_Datos:=OB_JsonToObject ($t_datos)
  //OB_GET ($ob_Datos;->$t_url;"direccionstwa2")
  //OB_GET ($ob_Datos;->$l_puerto;"puerto")
  //OB_GET ($ob_Datos;->$t_direccionIP;"direccionip")

  //If ($b_conUsuario)
  //  // Encripto la pass
  //TEXT TO BLOB($t_contraseña;$x_llave;UTF8 text without length)
  //$t_password:=SHA512 ($x_llave;Crypto HEX)

  //TEXT TO BLOB($t_usuario;$x_llave;UTF8 text without length)
  //$t_user:=SHA512 ($x_llave;Crypto HEX)

  //$t_userPass:=$t_password+$t_user
  //TEXT TO BLOB($t_userPass;$x_llave;UTF8 text without length)
  //$t_password:=SHA512 ($x_llave;Crypto HEX)

  //  // Si no existe la Url configurada, busco STWA por Ip y puerto
  //If ($t_url="")
  //$t_puerto:=Choose(String($l_puerto)="0";"";":"+String($l_puerto))
  //$t_url:=$t_direccionIP+$t_puerto+"/stwa/processloginST?user="+$t_usuario+"&pass="+$t_password+"&st=TRUE"
  //Else 
  //$t_url:=$t_url+".colegium.com/stwa/processloginST?user="+$t_usuario+"&pass="+$t_password+"&st=TRUE"
  //End if 
  //End if 
  //End if 

  //$t_host:=$t_direccionIP
  //$t_url:=$t_host+":"+String($l_puerto)+"/stwa/login.shtml"

  //Else 
  //  // Si no existe la Url configurada, busco STWA por Ip y puerto
  //  // ABK: creo la URL usando la IP y el puerto en el que el ***servidor*** escucha las peticiones web 
  //If ($t_url="")
  //$t_host:=ST_GetWord (SYS_GetServerProperty (XS_IPaddress);1;",")
  //$l_puerto:=Num(SYS_GetServerProperty (110))
  //$t_url:=$t_host+":"+String($l_puerto)+"/stwa/login.shtml"
  //End if 
  //End if 
$t_host:=ST_GetWord (SYS_GetServerProperty (XS_IPaddress);1;",")
$l_puerto:=Num:C11(SYS_GetServerProperty (110))
$t_url:=$t_host+":"+String:C10($l_puerto)+"/stwa/login.shtml"


If (Not:C34(<>bXS_esServidorOficial))
	$t_mensaje:=__ ("Este cliente está conectado a un servidor no oficial.\rLa sesión será iniciada sobre el servidor SchoolTrack Web Access no oficial.\r\r")
	$t_mensaje:=$t_mensaje+__ ("Los cambios que introduzca desde SchoolTrack Web Access no se verán reflejados en la base de datos del servidor SchoolTrack oficial")
	$l_respuesta:=CD_Dlog (0;$t_mensaje;"";__ ("Cancelar");__ ("Continuar"))
Else 
	$l_respuesta:=2
End if 


If ($l_respuesta=2)
	  // ASM agrego validación de licencia STWA
	If (LICENCIA_esModuloAutorizado (1;SchoolTrack Web Access))
		If (INET_IsHostAvailable ($t_host;$l_puerto))
			
			  //ABK: abro la url y cierro 4D
			OPEN URL:C673($t_url)
			QUIT 4D:C291
			
		Else 
			
			  // ABK: 
			  // intento conectarme a la IP y puerto del ***servidor***
			  // si la dirección ip inválida la conexión será exitosa sólo si si el cliente y el servidor está en la misma red local o conectado por vpn
			$t_host:=ST_GetWord (SYS_GetServerProperty (XS_IPaddress);1;",")
			$l_puerto:=Num:C11(SYS_GetServerProperty (110))
			$t_Url:=$t_host+":"+String:C10($l_puerto)+"/stwa/login.shtml"
			If (INET_IsHostAvailable ($t_host;$l_puerto))
				OPEN URL:C673($t_url)
				QUIT 4D:C291
			Else 
				CD_Dlog (0;__ ("El servidor Schooltrack Web Access no está disponible en este momento.\rPor favor intente nuevamente más tarde.")+"\r\r"+__ (" Si el problema persiste, contacte al administrador de SchoolTrack o a un ejecutivo de soporte de Colegium."))
			End if 
		End if 
	Else 
		CD_Dlog (0;__ ("No tiene permisos para ejecutar este módulo."))
	End if 
End if 

