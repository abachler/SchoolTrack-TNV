//%attributes = {}
C_POINTER:C301($1)

READ ONLY:C145([xxSTR_Niveles:6])
If (Count parameters:C259=1)
	CREATE SELECTION FROM ARRAY:C640([xxSTR_Niveles:6];$1->)
Else 
	ALL RECORDS:C47([xxSTR_Niveles:6])
End if 

If (Records in selection:C76([xxSTR_Niveles:6])>0)
	$refXMLDoc:=CONDOR_ExportDataGenArchivo ("niveles";->$vt_FileName)
	
	ARRAY LONGINT:C221($recNums;0)
	LONGINT ARRAY FROM SELECTION:C647([xxSTR_Niveles:6];$recNums)
	$size:=Size of array:C274($recNums)
	
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando documento con ")+String:C10($size)+__ (" registros de niveles..."))
	For ($indice;1;$size)
		KRL_GotoRecord (->[xxSTR_Niveles:6];$recNums{$indice};False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"nivel")
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"nivelnumero";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_Niveles:6]NoNivel:5);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"nombre";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_Niveles:6]Nivel:1);True:C214;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"nombreoficial";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_Niveles:6]Nombre_Oficial_NIvel:21);True:C214;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"abreviatura";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_Niveles:6]Abreviatura:19);True:C214;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"abreviatura_oficial";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_Niveles:6]Abreviatura_Oficial:35);True:C214;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"cl_CodigoDecretoEvaluacion";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_Niveles:6]CHILE_CodigoDecretoEvaluacion:38);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"cl_CodigoDecretoPlanEstudios";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_Niveles:6]CHILE_CodigoDecretoPlanEstudio:39);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"cl_CodigoTipoEnseñanza";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_Niveles:6]CHILE_CodigoEnseñanza:41);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"cl_CodigoPlanEstudios";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_Niveles:6]CHILE_CodigoPlanEstudio:40);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"EsNivelSubAnual";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_Niveles:6]Es_Nivel_SubAnual:50);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"EsNivelActivo";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_Niveles:6]EsNIvelActivo:30);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"EsNivelOficial";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_Niveles:6]EsNivelOficial:15);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"EsNivelRegular";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_Niveles:6]EsNivelRegular:4);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"EsNivelSistema";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_Niveles:6]EsNivelSistema:10);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"EsNivelPostulable";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_Niveles:6]EsPostulable:45);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"uuid_director";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_Niveles:6]ID_DirectorNivel:52);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"logo";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_Niveles:6]Logo:49);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"ciclo";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_Niveles:6]Sección:9);True:C214;False:C215)
		
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"uuid";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_Niveles:6]Auto_UUID:51);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"attendancemode";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_Niveles:6]AttendanceMode:3);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"promediosgeneralestruncados";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_Niveles:6]PromediosGeneralesTruncados:11);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"EsNivelSchoolNet";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_Niveles:6]EsNivelSchoolNet:14);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"lates_mode";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_Niveles:6]Lates_Mode:16);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"promocion_auto";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_Niveles:6]Promoción_auto:18);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"dias_habiles";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_Niveles:6]Dias_habiles:20);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"evstyle_oficial_uuid";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_Niveles:6]EvStyle_oficial:23);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"evstyle_interno_uuid";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_Niveles:6]EvStyle_interno:33);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"minimo_asistencia";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_Niveles:6]Minimo_asistencia:24);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"minimo_0";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_Niveles:6]Minimo_0:25);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"minimo_1";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_Niveles:6]Minimo_1:26);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"minimo_2";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_Niveles:6]Minimo_2:27);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"minimo_3";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_Niveles:6]Minimo_3:31);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"fecha_inicio";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_Niveles:6]FechaInicio:29);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"fecha_termino";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_Niveles:6]FechaTermino:34);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"autopromo_inasistencia";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_Niveles:6]AutoPromo_inasistencia:32);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"convertir_eval_a_estilooficial";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_Niveles:6]ConvertirEval_a_EstiloOficial:37);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"config_periodos_uuid";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_Niveles:6]ID_ConfiguracionPeriodos:44);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"modopromediogeneralinterno";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_Niveles:6]ModoPromedioGeneralInterno:47);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"modopromediogeneraloficial";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_Niveles:6]ModoPromedioGeneralOficial:48);False:C215;False:C215)
		
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"ordensubsectores";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_Niveles:6]OrdenSubsectores:36);True:C214;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"acta";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_Niveles:6]Actas_y_Certificados:43);True:C214;False:C215)
		  //CONDOR_ExportSAXCreateNode ($refXMLDoc;"observacionesevaluacion";True;CONDOR_ExportDataTransformer (->[xxSTR_Niveles]ObservacionesEvaluacion);True;False)
		  //No vamos a exportar obersvacionesevaluacion hasta que este el nuevo sistema
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"eventocalendario";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_Niveles:6]xEventoCalendario:53);True:C214;False:C215)
		
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"uuid";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_Niveles:6]Auto_UUID:51);False:C215;False:C215)
		
		QUERY:C277([xxSTR_HistoricoNiveles:191];[xxSTR_HistoricoNiveles:191]NumeroNivel:3;=;[xxSTR_Niveles:6]NoNivel:5)
		ORDER BY:C49([xxSTR_HistoricoNiveles:191];[xxSTR_HistoricoNiveles:191]Año:2;>)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"historicos")
		ARRAY LONGINT:C221($al_niveleshistoricos;0)
		LONGINT ARRAY FROM SELECTION:C647([xxSTR_HistoricoNiveles:191];$al_niveleshistoricos)
		For ($x;1;Size of array:C274($al_niveleshistoricos))
			KRL_GotoRecord (->[xxSTR_HistoricoNiveles:191];$al_niveleshistoricos{$x};True:C214)
			PERIODOS_LeeDatosHistoricos ([xxSTR_HistoricoNiveles:191]NumeroNivel:3;[xxSTR_HistoricoNiveles:191]Año:2)
			If (([xxSTR_HistoricoNiveles:191]NumeroDePeriodos:16=0) | (BLOB size:C605([xxSTR_HistoricoNiveles:191]xConfiguracionPeriodos:7)>32))
				[xxSTR_HistoricoNiveles:191]NumeroDePeriodos:16:=viSTR_Periodos_NumeroPeriodos
				[xxSTR_HistoricoNiveles:191]InicioAgnoEscolar:17:=vdSTR_Periodos_InicioEjercicio
				[xxSTR_HistoricoNiveles:191]TerminoAgnoEscolar:18:=vdSTR_Periodos_FinEjercicio
				SAVE RECORD:C53([xxSTR_HistoricoNiveles:191])
			End if 
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"historico")
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"nivel_uuid";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_HistoricoNiveles:191]NumeroNivel:3);False:C215;False:C215)
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"year";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_HistoricoNiveles:191]Año:2);False:C215;False:C215)
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"nombre";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_HistoricoNiveles:191]NombreInterno:5);True:C214;False:C215)
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"nombreoficial";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_HistoricoNiveles:191]NombreOficial:6);True:C214;False:C215)
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"abreviatura";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_HistoricoNiveles:191]AbreviacionNivel_Interna:12);True:C214;False:C215)
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"abreviatura_oficial";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_HistoricoNiveles:191]AbreviacionNivel_Oficial:13);True:C214;False:C215)
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"EsNivelSubAnual";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_HistoricoNiveles:191]EsNivel_SubAnual:19);False:C215;False:C215)
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"ciclo";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_HistoricoNiveles:191]NombreDeCiclo:14);True:C214;False:C215)
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"directorresponsable";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_HistoricoNiveles:191]DirectorResponsable:15);True:C214;False:C215)
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"numerodeperiodos";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_HistoricoNiveles:191]NumeroDePeriodos:16);False:C215;False:C215)
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"inicioagnoescolar";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_HistoricoNiveles:191]InicioAgnoEscolar:17);False:C215;False:C215)
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"terminoagnoescolar";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_HistoricoNiveles:191]TerminoAgnoEscolar:18);False:C215;False:C215)
			
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"uuid";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_HistoricoNiveles:191]Auto_UUID:24);False:C215;False:C215)
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"evstyle_oficial_uuid";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_HistoricoNiveles:191]Id_EstiloEvaluacionOficial:9);False:C215;False:C215)
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"evstyle_interno_uuid";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_HistoricoNiveles:191]ID_EstiloEvaluacionInterno:8);False:C215;False:C215)
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"modopromediogeneraloficial";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_HistoricoNiveles:191]ModoPromedioGeneralOficial:22);False:C215;False:C215)
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"modopromediogeneralinterno";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_HistoricoNiveles:191]ModoPromedioGeneralInterno:21);False:C215;False:C215)
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"modoasistencia";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_HistoricoNiveles:191]ModoRegistroAsistencia:23);False:C215;False:C215)
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"promediosgeneralestrucados";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_HistoricoNiveles:191]PromediosGeneralesTruncados:20);False:C215;False:C215)
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"acta";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_HistoricoNiveles:191]xActas_y_Certificados:10);True:C214;False:C215)
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"periodos";True:C214;CONDOR_ExportDataTransformer (->[xxSTR_HistoricoNiveles:191]xConfiguracionPeriodos:7);True:C214;False:C215)
			
			SAX CLOSE XML ELEMENT:C854($refXMLDoc)  //cierre historico
		End for 
		SAX CLOSE XML ELEMENT:C854($refXMLDoc)  //cierre historicos
		
		SAX CLOSE XML ELEMENT:C854($refXMLDoc)  //cierre nivel
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$indice/$size;__ ("Exportando nivel ")+[xxSTR_Niveles:6]Nivel:1+", "+String:C10($indice)+__ (" de ")+String:C10($size)+"...")
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	KRL_UnloadReadOnly (->[xxSTR_HistoricoNiveles:191])
	
	SN3_CloseXMLCompress ("";$vt_FileName;"sax";$refXMLDoc)
End if 