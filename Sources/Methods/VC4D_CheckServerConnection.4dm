//%attributes = {}
  // VC4D_CheckServerConnection()
  //
  //
  // creado por: Alberto Bachler Klein: 05-02-16, 12:12:22
  // -----------------------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_TEXT:C284($4)
C_TEXT:C284($5)

C_BLOB:C604($x_parametros)
C_BOOLEAN:C305($b_validUser)
C_POINTER:C301($y_NS;$y_password;$y_URL;$y_userName;$y_WSN)
C_TEXT:C284($t_errorWS;$t_NS;$t_password;$t_respuesta;$t_URL;$t_userName;$t_WSN)
C_OBJECT:C1216($ob_parametros)


If (False:C215)
	C_TEXT:C284(VC4D_CheckServerConnection ;$0)
	C_TEXT:C284(VC4D_CheckServerConnection ;$1)
	C_TEXT:C284(VC4D_CheckServerConnection ;$2)
	C_TEXT:C284(VC4D_CheckServerConnection ;$3)
	C_TEXT:C284(VC4D_CheckServerConnection ;$4)
	C_TEXT:C284(VC4D_CheckServerConnection ;$5)
End if 

If (Count parameters:C259=5)
	$t_userName:=$1
	$t_password:=$2
	$t_URL:=$3
	$t_WSN:=$4
	$t_NS:=$5
Else 
	$t_userName:=(OBJECT Get pointer:C1124(Object named:K67:5;"userName"))->
	$t_password:=(OBJECT Get pointer:C1124(Object named:K67:5;"password"))->
	$t_URL:=(OBJECT Get pointer:C1124(Object named:K67:5;"URL"))->
	$t_WSN:=(OBJECT Get pointer:C1124(Object named:K67:5;"webServiceName"))->
	$t_NS:=(OBJECT Get pointer:C1124(Object named:K67:5;"namespace"))->
End if 


OB SET:C1220($ob_parametros;"user";$t_userName)
OB SET:C1220($ob_parametros;"passw";$t_password)
VARIABLE TO BLOB:C532($ob_parametros;$x_parametros)

WEB SERVICE SET PARAMETER:C777("data";$x_parametros)
$t_errorWS:=VC4D_CallWebService ("VC4Dws_CheckServerConnection";$t_URL;$t_WSN;$t_NS)

If ($t_errorWS="")
	WEB SERVICE GET RESULT:C779($t_respuesta;"isValid";*)  //20180514 RCH Ticket 206788
End if 

$0:=Choose:C955($t_errorWS="";$t_respuesta;"Sin conexión")

