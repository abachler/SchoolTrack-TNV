//%attributes = {}
  // NTC_Mensaje_EstilosColores(UUID:T; arregloEstilos:Y arregloColores:Y )
  //
  // Almacena en el registro de la notificación los arreglos con estilos y colores de las filas a mostrar
  // en la lista de errores y advertencias
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 18/06/12, 16:31:09
  // ---------------------------------------------
C_TEXT:C284($1)
C_POINTER:C301($2)
C_POINTER:C301($3)

C_LONGINT:C283($l_posicionEnBlob)
C_POINTER:C301($y_arregloColores;$y_arregloEstilos)
C_TEXT:C284($t_uuid)

If (False:C215)
	C_TEXT:C284(NTC_Mensaje_EstilosColores ;$1)
	C_POINTER:C301(NTC_Mensaje_EstilosColores ;$2)
	C_POINTER:C301(NTC_Mensaje_EstilosColores ;$3)
End if 

  // CODIGO
$t_uuid:=$1
$y_arregloEstilos:=$2
$y_arregloColores:=$3

KRL_FindAndLoadRecordByIndex (->[NTC_Notificaciones:190]Auto_UUID:1;->$t_uuid;True:C214)
If (OK=1)
	$l_posicionEnBlob:=BLOB_Variables2Blob (->[NTC_Notificaciones:190]Colores_estilos:9;$l_posicionEnBlob;$y_arregloEstilos;$y_arregloColores)
	SAVE RECORD:C53([NTC_Notificaciones:190])
	KRL_UnloadReadOnly (->[NTC_Notificaciones:190])
End if 
