If (LICENCIA_esModuloAutorizado (1;12))  //20130227 RCH Se valida licencia.
	C_TEXT:C284($url;$crlf;$req;$content;$buffer;$host)
	C_REAL:C285($err;$status)
	C_LONGINT:C283($c)
	C_BLOB:C604($xBlob)
	C_BOOLEAN:C305($b_ambienteCertificacion)
	
	$b_ambienteCertificacion:=(Num:C11(PREF_fGet (0;"ACT_AMBIENTE_CERTIFICACION_SII";"1"))=1)
	
	If ($b_ambienteCertificacion)
		$host:="pruebas.dtecolegium.com"
		$url:="http://"+$host+"/dteNet/"  //20140220 RCH Cambio la IP
		$url:=PREF_fGet (0;"ACT_URLCERTDTENET";$url)
	Else 
		$host:="www.dtecolegium.com"
		$url:="http://"+$host+":8080/dteNet/"
		$url:=PREF_fGet (0;"ACT_URLDTENET";$url)
	End if 
	
	  //probar acceso a http://www.dtecolegium.com:8080/dteNet/
	  //$url:="http://www.dtecolegium.com:8080/dteNet/"
	$crlf:="\r"+Char:C90(10)
	$req:="GET "+$url+" HTTP/1.1"+$crlf
	$req:=$req+"Host: "+$url+$crlf
	$req:=$req+"Accept: */*"+$crlf
	$req:=$req+"Connection: close"+$crlf
	$req:=$req+"If-Modified-Since: Fri, 16 Mar 2001 13:05:00 GMT"+$crlf
	$req:=$req+"User-Agent: eAccountTrack"+$crlf
	$req:=$req+"UA-OS: MacOS"+$crlf
	$req:=$req+"UA-CPU: PPC"+$crlf
	$req:=$req+"Extension: Security/Remote-Passphrase"+$crlf+$crlf
	$err:=IT_SetTimeOut (120)
	$err:=TCP_OpenURL ($host;8080;->$c)
	
	  //DELAY PROCESS(Current process;80)
	
	If ($err=0)
		
		$err:=TCP_State ($c;$status)
		$err:=$err+TCP_Send ($c;$req)
		If ($err=0)
			$content:=""
			$status:=0
			Repeat 
				$err:=TCP_Receive ($c;$buffer)
				$err:=TCP_State ($c;$status)
				$content:=$content+$buffer
			Until (($status=0) | ($err#0))
		Else 
			$content:="ConnectionError"
		End if 
		$err:=TCP_Close ($c)
		  //DELAY PROCESS(Current process;40)
	Else 
		$content:="ConnectionError"
	End if 
	CONVERT FROM TEXT:C1011($content;"MacRoman";$xBlob)
	$content:=Convert to text:C1012($xBlob;"UTF-8")
	If (($content#"ConnectionError") & ($content#"") & (Position:C15(" 200 OK";$content)>0))
		CD_Dlog (0;"Conexión OK a: "+$host+".")
	Else 
		CD_Dlog (0;"Error de conexión a: "+$url+"."+"\r\r"+"Respuesta: "+Substring:C12($content;1;150)+"...")
	End if 
Else 
	CD_Dlog (0;__ ("Para configurar la emisión de los Documentos Tributarios Electrónicos (DTE) debe contactar a Colegium para que el módulo sea activado."+"\r\r"+"Si el módulo ya fue activado registre licencia y vuelva a intentarlo."))
End if 