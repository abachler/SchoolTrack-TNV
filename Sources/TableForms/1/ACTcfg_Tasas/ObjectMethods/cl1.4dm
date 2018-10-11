$yearStr:=String:C10(alACT_IPCYears{alACT_IPCYears})
$proc:=IT_UThermometer (1;0;__ ("Estableciendo conexión con SII..."))

  //20171018 RCH
  //$url:=Replace string(vtACT_URLUTMSII;"AAAA";$yearStr)
If (Num:C11($yearStr)>=2013)
	$url:=Replace string:C233(vtACT_URLUTMSII_2017;"AAAA";$yearStr)
Else 
	$url:=Replace string:C233(vtACT_URLUTMSII_PRE2017;"AAAA";$yearStr)
End if 

$crlf:="\r"+Char:C90(10)
$req:="GET "+$url+" HTTP/1.1"+$crlf
$req:=$req+"Host: "+"http://www.sii.cl"+$crlf
$req:=$req+"Accept: */*"+$crlf
$req:=$req+"Accept-Language: es-cl, en;q=0.5"+$crlf
$req:=$req+"Connection: close"+$crlf
$req:=$req+"If-Modified-Since: Fri, 16 Mar 2001 13:05:00 GMT"+$crlf
$req:=$req+"User-Agent: eAccountTrack"+$crlf
$req:=$req+"UA-OS: MacOS"+$crlf
$req:=$req+"UA-CPU: PPC"+$crlf
$req:=$req+"Extension: Security/Remote-Passphrase"+$crlf+$crlf
$err:=IT_SetTimeOut (120)
  //$err:=TCP_Open ("www.sii.cl";80;$c)
C_LONGINT:C283($c)
$err:=TCP_OpenURL ("www.sii.cl";80;->$c)
DELAY PROCESS:C323(Current process:C322;80)




If ($err=0)
	IT_UThermometer (0;$proc;__ ("Obteniendo valores IPC para el año ")+$yearStr+__ ("..."))
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
	IT_UThermometer (0;$proc;__ ("Cerrando conexión con SII..."))
	$err:=TCP_Close ($c)
	DELAY PROCESS:C323(Current process:C322;40)
Else 
	$content:="ConnectionError"
End if 
If (($content#"ConnectionError") & ($content#""))
	IT_UThermometer (0;$proc;__ ("Recalculando valores UF..."))
	ACTmyt_SincronizaSII ($content;$yearStr)
Else 
	CD_Dlog (0;__ ("Se ha producido un error de conexión con el servidor de SII. Por favor intente con el botón Visitar SII (IPC)."))
End if 
IT_UThermometer (-2;$proc)