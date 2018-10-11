//%attributes = {}
  // NTC_Mensaje_Arreglos(UUIDnotificacion:T; arregloEncabezado:Y; arregloColumna1:Y{;...;arregloColumnaN:Y)
  //
  // Almacena en un blob en el registro los arreglos que se visualizarán en el Centro de Notificaciones
  // El primer arreglo debe contener los títulos de las columnas
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 18/06/12, 14:56:33
  // ---------------------------------------------
C_TEXT:C284($1)
C_POINTER:C301(${2})

C_LONGINT:C283($l_posicionEnBlob)
C_POINTER:C301($y_arregloColumna;$y_arregloEncabezados)
C_TEXT:C284($t_uuid)

ARRAY TEXT:C222($at_encabezadosColumnas;0)

If (False:C215)
	C_TEXT:C284(NTC_Mensaje_Arreglos ;$1)
	C_POINTER:C301(NTC_Mensaje_Arreglos ;${2})
End if 

  // CODIGO
$t_uuid:=$1
$y_arregloEncabezados:=$2

KRL_FindAndLoadRecordByIndex (->[NTC_Notificaciones:190]Auto_UUID:1;->$t_uuid;True:C214)
If (OK=1)
	$l_posicionEnBlob:=BLOB_Variables2Blob (->[NTC_Notificaciones:190]Contenido_arreglos:8;$l_posicionEnBlob;$y_arregloEncabezados)
	For ($i;3;Count parameters:C259)
		$y_arregloColumna:=${$i}
		$l_posicionEnBlob:=BLOB_Variables2Blob (->[NTC_Notificaciones:190]Contenido_arreglos:8;$l_posicionEnBlob;$y_arregloColumna)
	End for 
	SAVE RECORD:C53([NTC_Notificaciones:190])
	KRL_UnloadReadOnly (->[NTC_Notificaciones:190])
End if 