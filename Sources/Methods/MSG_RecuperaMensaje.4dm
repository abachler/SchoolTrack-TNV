//%attributes = {}
  // MSG_RecuperaMensaje()
  // Por: Alberto Bachler: 13/06/13, 15:44:48
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($0)
C_LONGINT:C283($1)

C_BLOB:C604($x_blobRegistro)
C_LONGINT:C283($l_IdMensaje;$l_recNum;$l_tipo)
C_TEXT:C284($t_accion;$t_componente;$t_dts;$t_mensaje;$t_modulo;$t_Referencia;$t_textoError)

If (False:C215)
	C_LONGINT:C283(MSG_RecuperaMensaje ;$0)
	C_LONGINT:C283(MSG_RecuperaMensaje ;$1)
End if 

$l_IdMensaje:=$1
WEB SERVICE SET PARAMETER:C777("id";$l_IdMensaje)

$t_textoError:=WS_CallIntranetWebService ("WSmsg_RecuperaMensaje_out")

vlMSG_Resultado:=-1
If ($t_textoError="")
	WEB SERVICE GET RESULT:C779($x_blobRegistro;"blobRegistro";*)
End if 

  //$l_IdMensaje:=$0
BLOB_Blob2Vars (->$x_blobRegistro;0;->$l_IdMensaje;->$t_modulo;->$t_componente;->$t_accion;->$l_tipo;->$t_Referencia;->$t_mensaje;->$t_dts)
If ($l_IdMensaje#0)
	$l_recNum:=KRL_FindAndLoadRecordByIndex (->[xShell_MensajesAplicacion:244]ID:5;->$l_IdMensaje;True:C214)
	If ($l_recNum<0)
		CREATE RECORD:C68([xShell_MensajesAplicacion:244])
	End if 
	[xShell_MensajesAplicacion:244]ID:5:=$l_IdMensaje
	[xShell_MensajesAplicacion:244]Modulo:1:=$t_modulo
	[xShell_MensajesAplicacion:244]Componente:2:=$t_componente
	[xShell_MensajesAplicacion:244]Acción:3:=$t_accion
	[xShell_MensajesAplicacion:244]Tipo:6:=$l_tipo
	[xShell_MensajesAplicacion:244]Referencia:7:=$t_Referencia
	[xShell_MensajesAplicacion:244]Mensaje:4:=$t_mensaje
	[xShell_MensajesAplicacion:244]DTS_modificacion:8:=$t_dts
	SAVE RECORD:C53([xShell_MensajesAplicacion:244])
End if 

