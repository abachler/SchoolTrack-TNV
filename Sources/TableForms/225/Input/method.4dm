Case of 
	: (Form event:C388=On Load:K2:1)
		
		  //INFO ACTUALIZACIONES
		C_LONGINT:C283(DIAP_Pestañas;vlDIAP_CurrentTab)
		vlDIAP_CurrentTab:=1
		DIAP_Pestañas:=New list:C375
		APPEND TO LIST:C376(DIAP_Pestañas;__ ("Configuración");1)
		APPEND TO LIST:C376(DIAP_Pestañas;__ ("Inscripción de Alumnos");2)
		
		DIAP_CargaPanel (1)  //pagina 1 de configuración
		
	: (Form event:C388=On Close Box:K2:21)
		
		If (vlDIAP_CurrentTab=1)
			C_BLOB:C604($xBlob)
			
			BLOB_Variables2Blob (->$xBlob;0;->a_LB_UUID_Materia;->a_LB_MateriaDisponible;->t_UUID_MAteriaObligatoria)
			PREF_SetBlob (0;"DIAP_SubsectoresDisponibles_"+String:C10(<>gyear);$xBlob)
			
			BLOB_Variables2Blob (->$xBlob;0;->a_LB_CursoUUID;->a_LB_CursoDisponible)
			PREF_SetBlob (0;"DIAP_Cursos_"+String:C10(<>gyear);$xBlob)
			
			BLOB_Variables2Blob (->$xBlob;0;->a_LB_IdTipoEva;->a_LB_TipoEVA)
			PREF_SetBlob (0;"DIAP_TipoExamen";$xBlob)
			
			BLOB_Variables2Blob (->$xBlob;0;->a_LB_IdLenguaMaterna;->a_LB_LenguaMaterna)
			PREF_SetBlob (0;"DIAP_LenguasMaternas";$xBlob)
		End if 
		
End case 