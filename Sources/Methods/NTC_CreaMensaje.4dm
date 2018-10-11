//%attributes = {}
  // NTC_CreaMensaje(modulo:T; encabezado:T; descripcion:T{; destinatario;L})
  //
  // Crea un mensaje en el centro de notificación.
  // - modulo: el módulo con el que el mensaje puede interactuar
  // - encabezado: título del mensaje
  // - descripción: descripción asociada
  // - destinatario: ID de usuario (por defecto los mensajes son visibles para los usuario del grupo administración con acceso al módulo)
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 18/06/12, 10:45:58
  // ---------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_LONGINT:C283($4)

C_BLOB:C604($x_contenidoBlob;$x_colores_y_estilos)
C_LONGINT:C283($l_IdDestinatario)
C_TEXT:C284($t_contenidoTexto;$t_descripcion;$t_TituloVentana)
C_TEXT:C284($t_uuid)  //20170218 RCH-SP
If (False:C215)
	C_TEXT:C284(NTC_CreaMensaje ;$1)
	C_TEXT:C284(NTC_CreaMensaje ;$2)
	C_TEXT:C284(NTC_CreaMensaje ;$3)
	C_LONGINT:C283(NTC_CreaMensaje ;$4)
End if 


  // CÓDIGO
$t_nombreModulo:=$1
$t_encabezado:=$2
$t_descripcion:=$3
If (Count parameters:C259=4)
	$l_IdDestinatario:=$4
End if 


CREATE RECORD:C68([NTC_Notificaciones:190])
[NTC_Notificaciones:190]Explorador_modulo:13:=$t_nombreModulo
[NTC_Notificaciones:190]Encabezado:12:=$t_encabezado
[NTC_Notificaciones:190]Fecha_creacion:2:=Current date:C33(*)
[NTC_Notificaciones:190]Hora_creacion:3:=Current time:C178(*)
[NTC_Notificaciones:190]Destinatario_ID:4:=$l_IdDestinatario
[NTC_Notificaciones:190]Descripción:6:=$t_descripcion
If ($l_IdDestinatario>0)
	[NTC_Notificaciones:190]Destinatario_nombre:5:=USR_GetUserName ([NTC_Notificaciones:190]Destinatario_ID:4;3)
End if 
SAVE RECORD:C53([NTC_Notificaciones:190])
$t_uuid:=[NTC_Notificaciones:190]Auto_UUID:1
  //$0:=[NTC_Notificaciones]Auto_UUID

UNLOAD RECORD:C212([NTC_Notificaciones:190])



$l_IdProcesoNC:=Process number:C372("Notificaciones")
If ($l_IdProcesoNC>0)
	IP_SendMessage ($l_IdProcesoNC;"NTC_NuevoMensaje")
End if 

If (Not:C34(Undefined:C82(<>alXS_ModuleProcessID)))
	For ($i;1;Size of array:C274(<>alXS_ModuleProcessID))
		IP_SendMessage (<>alXS_ModuleProcessID{$i};"NTC_NuevoMensaje")
	End for 
End if 

$0:=$t_uuid