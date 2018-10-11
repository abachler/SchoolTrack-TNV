//%attributes = {}
C_LONGINT:C283($nivel;$1)
C_BLOB:C604($settingsBlob;$nivelSettingsBlob)

If (Count parameters:C259=1)
	$nivel:=$1
End if 
  //GENERAL
$ot:=OT New 

OT PutLong ($ot;"intervalo";SN3_DataRecInterval)  //Intervalo de tiempo para el demonio que invoca SN3_ActuaDatos_CapturaDatos, si es 0 el proceso solo funciona manual presionando el boton de la pestaña configuración
OT PutLong ($ot;"revisar_datos";SN3_ActuaDatosReqVerif)  //Activar la revisión de datos antes de actualizar
OT PutLong ($ot;"no_avisar_apoderados";SN3_ActuaDatosNoMailApo)  // No avisar a los apoderados de la actualización de datos via mail de SN3
OT PutLong ($ot;"id_encargado";SN3_ActuaDatosEncargadoID)  //ID Encargado de las revisiones de actualización de datos
OT PutText ($ot;"nombre_encargado";SN3_ActuaDatosEncargado)  //Encargado de las revisiones de actualización de datos
OT PutDate ($ot;"fecha_ini_actuadatos";vd_fecha_ini_actuadatos)  //fecha que se captura al iniciar el proceso
OT PutLong ($ot;"ini_actuadatos";SN3_ActuaDatosActivar)  //Proceso de actualización de datos activada
OT PutLong ($ot;"recibir_datos";SN3_ActuaDatos_RecibirDatos)  //check de minutos para el intervalo de descarga
OT PutArray ($ot;"notificacion_id_usr";SN3_NotificacionUsrID)  //ID de los usuarios del sistema que son avisados de las notificaciones
<>ACTUADATOS_ID_USR_REV:=SN3_ActuaDatosEncargadoID
$settingsBlob:=OT ObjectToNewBLOB ($ot)
OT Clear ($ot)
PREF_SetBlob (0;"SN3DataRecSettings";$settingsBlob)

  //NIVEL
If ($nivel#0)
	$ot:=OT New 
	OT PutLong ($ot;"publica_nivel";SN3_ActuaDatosPublica)
	OT PutArray ($ot;"publicaalumno";SN3_PublicaAlumno)
	OT PutArray ($ot;"editaalumno";SN3_EditaAlumno)
	OT PutArray ($ot;"publicaRF";SN3_PublicaRF)
	OT PutArray ($ot;"editaRF";SN3_EditaRF)
	
	$nivelSettingsBlob:=OT ObjectToNewBLOB ($ot)
	OT Clear ($ot)
	PREF_SetBlob (0;"SN3LevelDataRecSettings_"+String:C10($nivel);$nivelSettingsBlob)
End if 