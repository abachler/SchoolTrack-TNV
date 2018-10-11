//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 31-01-18, 10:16:54
  // ----------------------------------------------------
  // Método: STWA2_ConsultaServicioCondor
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------


C_BLOB:C604($y_blob)
C_LONGINT:C283($l_idAplicacion;$l_idUsuario;$l_tipoUsuario;$l_idColegio;$profID)
C_TEXT:C284($t_llave;$t_llavePrivada;$t_textoAblob;$t_uuidColegio;$t_body;$t_resultado)
C_OBJECT:C1216($o_parametros)

$o_parametros:=$1

$t_accion:=OB Get:C1224($o_parametros;"accion")


Case of 
	: ($t_accion="consultaservicioscondor")
		
		$l_idUsuario:=OB Get:C1224($o_parametros;"usuarioID")
		$profID:=OB Get:C1224($o_parametros;"profesorID")
		$t_uuidColegio:=OB Get:C1224($o_parametros;"uuid_colegio")
		$t_llavePrivada:=OB Get:C1224($o_parametros;"llavePrivada")
		$l_tipoUsuario:=OB Get:C1224($o_parametros;"tipoUsuario")
		$l_idAplicacion:=OB Get:C1224($o_parametros;"idAplicacion")
		PREF_Set (0;"CONDOR_llave_aplicacion";$t_llavePrivada)
		
		Case of 
			: ((<>gRolBD="112233@") | (<>gRolBD="99999@") | (<>gRolBD="88888") | (<>gRolBD="CLGMX"))
				$t_urlCondor:="http://demopersonas.colegium.com/servicios/obtiene_apps_st/"
			Else 
				$t_urlCondor:="http://configuracion.colegium.com/servicios/obtiene_apps_st/"
		End case 
		
		  //genero llave para la consulta
		$t_textoAblob:=$t_uuidColegio+$t_llavePrivada
		TEXT TO BLOB:C554($t_textoAblob;$y_blob;UTF8 text without length:K22:17)
		$t_llave:=SHA512 ($y_blob;Crypto HEX)
		
		  //creo URL para la petición GET
		$t_URL:=$t_urlCondor+String:C10($profID)+"/"+String:C10($l_tipoUsuario)+"/"+$t_uuidColegio+"/"+String:C10($l_idAplicacion)+"/"+$t_llave+"/"
		
		$t_metodoSiError:=Method called on error:C704
		ON ERR CALL:C155("WS_ErrorHandler")
		$ok:=HTTP Request:C1158(HTTP GET method:K71:1;$t_URL;$t_body;$t_resultado)
		ON ERR CALL:C155($t_metodoSiError)
		
		If ($ok#200)
			  // creo Json con el resultado
			C_OBJECT:C1216($ob_raiz)
			$ob_raiz:=OB_Create 
			OB_SET_Boolean ($ob_raiz;True:C214;"error")
			$t_resultado:=OB_Object2Json ($ob_raiz)
			Log_RegisterEvtSTW ("Se produjo un problema en la conexión al consultar el servicio obtiene_apps_st de Colegium Cloud ";$l_idUsuario)
		End if 
	: ($t_accion="loginUsuarioSTWA")
		
		$t_URL:=OB Get:C1224($o_parametros;"url")
		$l_tipoUsuario:=OB Get:C1224($o_parametros;"tipoUsuario")
		$l_idAplicacion:=OB Get:C1224($o_parametros;"idAplicacion")
		$l_idColegio:=OB Get:C1224($o_parametros;"idColegio")
		$profID:=OB Get:C1224($o_parametros;"profesorID")
		$t_llavePrivada:="f6150b819489bfe46e7da82f43e8b637c087d7ff90b7e25754e192fdd0219750"
		
		$t_textoAblob:=String:C10($l_idColegio)+"."+String:C10($profID)+"."+String:C10($l_tipoUsuario)+$t_llavePrivada
		TEXT TO BLOB:C554($t_textoAblob;$y_blob;UTF8 text without length:K22:17)
		$t_llave:=SHA512 ($y_blob;Crypto HEX)
		
		  //genero la Url de conexión y abro el exploradors
		$t_URLaplicacion:=$t_URL+"/"+"loginSSO_externo"+"/"+String:C10($profID)+"/"+String:C10($l_idColegio)+"/"+String:C10($l_tipoUsuario)+"/"+String:C10($l_idAplicacion)+"/"+$t_llave
		
		  // creo Json con el resultado
		C_OBJECT:C1216($ob_raiz)
		$ob_raiz:=OB_Create 
		OB_SET ($ob_raiz;->$t_URLaplicacion;"url")
		$t_resultado:=OB_Object2Json ($ob_raiz)
End case 

$0:=$t_resultado

