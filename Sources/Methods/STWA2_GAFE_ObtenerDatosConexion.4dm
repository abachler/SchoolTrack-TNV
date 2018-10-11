//%attributes = {}
  // Método: STWA2_GAFE_ObtenerDatosConexion
  // código original de: ??
  // modificado por Alberto Bachler Klein, 28/06/18, 17:46:03
  // reemplazo de plugin JSON (Json strip white spaces)declaración de variables, gestión de prubas
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_TEXT:C284($t_codigoPais;$t_rolDB;$t_respuesta2;$t_request)
C_LONGINT:C283($1;$l_idProfesor)



If (Count parameters:C259=1)
	  // esto es real! se recibe un parametro
	$l_idProfesor:=$1
	$t_codigoPais:=Lowercase:C14(<>vtXS_CountryCode)
	$t_rolDB:=<>gRolBD
Else 
	  // esta es una prueba
	$t_codigoPais:="cl"
	$t_rolDB:="101010"
	$l_idProfesor:=489
End if 

$t_body:="id="+String:C10($l_idProfesor)+"&codpais="+$t_codigoPais+"&rol="+$t_rolDB+"&tk="+STWA2_GAFE_Llaves ($l_idProfesor)
$t_url:="/api/snt/usuarios/aupgafe"
$t_request:="POST "+$t_url+" HTTP/1.1"+"\r\n"
$t_request:=$t_request+"Host: sso.colegium.com"+"\r\n"
$t_request:=$t_request+"Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"+"\r\n"
$t_request:=$t_request+"Content-Length: "+String:C10(Length:C16($t_body))+"\r\n"
$t_request:=$t_request+"Content-Type: application/x-www-form-urlencoded"+"\r\n"
$t_request:=$t_request+"Accept-Language: es-ES,es;q=0.8,en-US;q=0.5,en;q=3"+"\r\n"
$t_request:=$t_request+"Accept-Encoding: gzip, deflate"+"\r\n"
$t_request:=$t_request+"Connection: close"+"\r\n"+"\r\n"

$l_error:=TCP_Open ("sso.colegium.com";40000;$l_idConnection)

If ($l_error=0)
	$l_error:=TCP_State ($l_idConnection;$l_status)
	$l_error:=$l_error+TCP_Send ($l_idConnection;$t_request+$t_body)
	If ($l_error=0)
		$t_respuesta:=""
		$l_status:=0
		Repeat 
			$l_error:=TCP_Receive ($l_idConnection;$t_buffer)
			$l_error:=TCP_State ($l_idConnection;$l_status)
			$t_respuesta:=$t_respuesta+$t_buffer
		Until (($l_status=0) | ($l_error#0))
		$t_respuesta:=Substring:C12($t_respuesta;Position:C15("\r\n\r\n";$t_respuesta)+4)
		$t_respuesta:=ST_ClearSpaces ($t_respuesta)
	Else 
		$t_respuesta:="ConnectionError"
	End if 
	$l_error:=TCP_Close ($l_idConnection)
Else 
	$t_respuesta:="ConnectionError"
End if 
$0:=$t_respuesta