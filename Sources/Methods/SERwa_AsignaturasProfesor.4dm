//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Roberto Catalán
  // Fecha y hora: 11-05-18, 11:23:34
  // ----------------------------------------------------
  // Método: SERwa_AsignaturasProfesor
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
	
	C_TEXT:C284($t_jsonProfesores)
	C_OBJECT:C1216($ob_profesores)
	ARRAY TEXT:C222($at_uuidProfesores;0)
	ARRAY OBJECT:C1221($ao_respuestas;0)
	ARRAY OBJECT:C1221($ao_objetoAsignatura;0)
	C_OBJECT:C1216($ob_respuesta;$ob_respuestaCopia;$ob_respuestaAS;$ob_respuestaCopiaAs)
	
	$t_jsonProfesores:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"profesores")
	$ob_profesores:=JSON Parse:C1218($t_jsonProfesores)
	OB GET ARRAY:C1229($ob_profesores;"profesores";$at_uuidProfesores)
	
	C_LONGINT:C283($l_indice)
	For ($l_indice;1;Size of array:C274($at_uuidProfesores))
		READ ONLY:C145([Asignaturas:18])
		READ ONLY:C145([Profesores:4])
		
		KRL_FindAndLoadRecordByIndex (->[Profesores:4]Auto_UUID:41;->$at_uuidProfesores{$l_indice})
		If (Records in selection:C76([Profesores:4])=1)
			ARRAY LONGINT:C221($al_recNumAs;0)
			C_LONGINT:C283($l_indiceAS)
			ARRAY OBJECT:C1221($ao_objetoAsignatura;0)
			
			QUERY:C277([Asignaturas:18];[Asignaturas:18]profesor_firmante_numero:33=[Profesores:4]Numero:1;*)
			QUERY:C277([Asignaturas:18]; | ;[Asignaturas:18]profesor_numero:4=[Profesores:4]Numero:1)
			If (Records in selection:C76([Asignaturas:18])>0)
				LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$al_recNumAs;"")
				For ($l_indiceAS;1;Size of array:C274($al_recNumAs))
					GOTO RECORD:C242([Asignaturas:18];$al_recNumAs{$l_indiceAS})
					OB SET:C1220($ob_respuestaAS;"uuid";CONDOR_ExportDataTransformer (->[Asignaturas:18]auto_uuid:12))
					OB SET:C1220($ob_respuestaAS;"nombre";CONDOR_ExportDataTransformer (->[Asignaturas:18]Asignatura:3))
					OB SET:C1220($ob_respuestaAS;"uuid_profesor";CONDOR_ExportDataTransformer (->$at_uuidProfesores{$l_indice}))
					OB SET:C1220($ob_respuestaAS;"nivel";[Asignaturas:18]Numero_del_Nivel:6)
					OB SET:C1220($ob_respuestaAS;"uuid_nivel";CONDOR_ExportDataTransformer (->[Asignaturas:18]Numero_del_Nivel:6))
					OB SET:C1220($ob_respuestaAS;"sector";CONDOR_ExportDataTransformer (->[Asignaturas:18]Sector:9))
					OB SET:C1220($ob_respuestaAS;"denominacion_interna";CONDOR_ExportDataTransformer (->[Asignaturas:18]denominacion_interna:16))
					OB SET:C1220($ob_respuestaAS;"seleccion_por_sexo";CONDOR_ExportDataTransformer (->[Asignaturas:18]Seleccion_por_sexo:24))
					OB SET:C1220($ob_respuestaAS;"uuid_curso";CONDOR_ExportDataTransformer (->[Asignaturas:18]Numero_del_Curso:25))
					OB SET:C1220($ob_respuestaAS;"abreviatura";CONDOR_ExportDataTransformer (->[Asignaturas:18]Abreviación:26))
					OB SET:C1220($ob_respuestaAS;"uuid_firmante";CONDOR_ExportDataTransformer (->$at_uuidProfesores{$l_indice}))
					OB SET:C1220($ob_respuestaAS;"cl_codigo_mineduc";CONDOR_ExportDataTransformer (->[Asignaturas:18]CHILE_CodigoMineduc:41))
					OB SET:C1220($ob_respuestaAS;"horas_semanales";CONDOR_ExportDataTransformer (->[Asignaturas:18]Horas_Semanales:51))
					OB SET:C1220($ob_respuestaAS;"horas_anuales";CONDOR_ExportDataTransformer (->[Asignaturas:18]Horas_Anuales:68))
					OB SET:C1220($ob_respuestaAS;"horas_efectivas";CONDOR_ExportDataTransformer (->[Asignaturas:18]Horas_de_clases_efectivas:52))
					OB SET:C1220($ob_respuestaAS;"orden_general";CONDOR_ExportDataTransformer (->[Asignaturas:18]ordenGeneral:105))
					OB SET:C1220($ob_respuestaAS;"curso_grupo";CONDOR_ExportDataTransformer (->[Asignaturas:18]Curso:5))
					$ob_respuestaCopiaAs:=OB Copy:C1225($ob_respuestaAS)
					APPEND TO ARRAY:C911($ao_objetoAsignatura;$ob_respuestaCopiaAs)
				End for 
				
				OB SET:C1220($ob_respuesta;"uuidprofesor";$at_uuidProfesores{$l_indice})
				OB SET:C1220($ob_respuesta;"anio";<>gYear)
				OB SET:C1220($ob_respuesta;"error";"")
				OB SET ARRAY:C1227($ob_respuesta;"asignaturas";$ao_objetoAsignatura)
			Else 
				OB SET:C1220($ob_respuesta;"uuidprofesor";$at_uuidProfesores{$l_indice})
				OB SET:C1220($ob_respuesta;"error";"Profesor sin asignaturas.")
			End if 
		Else 
			OB SET:C1220($ob_respuesta;"uuidprofesor";$at_uuidProfesores{$l_indice})
			OB SET:C1220($ob_respuesta;"error";"Profesor no encontrado.")
		End if 
		$ob_respuestaCopia:=OB Copy:C1225($ob_respuesta)
		APPEND TO ARRAY:C911($ao_respuestas;$ob_respuestaCopia)
	End for 
	$0:=JSON Stringify array:C1228($ao_respuestas)
Else 
	$0:=SERwa_GeneraRespuesta ("-100";"Acceso denegado a la API de servicios de SchoolTrack.")
End if 