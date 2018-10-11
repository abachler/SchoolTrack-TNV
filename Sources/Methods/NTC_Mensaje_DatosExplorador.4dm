//%attributes = {}
  // NTC_Mensaje_DatosExplorador(UUIDmensaje:T; nombreModulo:T; referenciaPestaña:L; arregloRecNums:Y{; metodoPostDespliegue:T{; método antes despliegue}})
  //
  // Almacena en el registro de la notificación la información necesaria al despliegue
  // - UUID del mensaje
  // - Nombre del módulo en que se despliega la información
  // - Pestaña a activar en el módulo
  // - Puntero sobre un arreglo que contiene los numeros de registros a mostrar en el explorador
  // - Método a ejecutar en el explorador DESPUES de la carga de registros
  // - Método a ejecutar en el explorador ANTES de la carga de registros
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 18/06/12, 15:13:44
  // ---------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($2)
C_LONGINT:C283($3)
C_POINTER:C301($4)
C_TEXT:C284($5)
C_TEXT:C284($6)

C_BLOB:C604($x_blob)
C_BOOLEAN:C305($b_asserted)
C_LONGINT:C283($l_referenciaPestaña)
C_POINTER:C301($y_recordNumbers)
C_TEXT:C284($t_metodo_a_ejecutar;$t_metodo_a_ejecutar_Antes;$t_nombreModulo;$t_uuid)

If (False:C215)
	C_TEXT:C284(NTC_Mensaje_DatosExplorador ;$1)
	C_TEXT:C284(NTC_Mensaje_DatosExplorador ;$2)
	C_LONGINT:C283(NTC_Mensaje_DatosExplorador ;$3)
	C_POINTER:C301(NTC_Mensaje_DatosExplorador ;$4)
	C_TEXT:C284(NTC_Mensaje_DatosExplorador ;$5)
	C_TEXT:C284(NTC_Mensaje_DatosExplorador ;$6)
End if 

  // CODIGO

If (Asserted:C1132(Count parameters:C259>=4;"No se recibieron los argumentos necesarios"))
	$t_uuid:=$1
	$t_nombreModulo:=$2
	$l_referenciaPestaña:=$3
	$y_recordNumbers:=$4
	BLOB_Variables2Blob (->$x_blob;0;$y_recordNumbers)
	
	Case of 
		: (Count parameters:C259=6)
			$t_metodo_a_ejecutar:=$5
			$t_metodo_a_ejecutar_Antes:=$6
		: (Count parameters:C259=5)
			$t_metodo_a_ejecutar:=$5
	End case 
	
	KRL_FindAndLoadRecordByIndex (->[NTC_Notificaciones:190]Auto_UUID:1;->$t_uuid;True:C214)
	$b_asserted:=Asserted:C1132(OK=1;"La notificación no existe o no se ha podido acceder en escritura")
	$b_asserted:=Asserted:C1132($b_asserted | ($t_nombreModulo=[NTC_Notificaciones:190]Explorador_modulo:13);"El modulo pasado en argumento no corresponde al módulo registrado en la notificación")
	
	If ($b_asserted)
		[NTC_Notificaciones:190]Explorador_pestaña:14:=$l_referenciaPestaña
		[NTC_Notificaciones:190]Explorador_registros:15:=$x_blob
		[NTC_Notificaciones:190]Explorador_ejecutarDespues:21:=$t_metodo_a_ejecutar
		[NTC_Notificaciones:190]Explorador_ejecutarAntes:20:=$t_metodo_a_ejecutar_Antes
		SAVE RECORD:C53([NTC_Notificaciones:190])
		KRL_UnloadReadOnly (->[NTC_Notificaciones:190])
	End if 
End if 