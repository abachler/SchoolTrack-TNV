//%attributes = {}
  // MSG_ActualizaDesdeIntranet()
  // Por: Alberto Bachler: 18/06/13, 11:38:19
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BLOB:C604($x_Blob)
C_LONGINT:C283($i;$l_proceso)
C_TEXT:C284($t_textoError)

ARRAY LONGINT:C221($al_idMensajes;0)

$t_textoError:=WS_CallIntranetWebService ("WSmsg_ListaIdMensajes_out")

If ($t_textoError="")
	WEB SERVICE GET RESULT:C779($x_Blob;"blobIdMensajes";*)  //20180514 RCH Ticket 206788
End if 

BLOB_Blob2Vars (->$x_Blob;0;->$al_idMensajes)

$l_proceso:=IT_Progress (1;0;0;"Actualizando mensajes usuario...")
For ($i;1;Size of array:C274($al_idMensajes))
	MSG_RecuperaMensaje ($al_idMensajes{$i})
	$l_proceso:=IT_Progress (0;$l_proceso;$i/Size of array:C274($al_idMensajes))
End for 
$l_proceso:=IT_Progress (-1;$l_proceso)

