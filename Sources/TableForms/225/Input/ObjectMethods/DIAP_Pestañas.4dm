C_REAL:C285($ref)
C_TEXT:C284($text)

GET LIST ITEM:C378(Self:C308->;Selected list items:C379(Self:C308->);$ref;$text)
If (vlDIAP_CurrentTab#$ref)
	Case of 
		: (vlDIAP_CurrentTab=1)
			  //Guardamos la config
			C_BLOB:C604($xBlob)
			
			BLOB_Variables2Blob (->$xBlob;0;->a_LB_UUID_Materia;->a_LB_MateriaDisponible;->t_UUID_MAteriaObligatoria)
			PREF_SetBlob (0;"DIAP_SubsectoresDisponibles_"+String:C10(<>gyear);$xBlob)
			
			BLOB_Variables2Blob (->$xBlob;0;->a_LB_CursoUUID;->a_LB_CursoDisponible)
			PREF_SetBlob (0;"DIAP_Cursos_"+String:C10(<>gyear);$xBlob)
			
			BLOB_Variables2Blob (->$xBlob;0;->a_LB_IdTipoEva;->a_LB_TipoEVA)
			PREF_SetBlob (0;"DIAP_TipoExamen";$xBlob)
			
			BLOB_Variables2Blob (->$xBlob;0;->a_LB_IdLenguaMaterna;->a_LB_LenguaMaterna)
			PREF_SetBlob (0;"DIAP_LenguasMaternas";$xBlob)
			
		: (vlDIAP_CurrentTab=2)
			  //guardar
	End case 
	
	Case of 
		: ($ref=1)
			If (DIAP_CargaPanel (1))
				FORM GOTO PAGE:C247(1)
			End if 
			
		: ($ref=2)
			If (DIAP_CargaPanel (2))
				FORM GOTO PAGE:C247(2)
			Else 
				$ref:=vlDIAP_CurrentTab
				FORM GOTO PAGE:C247(vlDIAP_CurrentTab)
			End if 
	End case 
	
	vlDIAP_CurrentTab:=$ref
End if 