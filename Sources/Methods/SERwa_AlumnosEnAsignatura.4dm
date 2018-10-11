//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Roberto Catalán
  // Fecha y hora: 11-05-18, 11:23:34
  // ----------------------------------------------------
  // Método: SERwa_AlumnosEnAsignatura
  // Descripción
  // Retorna información de asignaturas del profesor
  //
  // Parámetros
  // ----------------------------------------------------

C_TEXT:C284($0)
C_POINTER:C301($y_Names;$y_Data;$1;$2)

$y_Names:=$1
$y_Data:=$2

C_TEXT:C284($t_uuid1;$t_uuid2;$t_llave)
$t_uuid1:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"param1")
$t_uuid2:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"param2")
$t_llave:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"autentificacion")
If ($t_llave=XCRwa_GeneraLlave ($t_uuid1;$t_uuid2))
	
	C_TEXT:C284($t_asignaturas)
	C_OBJECT:C1216($ob_asignaturas)
	ARRAY TEXT:C222($at_uuidAsignaturas;0)
	ARRAY OBJECT:C1221($ao_respuestas;0)
	C_OBJECT:C1216($ob_respuesta;$ob_respuestaCopia)
	
	$t_asignaturas:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"asignaturas")
	$ob_asignaturas:=JSON Parse:C1218($t_asignaturas)
	OB GET ARRAY:C1229($ob_asignaturas;"asignaturas";$at_uuidAsignaturas)
	If (Size of array:C274($at_uuidAsignaturas)>0)
		C_LONGINT:C283($l_indice)
		For ($l_indice;1;Size of array:C274($at_uuidAsignaturas))
			READ ONLY:C145([Asignaturas:18])
			READ ONLY:C145([Alumnos_Calificaciones:208])
			READ ONLY:C145([Alumnos:2])
			
			KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]auto_uuid:12;->$at_uuidAsignaturas{$l_indice})
			If (Records in selection:C76([Asignaturas:18])=1)
				EV2_RegistrosDeLaAsignatura ([Asignaturas:18]Numero:1)
				If (Records in selection:C76([Alumnos_Calificaciones:208])>0)
					KRL_RelateSelection (->[Alumnos:2]numero:1;->[Alumnos_Calificaciones:208]ID_Alumno:6;"")
					SELECTION TO ARRAY:C260([Alumnos:2]auto_uuid:72;$at_uuidsAlumnos)
					OB SET:C1220($ob_respuesta;"uuidasignaturas";$at_uuidAsignaturas{$l_indice})
					OB SET:C1220($ob_respuesta;"anio";<>gYear)
					OB SET:C1220($ob_respuesta;"error";"")
					OB SET ARRAY:C1227($ob_respuesta;"alumnos";$at_uuidsAlumnos)
				Else 
					OB SET:C1220($ob_respuesta;"uuidasignaturas";$at_uuidAsignaturas{$l_indice})
					OB SET:C1220($ob_respuesta;"error";"Asignatura sin alumnos inscritos.")
				End if 
			Else 
				OB SET:C1220($ob_respuesta;"uuidasignaturas";$at_uuidAsignaturas{$l_indice})
				OB SET:C1220($ob_respuesta;"error";"Asignatura no encontrada.")
			End if 
			$ob_respuestaCopia:=OB Copy:C1225($ob_respuesta)
			APPEND TO ARRAY:C911($ao_respuestas;$ob_respuestaCopia)
		End for 
	Else 
		OB SET:C1220($ob_respuesta;"uuidasignaturas";"")
		OB SET:C1220($ob_respuesta;"error";"UUIDs no obtenidos")
	End if 
	$0:=JSON Stringify array:C1228($ao_respuestas)
Else 
	$0:=SERwa_GeneraRespuesta ("-100";"Acceso denegado a la API de servicios de SchoolTrack.")
End if 