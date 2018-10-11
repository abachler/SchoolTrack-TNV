//%attributes = {}
  // WEB_Peticion(host:&T; peticion:&T{; puerto{; encabezadoHTTP}})
  // Por: Alberto Bachler: 17/09/13, 13:45:34
  //  ---------------------------------------------
  // Envia una petición a un servidor HTTP y devuelve el resultado
  // host (texto): nombre del servidor o dirección IP
  // peticion (texto): petición 
  // puerto (numerico): numero de puerto (si puerto=0, puerto=80)
  // encabezadoHTTP (texto): texto del encabezado (si encabezadoHTTP="", encabezadoHTTP=" HTTP/1.1\r\n Host: host\r\n\r\n""
  //  ---------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)
C_TEXT:C284($2)

C_LONGINT:C283($l_error;$l_IdConexion;$l_estadoConexion)
C_TEXT:C284($t_buffer;$t_host;$t_peticion;$t_resultadoPeticion;$t_encabezadoHTTP)

If (False:C215)
	C_TEXT:C284(WEB_Peticion ;$0)
	C_TEXT:C284(WEB_Peticion ;$1)
	C_TEXT:C284(WEB_Peticion ;$2)
End if 
$t_host:=$1
$t_peticion:=$2
$l_puerto:=80

$t_host:=Replace string:C233($t_host;"http://";"")

Case of 
	: (Count parameters:C259=4)
		$t_encabezadoHTTP:=$4
		$l_puerto:=$3
		
	: (Count parameters:C259=3)
		$l_puerto:=$3
End case 

If ($l_puerto=0)
	$l_puerto:=80
End if 

If ($t_encabezadoHTTP="")
	$t_encabezadoHTTP:=" HTTP/1.1\r\n"
	$t_encabezadoHTTP:=$t_encabezadoHTTP+"Host: "+$t_host+"\r\n\r\n"
End if 

$l_error:=TCP_Open ($t_host;$l_puerto;$l_IdConexion;0)
$l_error:=TCP_State ($l_IdConexion;$l_estadoConexion)

If ($l_error=0)
	$t_Peticion:="GET /"+$t_Peticion+$t_encabezadoHTTP
	$l_error:=TCP_Send ($l_IdConexion;$t_Peticion)
	If ($l_error=0)
		Repeat 
			$l_error:=TCP_Receive ($l_IdConexion;$t_buffer)
			$l_error:=TCP_State ($l_IdConexion;$l_estadoConexion)
			$t_resultadoPeticion:=$t_resultadoPeticion+$t_buffer
		Until (($l_estadoConexion=0) | ($l_error#0))
	End if 
	$l_error:=TCP_Close ($l_IdConexion)
End if 

$0:=$t_resultadoPeticion

