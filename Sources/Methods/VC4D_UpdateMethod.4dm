//%attributes = {}
  // VC4D_UpdateMethod()
  // Por: Alberto Bachler K.: 01-10-14, 10:04:19
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BLOB:C604($0)
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)

C_BLOB:C604($x_blob;$x_Code;$x_parametros;$x_respuesta)
C_OBJECT:C1216($o_atributos;$o_Parametros)
C_DATE:C307($d_fecha)
C_LONGINT:C283($l_pathType;$l_resultado)
C_TIME:C306($h_hora)
C_POINTER:C301($y_NS;$y_table;$y_URL;$y_WSN)
C_TEXT:C284($t_code;$t_comments;$t_dts;$t_errorWS;$t_formObjectName;$t_methodPath;$t_objectName;$t_password;$t_UserName)


If (False:C215)
	C_BLOB:C604(VC4D_UpdateMethod ;$0)
	C_TEXT:C284(VC4D_UpdateMethod ;$1)
	C_TEXT:C284(VC4D_UpdateMethod ;$2)
	C_TEXT:C284(VC4D_UpdateMethod ;$3)
End if 

$t_methodPath:=$1
$t_UserName:=$2
$t_password:=$3

METHOD RESOLVE PATH:C1165($t_methodPath;$l_pathType;$y_table;$t_objectName;$t_formObjectName;*)
METHOD GET CODE:C1190($t_methodPath;$t_code;*)
METHOD GET MODIFICATION DATE:C1170($t_methodPath;$d_fecha;$h_hora;*)
If ($l_pathType=Path project method:K72:1)
	METHOD GET ATTRIBUTES:C1334($t_methodPath;$o_atributos;*)
End if 
If (($l_pathType=Path project method:K72:1) | ($l_pathType=Path database method:K72:2) | ($l_pathType=Path trigger:K72:4))
	METHOD GET COMMENTS:C1189($t_methodPath;$t_comments;*)
End if 

$t_dts:=DTS_Get_GMT_TimeStamp ($d_fecha;$h_hora)
  //TEXT TO BLOB($t_code;$x_code;UTF8 text without length)
  //COMPRESS BLOB($x_code;GZIP best compression mode)

$o_Parametros:=OB_Create 
OB_SET ($o_Parametros;->$t_UserName;"user")
OB_SET ($o_Parametros;->$t_password;"passw")
OB_SET ($o_Parametros;->$t_methodPath;"path")
OB_SET ($o_Parametros;->$t_code;"code")
OB_SET ($o_Parametros;->$t_dts;"dts")
OB_SET ($o_Parametros;->$o_atributos;"atributos")
OB_SET ($o_Parametros;->$t_comments;"comentarios")

$l_resultado:=OB_ObjectToBlob (->$o_Parametros;->$x_parametros)


  //  //TEXT TO BLOB($t_json;$x_parametros;UTF8 text without length)
  //$l_HLcrypt:=Load list("Crypt")
  //GET LIST ITEM PARAMETER($l_HLcrypt;1;"priv";$t_llavePrivada)
  //TEXT TO BLOB($t_llavePrivada;$x_llavePrivada;UTF8 text without length)
  //ENCRYPT BLOB($x_parametros;$x_llavePrivada)
  //BASE64 ENCODE($x_parametros;$t_json)

$y_URL:=OBJECT Get pointer:C1124(Object named:K67:5;"URL")
$y_WSN:=OBJECT Get pointer:C1124(Object named:K67:5;"webServiceName")
$y_NS:=OBJECT Get pointer:C1124(Object named:K67:5;"nameSpace")

WEB SERVICE SET PARAMETER:C777("data";$x_parametros)
$t_errorWS:=VC4D_CallWebService ("VC4Dws_UpdateMethod";$y_URL->;$y_WSN->;$y_NS->)

If ($t_errorWS="")
	WEB SERVICE GET RESULT:C779($x_respuesta;"output";*)  //20180514 RCH Ticket 206788
	$0:=$x_respuesta
Else 
	ALERT:C41("Error: "+$t_errorWS)
End if 