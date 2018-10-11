//%attributes = {}
  // NTC_Mensaje_MetodoAsociado(UUID:T; método:T; mensajeSiFalla:T; mensajeSiExito;T)
  // 
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 18/06/12, 16:40:12
  // ---------------------------------------------





  // CÓDIGO
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_TEXT:C284($4)

C_BOOLEAN:C305($b_avisoPostEjecucion)
C_TEXT:C284($t_textoItemEjecucion;$t_mensajeFalla;$t_mensajeExito;$t_nombreMetodo;$t_uuid)

If (False:C215)
	C_TEXT:C284(NTC_Mensaje_MetodoAsociado ;$1)
	C_TEXT:C284(NTC_Mensaje_MetodoAsociado ;$2)
	C_TEXT:C284(NTC_Mensaje_MetodoAsociado ;$3)
	C_TEXT:C284(NTC_Mensaje_MetodoAsociado ;$4)
	C_TEXT:C284(NTC_Mensaje_MetodoAsociado ;$5)
End if 

  // CODIGO PRINCIPAL
$t_uuid:=$1
$t_nombreMetodo:=$2

Case of 
	: (Count parameters:C259=5)
		$t_mensajeFalla:=$3
		$t_mensajeExito:=$4
		$t_textoItemEjecucion:=$5
		
	: (Count parameters:C259=4)
		$t_mensajeFalla:=$3
		$t_mensajeExito:=$4
		
	: (Count parameters:C259=3)
		$t_mensajeFalla:=$4
		
End case 

KRL_FindAndLoadRecordByIndex (->[NTC_Notificaciones:190]Auto_UUID:1;->$t_uuid;True:C214)
[NTC_Notificaciones:190]Ejecucion_nombreMetodo:17:=$t_nombreMetodo
[NTC_Notificaciones:190]Ejecucion_MensajeFalla:19:=$t_mensajeFalla
[NTC_Notificaciones:190]Ejecucion_MensajeExito:18:=$t_mensajeExito
[NTC_Notificaciones:190]Ejecucion_TextoItem:26:=$t_textoItemEjecucion
SAVE RECORD:C53([NTC_Notificaciones:190])
KRL_ReloadAsReadOnly (->[NTC_Notificaciones:190])
