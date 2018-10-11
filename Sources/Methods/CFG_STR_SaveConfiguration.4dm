//%attributes = {}
  // CFG_STR_SaveConfiguration()
  //
  //
  // creado por: Alberto Bachler Klein: 17-01-16, 14:58:58
  // -----------------------------------------------------------
C_LONGINT:C283($i;$l_elemento;$l_idCategoria;$l_insertarEn;$l_offset)
C_TEXT:C284($t_accion;$t_nombreCategoria)

ARRAY LONGINT:C221($al_idAlumnos;0)
ARRAY LONGINT:C221($al_MatrizAnotID;0)
ARRAY LONGINT:C221($al_MatrizAnotPuntajeAnotacion;0)
ARRAY LONGINT:C221($al_MatrizAnotPuntosCategoria;0)
ARRAY TEXT:C222($at_MatrizAnotCategorias;0)
ARRAY TEXT:C222($at_MatrizAnotMotivos;0)


$t_accion:=$1
Case of 
	: ($t_accion="Conducta")
		
		AL_UpdateArrays (xALP_categoria;0)
		AL_UpdateArrays (xALP_Motivos;0)
		AL_UpdateArrays (xALP_castigos;0)
		AL_UpdateArrays (xALP_Suspensiones;0)
		
		  //anotaciones
		at_STR_CategoriasAnot_Nombres{0}:=""
		ai_STR_CategoriasAnot_Puntaje{0}:=0
		aiSTR_IDCategoria{0}:=0
		ai_TipoAnotacion{0}:=0
		For ($i;Size of array:C274(at_STR_CategoriasAnot_Nombres);1;-1)
			at_STR_CategoriasAnot_Nombres{$i}:=Replace string:C233(at_STR_CategoriasAnot_Nombres{$i};"\r";" ")  //20150817 ASM Ticket 130628
			If (at_STR_CategoriasAnot_Nombres{$i}="")
				AT_Delete ($i;1;->at_STR_CategoriasAnot_Nombres;->ai_STR_CategoriasAnot_Puntaje;->aiSTR_IDCategoria;->ap_TipoAnotacion;->ai_TipoAnotacion)
			End if 
		End for 
		For ($i;Size of array:C274(<>aiID_Matriz);1;-1)
			If (<>atSTR_Anotaciones_motivo{$i}="")
				AT_Delete ($i;1;-><>aiID_Matriz;-><>atSTR_Anotaciones_categorias;-><>atSTR_Anotaciones_motivo;-><>aiSTR_Anotaciones_puntaje;-><>aiSTR_Anotaciones_motivo_puntaj)
			End if 
		End for 
		SET BLOB SIZE:C606(xBlob;0)
		BLOB_Variables2Blob (->xBlob;0;->at_STR_CategoriasAnot_Nombres;->ai_STR_CategoriasAnot_Puntaje;->aiSTR_IDCategoria;->ap_TipoAnotacion;->ai_TipoAnotacion)
		PREF_SetBlob (0;"STR_CategoriaAnotaciones";xBlob)
		
		  //reconstrucción de la matriz de anotaciones
		SET BLOB SIZE:C606(xBlob;0)
		For ($i_categorias;1;Size of array:C274(aiSTR_IDCategoria))
			$l_idCategoria:=aiSTR_IDCategoria{$i_categorias}
			$t_nombreCategoria:=at_STR_CategoriasAnot_Nombres{$i_categorias}
			  //$l_puntajeCategorias:=◊aiSTR_Anotaciones_puntaje{$i_categorias}`JHB esto estaba mal ya que ◊aiSTR_Anotaciones_puntaje contiene los puntajes de todas las anotaciones
			$l_puntajeCategorias:=ai_STR_CategoriasAnot_Puntaje{$i_categorias}  //en cambio ai_STR_CategoriasAnot_Puntaje tiene los puntajes de las categorias que es lo que queremos aca..
			For ($i;1;Size of array:C274(<>atSTR_Anotaciones_categorias))
				If (<>aiID_Matriz{$i}=$l_idCategoria)
					If (<>atSTR_Anotaciones_motivo{$i}#"")
						$l_insertarEn:=Size of array:C274($al_MatrizAnotID)+1
						INSERT IN ARRAY:C227($al_MatrizAnotID;$l_insertarEn)
						INSERT IN ARRAY:C227($at_MatrizAnotCategorias;$l_insertarEn)
						INSERT IN ARRAY:C227($at_MatrizAnotMotivos;$l_insertarEn)
						INSERT IN ARRAY:C227($al_MatrizAnotPuntosCategoria;$l_insertarEn)
						INSERT IN ARRAY:C227($al_MatrizAnotPuntajeAnotacion;$l_insertarEn)
						$al_MatrizAnotID{Size of array:C274($al_MatrizAnotID)}:=$l_idCategoria
						$at_MatrizAnotCategorias{Size of array:C274($al_MatrizAnotID)}:=$t_nombreCategoria
						$at_MatrizAnotMotivos{Size of array:C274($al_MatrizAnotID)}:=<>atSTR_Anotaciones_motivo{$i}
						$al_MatrizAnotPuntajeAnotacion{Size of array:C274($al_MatrizAnotID)}:=<>aiSTR_Anotaciones_motivo_puntaj{$i}
						$al_MatrizAnotPuntosCategoria{Size of array:C274($al_MatrizAnotID)}:=$l_puntajeCategorias
					End if 
				End if 
			End for 
		End for 
		COPY ARRAY:C226($al_MatrizAnotID;<>aiID_Matriz)
		COPY ARRAY:C226($at_MatrizAnotCategorias;<>atSTR_Anotaciones_categorias)
		COPY ARRAY:C226($at_MatrizAnotMotivos;<>atSTR_Anotaciones_motivo)
		COPY ARRAY:C226($al_MatrizAnotPuntosCategoria;<>aiSTR_Anotaciones_puntaje)
		COPY ARRAY:C226($al_MatrizAnotPuntajeAnotacion;<>aiSTR_Anotaciones_motivo_puntaj)
		<>atSTR_Anotaciones_motivo{0}:=""
		<>atSTR_Anotaciones_categorias{0}:=""
		<>aiID_Matriz{0}:=0
		<>aiSTR_Anotaciones_puntaje{0}:=0
		<>aiSTR_Anotaciones_motivo_puntaj{0}:=0
		BLOB_Variables2Blob (->xBlob;0;-><>aiID_Matriz;-><>atSTR_Anotaciones_categorias;-><>atSTR_Anotaciones_motivo;-><>aiSTR_Anotaciones_puntaje;-><>aiSTR_Anotaciones_motivo_puntaj)
		PREF_SetBlob (0;"STR_MatrizAnotaciones";xBlob)
		
		
		  //castigos
		atSTRal_MotivosCastigo{0}:=""
		For ($i;Size of array:C274(atSTRal_MotivosCastigo);1;-1)
			If (atSTRal_MotivosCastigo{$i}="")
				DELETE FROM ARRAY:C228(atSTRal_MotivosCastigo;$i;1)
			End if 
		End for 
		BLOB_Variables2Blob (->xblob;0;->atSTRal_MotivosCastigo)
		PREF_SetBlob (0;"MotivosCastigo";xblob)
		
		  //supensiones
		atSTRal_MotivosSuspension{0}:=""
		For ($i;Size of array:C274(atSTRal_MotivosSuspension);1;-1)
			If (atSTRal_MotivosSuspension{$i}="")
				DELETE FROM ARRAY:C228(atSTRal_MotivosSuspension;$i;1)
			End if 
		End for 
		BLOB_Variables2Blob (->xblob;0;->atSTRal_MotivosSuspension)
		PREF_SetBlob (0;"MotivosSuspension";xblob)
		
		  //atrasos rch desde aca
		If (cb_TGenInasDia=1)
			vi_Minutos_Inasistencia_Dia:=ATSTRAL_FALTAMINUTOSDESDE{4}
		Else 
			vi_Minutos_Inasistencia_Dia:=0
		End if 
		_O_C_INTEGER:C282(conversionDia)
		conversionDia:=0  //preferencia conv dia
		vi_Minutos_Inasistencia_hora:=0
		Case of 
			: (DConv1=1)
				conversionDia:=1
			: (DConv2=1)
				conversionDia:=2
			: (DConv3=1)
				conversionDia:=3
			: (DConv4=1)
				conversionDia:=4
		End case 
		SET BLOB SIZE:C606(xblob;0)
		BLOB_Variables2Blob (->xblob;0;->vt_Intervalos;->ATSTRAL_FALTAMINUTOSDESDE;->ATSTRAL_FALTAMINUTOSHASTA;->ATSTRAL_FALTACONV;->conversionDia;->ATSTRAL_FALTATIPO)
		PREF_SetBlob (0;"PreferenciasAtrasosDia";xblob)
		SET BLOB SIZE:C606(xblob;0)
		BLOB_Variables2Blob (->xblob;0;->vt_Intervalos;->vi_Minutos_Inasistencia_hora;->vi_Minutos_Inasistencia_Dia)
		PREF_SetBlob (0;"PreferenciasAtrasos";xblob)
		SET BLOB SIZE:C606(xblob;0)  //atrasos rch hasta aca
		
		STR_LeePreferenciasConducta2 
		ST_JustificacionAtrasos ("guardaJustificacion")
		
		  //MONO 205385
		If (Size of array:C274(at_logCambios)>0)
			For ($iLog;1;Size of array:C274(at_logCambios))
				LOG_RegisterEvt (at_logCambios{$iLog})
			End for 
			ARRAY TEXT:C222(at_logCambios;0)
		End if 
		
	: ($t_accion="Periodos")
		CFG_STR_PeriodosEscolares_NEW ("SaveConfig")
		
	: ($t_accion="Evaluacion")  //Evaluacion
		EVS_SetFormats 
		GOTO RECORD:C242([xxSTR_EstilosEvaluacion:44];vl_LastEvStyleRecNum)
		If (vb_evStyleModified)
			LOG_RegisterEvt ("Modificación del estilo de evaluación Nº "+String:C10([xxSTR_EstilosEvaluacion:44]ID:1)+": "+[xxSTR_EstilosEvaluacion:44]Name:2)
		End if 
		
		  //20170406 RCH
		  //EVS_WriteStyleData 
		EVS_GuardaEstiloEvaluacion 
		
		EVS_initialize 
		EVS_LoadStyles 
		
	: ($t_accion="Niveles")  //niveles
		$l_elemento:=Find in array:C230(aEvStyleId;[xxSTR_Niveles:6]EvStyle_oficial:23)
		If ($l_elemento>0)
			aEvStyleName:=$l_elemento
			[xxSTR_Niveles:6]EvStyle_oficial:23:=aEvStyleId{$l_elemento}
		Else 
			aEvStyleName:=0
		End if 
		
		PERIODOS_LoadData (0;[xxSTR_Niveles:6]ID_ConfiguracionPeriodos:44)
		[xxSTR_Niveles:6]FechaTermino:34:=vdSTR_Periodos_FinEjercicio
		[xxSTR_Niveles:6]FechaInicio:29:=vdSTR_Periodos_InicioEjercicio
		[xxSTR_Niveles:6]Dias_habiles:20:=DT_GetWorkingDays (vdSTR_Periodos_InicioEjercicio;[xxSTR_Niveles:6]FechaTermino:34)
		If ([xxSTR_Niveles:6]AttendanceMode:3#Old:C35([xxSTR_Niveles:6]AttendanceMode:3))
			LOG_RegisterEvt (__ ("Se modifica el modo de registro de asistencia del nivel ")+[xxSTR_Niveles:6]Nombre_Oficial_NIvel:21)
		End if 
		
		STR_ResponsableNiveles ("guardaResponsable")
		
		SAVE RECORD:C53([xxSTR_Niveles:6])
		UNLOAD RECORD:C212([xxSTR_Niveles:6])
		NIV_LoadArrays 
		CU_LoadArrays 
		KRL_ExecuteOnConnectedClients ("NIV_LoadArrays")
		KRL_ExecuteOnConnectedClients ("CU_LoadArrays")
		
		If (vb_CambiosEnPromocion)
			vb_AsignaSituacionFinal:=True:C214
			KRL_RelateSelection (->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]NoNivel:5;"")
			KRL_RelateSelection (->[Alumnos_SintesisAnual:210]ID_Alumno:4;->[Alumnos:2]numero:1;"")
			QUERY SELECTION:C341([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]Año:2=<>gYear)
			SELECTION TO ARRAY:C260([Alumnos:2]numero:1;$al_idAlumnos)
			$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Recalculando situación final de los alumnos..."))
			For ($i;1;Size of array:C274($al_idAlumnos))
				AL_CalculaSituacionFinal ($al_idAlumnos{$i})
				$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($al_idAlumnos);__ ("Recalculando situación final de los alumnos..."))
			End for 
			$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
			vb_CambiosEnPromocion:=False:C215
		End if 
		
		
		
	: ($t_accion="Subsectores")  //ramos
	: ($t_accion="Informes")
		Case of 
			: (vs_lastRCModel="Actas")
				READ WRITE:C146([xxSTR_Niveles:6])
				QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=vi_NoNivel)
				ACTAS_GuardaConfiguracion (vi_NoNivel)
			: (vs_lastRCModel#"")
				NIVrc_SaveSettings 
		End case 
	: ($t_accion="Conducta y asistencia")  //conducta y asistencia
		SAVE RECORD:C53([xxSTR_Constants:1])
		UNLOAD RECORD:C212([xxSTR_Constants:1])
		READ ONLY:C145([xxSTR_Constants:1])
		
End case 




