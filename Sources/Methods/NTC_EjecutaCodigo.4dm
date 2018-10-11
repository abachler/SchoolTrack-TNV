//%attributes = {}
  // NTC_EjecutaCodigo(UUIDmensaje:T; IDprocesoNotificaciones:L)
  //
  // Ejecuta el método de análisis asignado al mensaje
  // y envía un mensaje al proceso que maneja el centro de notificaciones para informar el resultado de la ejecución
  // si el campo [NTC_Notificaciones]Ejecucion_nombreMetodo contiene mas de un segmento separado por ";" el primer segmento es considerado el método y los segmentos restantes los parametros
  // los parametros son pasados al método en una solo cadena separados por punto y coma
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 18/06/12, 13:53:23
  // ---------------------------------------------
C_TEXT:C284($1)
C_LONGINT:C283($2)

C_LONGINT:C283($l_ExecutionResult;$l_NotificationProcessID)
C_TEXT:C284($t_uuid)

If (False:C215)
	C_TEXT:C284(NTC_EjecutaCodigo ;$1)
	C_LONGINT:C283(NTC_EjecutaCodigo ;$2)
End if 

  // CÓDIGO
$t_uuid:=$1
$l_NotificationProcessID:=$2

KRL_FindAndLoadRecordByIndex (->[NTC_Notificaciones:190]Auto_UUID:1;->$t_uuid;False:C215)
$b_PasarParametros:=(ST_CountWords ([NTC_Notificaciones:190]Ejecucion_nombreMetodo:17;1;";")=2)
If ($b_PasarParametros)
	$t_metodo:=ST_GetWord ([NTC_Notificaciones:190]Ejecucion_nombreMetodo:17;1;";")
	$t_parametros:=Substring:C12([NTC_Notificaciones:190]Ejecucion_nombreMetodo:17;Position:C15(";";[NTC_Notificaciones:190]Ejecucion_nombreMetodo:17)+1)
	EXECUTE METHOD:C1007($t_metodo;$l_ExecutionResult;$t_parametros)
Else 
	EXECUTE METHOD:C1007([NTC_Notificaciones:190]Ejecucion_nombreMetodo:17;$l_ExecutionResult)
End if 

IP_SendMessage ($l_NotificationProcessID;"NTC_CodigoEjecutado";String:C10($t_uuid)+";"+String:C10($l_ExecutionResult))

