//%attributes = {}
C_LONGINT:C283($nivel;$1)
C_BLOB:C604($settingsBlob;$nivelSettingsBlob)

If (Count parameters:C259=1)
	$nivel:=$1
Else 
	$nivel:=0
End if 

SN3_InitDataReceptionSettings 

$ot:=OT New 

OT PutLong ($ot;"intervalo";SN3_DataRecInterval)  //Intervalo de tiempo para el demonio que invoca SN3_ActuaDatos_CapturaDatos, si es 0 el proceso solo funciona manual presionando el boton de la pestaña configuración
OT PutLong ($ot;"revisar_datos";SN3_ActuaDatosReqVerif)  //Activar la revisión de datos antes de actualizar
OT PutLong ($ot;"no_avisar_apoderados";SN3_ActuaDatosNoMailApo)  // No avisar a los apoderados de la actualización de datos via mail de SN3
OT PutLong ($ot;"id_encargado";SN3_ActuaDatosEncargadoID)  //ID Encargado de las revisiones de actualización de datos
OT PutText ($ot;"nombre_encargado";SN3_ActuaDatosEncargado)  //Nombre Encargado de las revisiones de actualización de datos
OT PutDate ($ot;"fecha_ini_actuadatos";vd_fecha_ini_actuadatos)  //fecha que se captura al iniciar el proceso
OT PutLong ($ot;"ini_actuadatos";SN3_ActuaDatosActivar)  //Proceso de actualización de datos activada
OT PutLong ($ot;"recibir_datos";SN3_ActuaDatos_RecibirDatos)  //check de minutos para el intervalo de descarga
OT PutArray ($ot;"notificacion_id_usr";SN3_NotificacionUsrID)  //ID de los usuarios del sistema que son avisados de las notificaciones

$settingsBlob:=OT ObjectToNewBLOB ($ot)
OT Clear ($ot)
$settingsBlob:=PREF_fGetBlob (0;"SN3DataRecSettings";$settingsBlob)

  //LECTURA DE OPCIONES GENERALES
$ot:=OT BLOBToObject ($settingsBlob)

SN3_DataRecInterval:=OT GetLong ($ot;"intervalo")
SN3_ActuaDatosReqVerif:=OT GetLong ($ot;"revisar_datos")
SN3_ActuaDatosNoMailApo:=OT GetLong ($ot;"no_avisar_apoderados")
SN3_ActuaDatosEncargadoID:=OT GetLong ($ot;"id_encargado")
SN3_ActuaDatosEncargado:=OT GetText ($ot;"nombre_encargado")
vd_fecha_ini_actuadatos:=OT GetDate ($ot;"fecha_ini_actuadatos")
SN3_ActuaDatosActivar:=OT GetLong ($ot;"ini_actuadatos")
SN3_ActuaDatos_RecibirDatos:=OT GetLong ($ot;"recibir_datos")

  //OT GetArray ($ot;"camposRF";SN3_ListaCamposRF)
  //OT GetArray ($ot;"camposalumno";SN3_ListaCamposAlumno)
OT GetArray ($ot;"notificacion_id_usr";SN3_NotificacionUsrID)
OT Clear ($ot)

<>ACTUADATOS_ID_USR_REV:=SN3_ActuaDatosEncargadoID

If ($nivel#0)
	  //CONFIGURACIÖN ESPECIFICA POR NIVEL (Publicación)
	$ot:=OT New 
	OT PutLong ($ot;"publica_nivel";SN3_ActuaDatosPublica)
	OT PutArray ($ot;"publicaalumno";SN3_PublicaAlumno)
	OT PutArray ($ot;"editaalumno";SN3_EditaAlumno)
	OT PutArray ($ot;"publicaRF";SN3_PublicaRF)
	OT PutArray ($ot;"editaRF";SN3_EditaRF)
	
	$nivelSettingsBlob:=OT ObjectToNewBLOB ($ot)
	OT Clear ($ot)
	$nivelSettingsBlob:=PREF_fGetBlob (0;"SN3LevelDataRecSettings_"+String:C10($nivel);$nivelSettingsBlob)
	
	  //LECTURA DE OPCIONES POR NIVEL
	$ot:=OT BLOBToObject ($nivelSettingsBlob)
	SN3_ActuaDatosPublica:=OT GetLong ($ot;"publica_nivel")
	OT GetArray ($ot;"publicaalumno";SN3_PublicaAlumno)
	OT GetArray ($ot;"editaalumno";SN3_EditaAlumno)
	OT GetArray ($ot;"publicaRF";SN3_PublicaRF)
	OT GetArray ($ot;"editaRF";SN3_EditaRF)
	OT Clear ($ot)
	
End if 

  //IT_SetButtonState ((SN3_ActuaDatosPublica=1);->SN3_ActuaDatosReqVerif;->SN3_ActuaDatosNoMailApo)