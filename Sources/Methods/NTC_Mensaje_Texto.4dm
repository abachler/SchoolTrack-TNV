//%attributes = {}
  // NTC_Mensaje_Texto(UUIDnotificacion:T; textoMensaje:T:)
  //
  // Recibe y almacena el texto que se visualizará en el Centro de Notificaciones
  // 
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 18/06/12, 14:56:33
  // ---------------------------------------------

C_LONGINT:C283($l_posicionEnBlob)
C_TEXT:C284($t_uuid)

ARRAY TEXT:C222($at_encabezadosColumnas;0)

If (False:C215)
	C_TEXT:C284(NTC_Mensaje_Texto ;$1)
	C_TEXT:C284(NTC_Mensaje_Texto ;$2)
End if 

  // CODIGO
$t_uuid:=$1
$t_texto:=$2

KRL_FindAndLoadRecordByIndex (->[NTC_Notificaciones:190]Auto_UUID:1;->$t_uuid;True:C214)
If (OK=1)
	[NTC_Notificaciones:190]Contenido_texto:7:=$t_texto
	SAVE RECORD:C53([NTC_Notificaciones:190])
	KRL_UnloadReadOnly (->[NTC_Notificaciones:190])
End if 