Case of 
	: (Form event:C388=On Load:K2:1)
		  //carga lista de opciones, barra izq del form
		  //Verificar Alumnos
		  //Ingresar Tipo de Enseñanza
		  //Ingresar Cursos
		  //Ingresar Asistencia
		
		  //Meses disponibles para la consulta y envíos en la pagina 4 correspondiente a ingreso de asistencia
		$proc:=IT_UThermometer (1;0;"Iniciando SIGE...")
		
		C_LONGINT:C283(vi_MesNum;vi_NumNivel;$vi_mes;vi_agno)
		C_TEXT:C284(vt_Mes;vt_NivNom)
		
		$vi_mes:=Month of:C24(PERIODOS_InicioAñoSTrack )
		
		ARRAY TEXT:C222(aMeses;0)
		COPY ARRAY:C226(<>atXS_MonthNames;aMeses)
		ARRAY TEXT:C222(at_meses_disponibles;0)
		ARRAY LONGINT:C221(al_num_meses_disponibles;0)
		  //ABC196913 
		vi_MesNum:=Month of:C24(Current date:C33(*))
		vi_agno:=Year of:C25(Current date:C33(*))
		If ((vi_MesNum<$vi_mes) & (vi_agno=<>gyear))
			vi_MesNum:=$vi_mes
		Else 
			  //Ya paso el año pero solo mostrar hasta diciembre
			vi_MesNum:=12
		End if 
		
		For ($i;$vi_mes;vi_MesNum)
			APPEND TO ARRAY:C911(at_meses_disponibles;aMeses{$i})
			APPEND TO ARRAY:C911(al_num_meses_disponibles;$i)
		End for 
		vt_Mes:=at_meses_disponibles{Size of array:C274(at_meses_disponibles)}
		vt_Nivel:=<>at_NombreNivelesActivos{1}
		vi_NivelNum:=<>al_NumeroNivelesActivos{1}
		
		
		C_LONGINT:C283(hl_opciones)
		hl_opciones:=New list:C375
		APPEND TO LIST:C376(hl_opciones;"Alumnos";1)  //Verificar Alumnos
		APPEND TO LIST:C376(hl_opciones;"Tipo de Enseñanza";2)  //Ingresar Tipo de Enseñanza
		APPEND TO LIST:C376(hl_opciones;"Cursos";3)  //Ingresar Cursos
		APPEND TO LIST:C376(hl_opciones;"Asistencia";4)  //Ingresar Asistencia
		
		SELECT LIST ITEMS BY POSITION:C381(hl_opciones;1)
		
		  //carga de array de registro de actividades
		ARRAY TEXT:C222(at_opc;0)
		ARRAY LONGINT:C221(al_num_opc;0)
		ARRAY BOOLEAN:C223(ab_status;4)
		ARRAY TEXT:C222(at_ultima_ejec;4)
		C_BLOB:C604(xBlob)
		SET BLOB SIZE:C606(xBlob;0)
		xBlob:=PREF_fGetBlob (0;"SIGE_LOG_"+String:C10(<>gyear);xBlob)
		BLOB_Blob2Vars (->xBlob;0;->at_opc;->al_num_opc;->ab_status;->at_ultima_ejec)
		SET BLOB SIZE:C606(xBlob;0)
		
		  //Alumnos
		ARRAY LONGINT:C221(al_id_alumno;0)
		ARRAY LONGINT:C221(al_cod_ejec_alu;0)
		C_BLOB:C604(xBlob)
		SET BLOB SIZE:C606(xBlob;0)
		xBlob:=PREF_fGetBlob (0;"SIGE_ALUMNOS_"+String:C10(<>gyear);xBlob)
		BLOB_Blob2Vars (->xBlob;0;->al_id_alumno;->al_cod_ejec_alu)
		SET BLOB SIZE:C606(xBlob;0)
		
		  //Tipo enseñanza
		ARRAY LONGINT:C221(al_cod_tipo_ens;0)
		ARRAY TEXT:C222(at_rolbd;0)
		ARRAY LONGINT:C221(al_cod_ejec_tipo_ens;0)
		ARRAY TEXT:C222(at_listado_error_tipo_ens;0)
		C_BLOB:C604(xBlob)
		SET BLOB SIZE:C606(xBlob;0)
		xBlob:=PREF_fGetBlob (0;"SIGE_TIPOENS_"+String:C10(<>gyear);xBlob)
		BLOB_Blob2Vars (->xBlob;0;->al_cod_tipo_ens;->at_rolbd;->al_cod_ejec_tipo_ens;->at_listado_error_tipo_ens)
		SET BLOB SIZE:C606(xBlob;0)
		
		  //Curso
		ARRAY TEXT:C222(at_curso;0)
		ARRAY LONGINT:C221(al_cod_ejec_curso;0)
		ARRAY TEXT:C222(at_listado_error_curso;0)
		C_BLOB:C604(xBlob)
		SET BLOB SIZE:C606(xBlob;0)
		xBlob:=PREF_fGetBlob (0;"SIGE_CURSOS_"+String:C10(<>gyear);xBlob)
		BLOB_Blob2Vars (->xBlob;0;->at_curso;->al_cod_ejec_curso;->at_listado_error_curso)
		SET BLOB SIZE:C606(xBlob;0)
		
		  //Asistencia
		ARRAY TEXT:C222(at_key_asistencia;0)  //rbd.cod_tipo_ens.cod_grado.fecha
		ARRAY LONGINT:C221(al_cod_respuesta_asist;0)
		ARRAY LONGINT:C221(al_cod_envio_asist;0)
		ARRAY LONGINT:C221(al_cod_envio_asist_resp;0)
		ARRAY TEXT:C222(at_error_envio_asist_resp;0)
		C_BLOB:C604(xBlob)
		SET BLOB SIZE:C606(xBlob;0)
		xBlob:=PREF_fGetBlob (0;"SIGE_ASISTENCIA_"+String:C10(<>gyear);xBlob)
		BLOB_Blob2Vars (->xBlob;0;->at_key_asistencia;->al_cod_respuesta_asist;->al_cod_envio_asist;->al_cod_envio_asist_resp;->at_error_envio_asist_resp)
		SET BLOB SIZE:C606(xBlob;0)
		
		  //carga de la pagina 1 verificación alumnos
		C_LONGINT:C283(vl_CurrentTab)
		SIGE_LoadDataArrays (1)
		SIGE_LoadDisplayLB (1)
		vl_CurrentTab:=1
		ta_1:=1
		ta_2:=0
		OBJECT SET ENABLED:C1123(*;"bti_blockAL";True:C214)
		SIGE_wsGetDatosColegio 
		IT_UThermometer (-2;$proc)
	: (Form event:C388=On Close Box:K2:21)
		vt_ultima_fecha_alu:=""
		CANCEL:C270
End case 

