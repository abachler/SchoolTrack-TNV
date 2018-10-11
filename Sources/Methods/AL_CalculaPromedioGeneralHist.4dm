//%attributes = {}
  // AL_CalculaPromedioGeneralHist()
  //
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 12/07/12, 10:53:39
  // ---------------------------------------------
C_BLOB:C604($x_blobEstiloInterno;$x_blobEstiloOficial)
C_BOOLEAN:C305($b_hayEvaluaciones)
C_LONGINT:C283($l_estiloInternoEsValido;$l_estiloOficialEsValido;$l_IdEstiloEvaluacionInterno;$l_IdEstiloEvaluacionOficial;$l_minimoEnEstiloInterno;$l_minimoEnEstiloOficial;$l_modoImpresionInterno;$l_modoImpresionOficial;$l_modoPromedioInterno;$l_modoPromedioOficial)
C_LONGINT:C283($l_opcionCalculoPromedio;$l_recNumSintesisAnual;$l_truncarPromedio)
C_REAL:C285($r_media;$r_mediaNota;$r_mediaPuntos;$r_mediaReal)
C_TEXT:C284($t_llaveHistoricoNivel;$t_mediaLiteral;$t_mediaLiteralInterno;$t_mediaLiteralOficial;$t_mediaSimbolos)

ARRAY BOOLEAN:C223($ab_IncidePromedioInterno;0)
ARRAY BOOLEAN:C223($ab_IncidePromedioOficial;0)
ARRAY INTEGER:C220($ai_HorasSemanales;0)
ARRAY REAL:C219($ar_PromedioPeriodo_real_P1;0)
ARRAY REAL:C219($ar_PromedioPeriodo_real_P2;0)
ARRAY REAL:C219($ar_PromedioPeriodo_real_P3;0)
ARRAY REAL:C219($ar_PromedioPeriodo_real_P4;0)
ARRAY REAL:C219($ar_PromedioPeriodo_real_P5;0)
ARRAY REAL:C219($ar_FactorInterno;0)
ARRAY REAL:C219($ar_FactorOficial;0)
ARRAY REAL:C219($ar_PromedioAnual_nota;0)
ARRAY REAL:C219($ar_PromedioAnual_puntos;0)
ARRAY REAL:C219($ar_PromedioAnual_real;0)
ARRAY REAL:C219($ar_PromedioFinal_nota;0)
ARRAY REAL:C219($ar_PromedioFinal_puntos;0)
ARRAY REAL:C219($ar_PromedioFinal_real;0)
ARRAY REAL:C219($ar_PromedioOficial_nota;0)
ARRAY REAL:C219($ar_PromedioOficial_puntos;0)
ARRAY REAL:C219($ar_PromedioOficial_real;0)
ARRAY REAL:C219($ar_PromedioPeriodo_nota_P1;0)
ARRAY REAL:C219($ar_PromedioPeriodo_nota_P2;0)
ARRAY REAL:C219($ar_PromedioPeriodo_nota_P3;0)
ARRAY REAL:C219($ar_PromedioPeriodo_nota_P4;0)
ARRAY REAL:C219($ar_PromedioPeriodo_nota_P5;0)
ARRAY REAL:C219($ar_PromedioPeriodo_puntos_P1;0)
ARRAY REAL:C219($ar_PromedioPeriodo_puntos_P2;0)
ARRAY REAL:C219($ar_PromedioPeriodo_puntos_P3;0)
ARRAY REAL:C219($ar_PromedioPeriodo_puntos_P4;0)
ARRAY REAL:C219($ar_PromedioPeriodo_puntos_P5;0)

  // CÓDIGO

$l_recNumSintesisAnual:=$1
KRL_GotoRecord (->[Alumnos_SintesisAnual:210];$l_recNumSintesisAnual;True:C214)

If (([Alumnos_SintesisAnual:210]Año:2<<>gYear) & ([Alumnos_SintesisAnual:210]ID_Alumno:4<0) & ([Alumnos_SintesisAnual:210]NumeroNivel:6#0))
	PERIODOS_LeeDatosHistoricos ([Alumnos_SintesisAnual:210]NumeroNivel:6;[Alumnos_SintesisAnual:210]Año:2)
	
	EV2_InitArrays 
	
	$t_llaveHistoricoNivel:=String:C10(0)+"."+String:C10([Alumnos_SintesisAnual:210]NumeroNivel:6)+"."+String:C10([Alumnos_SintesisAnual:210]Año:2)
	$l_IdEstiloEvaluacionInterno:=KRL_GetNumericFieldData (->[xxSTR_HistoricoNiveles:191]LlavePrimaria:11;->$t_llaveHistoricoNivel;->[xxSTR_HistoricoNiveles:191]ID_EstiloEvaluacionInterno:8)
	$l_IdEstiloEvaluacionOficial:=KRL_GetNumericFieldData (->[xxSTR_HistoricoNiveles:191]LlavePrimaria:11;->$t_llaveHistoricoNivel;->[xxSTR_HistoricoNiveles:191]Id_EstiloEvaluacionOficial:9)
	$l_modoPromedioInterno:=KRL_GetNumericFieldData (->[xxSTR_HistoricoNiveles:191]LlavePrimaria:11;->$t_llaveHistoricoNivel;->[xxSTR_HistoricoNiveles:191]ModoPromedioGeneralInterno:21)
	$l_modoPromedioOficial:=KRL_GetNumericFieldData (->[xxSTR_HistoricoNiveles:191]LlavePrimaria:11;->$t_llaveHistoricoNivel;->[xxSTR_HistoricoNiveles:191]ModoPromedioGeneralOficial:22)
	$l_truncarPromedio:=Num:C11(KRL_GetBooleanFieldData (->[xxSTR_HistoricoNiveles:191]LlavePrimaria:11;->$t_llaveHistoricoNivel;->[xxSTR_HistoricoNiveles:191]PromediosGeneralesTruncados:20))
	
	$x_blobEstiloInterno:=KRL_GetBlobFieldData (->[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3;->$l_IdEstiloEvaluacionInterno;->[xxSTR_HistoricoEstilosEval:88]xData:6)
	$x_blobEstiloOficial:=KRL_GetBlobFieldData (->[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3;->$l_IdEstiloEvaluacionOficial;->[xxSTR_HistoricoEstilosEval:88]xData:6)
	
	  //lectura del estilo interno
	$l_estiloInternoEsValido:=EVS_LeeEstiloEvalHistorico ($x_blobEstiloInterno)
	If ($l_estiloInternoEsValido=1)
		$l_modoImpresionInterno:=iPrintMode
		$l_minimoEnEstiloInterno:=vrNTA_MinimoEscalaReferencia
	End if 
	$l_estiloOficialEsValido:=EVS_LeeEstiloEvalHistorico ($x_blobEstiloOficial)
	If ($l_estiloOficialEsValido=1)
		$l_modoImpresionOficial:=iPrintActa
		$l_minimoEnEstiloOficial:=vrNTA_MinimoEscalaReferencia
	End if 
	
	If (($l_estiloInternoEsValido=0) & ($l_estiloOficialEsValido=0))
		  //no hay estilo oficial o interno asignado al nivel. No es posible calcular los promedios
	Else 
		
		EV2_RegistrosDelAlumno (Abs:C99([Alumnos_SintesisAnual:210]ID_Alumno:4);[Alumnos_SintesisAnual:210]NumeroNivel:6;[Alumnos_SintesisAnual:210]Año:2)
		
		If (Records in selection:C76([Alumnos_Calificaciones:208])>0)
			  //INICIALIZACION DE LOS PROMEDIOS EN LOS REGISTRO DE SINTESIS ANUAL
			  //promedio anual
			$r_mediaReal:=-10
			$r_mediaNota:=-10
			$r_mediaPuntos:=-10
			$t_mediaSimbolos:=""
			$t_mediaLiteralInterno:=""
			$t_mediaLiteralOficial:=""
			
			[Alumnos_SintesisAnual:210]P01_PromedioInterno_Real:92:=$r_mediaReal
			[Alumnos_SintesisAnual:210]P01_PromedioInterno_Nota:93:=$r_mediaNota
			[Alumnos_SintesisAnual:210]P01_PromedioInterno_Puntos:94:=$r_mediaPuntos
			[Alumnos_SintesisAnual:210]P01_PromedioInterno_Simbolo:95:=$t_mediaSimbolos
			[Alumnos_SintesisAnual:210]P01_PromedioInterno_Literal:96:=$t_mediaLiteralInterno
			[Alumnos_SintesisAnual:210]P01_PromedioOficial_Real:237:=$r_mediaReal
			[Alumnos_SintesisAnual:210]P01_PromedioOficial_Nota:238:=$r_mediaNota
			[Alumnos_SintesisAnual:210]P01_PromedioOficial_Puntos:239:=$r_mediaPuntos
			[Alumnos_SintesisAnual:210]P01_PromedioOficial_Simbolo:240:=$t_mediaSimbolos
			[Alumnos_SintesisAnual:210]P01_PromedioOficial_Literal:241:=$t_mediaLiteralInterno
			
			[Alumnos_SintesisAnual:210]P02_PromedioInterno_Real:121:=$r_mediaReal
			[Alumnos_SintesisAnual:210]P02_PromedioInterno_Nota:122:=$r_mediaNota
			[Alumnos_SintesisAnual:210]P02_PromedioInterno_Puntos:123:=$r_mediaPuntos
			[Alumnos_SintesisAnual:210]P02_PromedioInterno_Simbolo:124:=$t_mediaSimbolos
			[Alumnos_SintesisAnual:210]P02_PromedioInterno_Literal:125:=$t_mediaLiteralInterno
			[Alumnos_SintesisAnual:210]P02_PromedioOficial_Real:242:=$r_mediaReal
			[Alumnos_SintesisAnual:210]P02_PromedioOficial_Nota:243:=$r_mediaNota
			[Alumnos_SintesisAnual:210]P02_PromedioOficial_Puntos:244:=$r_mediaPuntos
			[Alumnos_SintesisAnual:210]P02_PromedioOficial_Simbolo:245:=$t_mediaSimbolos
			[Alumnos_SintesisAnual:210]P02_PromedioOficial_Literal:246:=$t_mediaLiteralInterno
			
			[Alumnos_SintesisAnual:210]P03_PromedioInterno_Real:150:=$r_mediaReal
			[Alumnos_SintesisAnual:210]P03_PromedioInterno_Nota:151:=$r_mediaNota
			[Alumnos_SintesisAnual:210]P03_PromedioInterno_Puntos:152:=$r_mediaPuntos
			[Alumnos_SintesisAnual:210]P03_PromedioInterno_Simbolo:153:=$t_mediaSimbolos
			[Alumnos_SintesisAnual:210]P03_PromedioInterno_Literal:154:=$t_mediaLiteralInterno
			[Alumnos_SintesisAnual:210]P03_PromedioOficial_Real:247:=$r_mediaReal
			[Alumnos_SintesisAnual:210]P03_PromedioOficial_Nota:248:=$r_mediaNota
			[Alumnos_SintesisAnual:210]P03_PromedioOficial_Puntos:249:=$r_mediaPuntos
			[Alumnos_SintesisAnual:210]P03_PromedioOficial_Simbolo:250:=$t_mediaSimbolos
			[Alumnos_SintesisAnual:210]P03_PromedioOficial_Literal:251:=$t_mediaLiteralInterno
			
			[Alumnos_SintesisAnual:210]P04_PromedioInterno_Real:179:=$r_mediaReal
			[Alumnos_SintesisAnual:210]P04_PromedioInterno_Nota:180:=$r_mediaNota
			[Alumnos_SintesisAnual:210]P04_PromedioInterno_Puntos:181:=$r_mediaPuntos
			[Alumnos_SintesisAnual:210]P04_PromedioInterno_Simbolo:182:=$t_mediaSimbolos
			[Alumnos_SintesisAnual:210]P04_PromedioInterno_Literal:183:=$t_mediaLiteralInterno
			[Alumnos_SintesisAnual:210]P04_PromedioOficial_Real:252:=$r_mediaReal
			[Alumnos_SintesisAnual:210]P04_PromedioOficial_Nota:253:=$r_mediaNota
			[Alumnos_SintesisAnual:210]P04_PromedioOficial_Puntos:254:=$r_mediaPuntos
			[Alumnos_SintesisAnual:210]P04_PromedioOficial_Simbolo:255:=$t_mediaSimbolos
			[Alumnos_SintesisAnual:210]P04_PromedioOficial_Literal:256:=$t_mediaLiteralInterno
			
			[Alumnos_SintesisAnual:210]P05_PromedioInterno_Real:208:=$r_mediaReal
			[Alumnos_SintesisAnual:210]P05_PromedioInterno_Nota:209:=$r_mediaNota
			[Alumnos_SintesisAnual:210]P05_PromedioInterno_Puntos:210:=$r_mediaPuntos
			[Alumnos_SintesisAnual:210]P05_PromedioInterno_Simbolo:211:=$t_mediaSimbolos
			[Alumnos_SintesisAnual:210]P05_PromedioInterno_Literal:212:=$t_mediaLiteralInterno
			[Alumnos_SintesisAnual:210]P05_PromedioOficial_Real:257:=$r_mediaReal
			[Alumnos_SintesisAnual:210]P05_PromedioOficial_Nota:258:=$r_mediaNota
			[Alumnos_SintesisAnual:210]P05_PromedioOficial_Puntos:259:=$r_mediaPuntos
			[Alumnos_SintesisAnual:210]P05_PromedioOficial_Simbolo:260:=$t_mediaSimbolos
			[Alumnos_SintesisAnual:210]P05_PromedioOficial_Literal:261:=$t_mediaLiteralInterno
			
			  //promedio anual
			[Alumnos_SintesisAnual:210]PromedioAnualOficial_Real:15:=$r_mediaReal
			[Alumnos_SintesisAnual:210]PromedioAnualOficial_Nota:16:=$r_mediaNota
			[Alumnos_SintesisAnual:210]PromedioAnualOficial_Puntos:17:=$r_mediaPuntos
			[Alumnos_SintesisAnual:210]PromedioAnualOficial_Simbolo:18:=$t_mediaSimbolos
			[Alumnos_SintesisAnual:210]PromedioAnualOficial_Literal:19:=$t_mediaLiteralInterno
			[Alumnos_SintesisAnual:210]PromedioAnualInterno_Real:10:=$r_mediaReal
			[Alumnos_SintesisAnual:210]PromedioAnualInterno_Nota:11:=$r_mediaNota
			[Alumnos_SintesisAnual:210]PromedioAnualInterno_Puntos:12:=$r_mediaPuntos
			[Alumnos_SintesisAnual:210]PromedioAnualInterno_Simbolo:13:=$t_mediaSimbolos
			[Alumnos_SintesisAnual:210]PromedioAnualInterno_Literal:14:=$t_mediaLiteralInterno
			
			  //promedio final INTERNO
			[Alumnos_SintesisAnual:210]PromedioFinalInterno_Real:20:=$r_mediaReal
			[Alumnos_SintesisAnual:210]PromedioFinalInterno_Nota:21:=$r_mediaNota
			[Alumnos_SintesisAnual:210]PromedioFinalInterno_Puntos:22:=$r_mediaPuntos
			[Alumnos_SintesisAnual:210]PromedioFinalInterno_Simbolo:23:=$t_mediaSimbolos
			[Alumnos_SintesisAnual:210]PromedioFinalInterno_Literal:24:=$t_mediaLiteralInterno
			[Alumnos_SintesisAnual:210]PromedioInt_NoAprox_Real:272:=$r_mediaReal
			[Alumnos_SintesisAnual:210]PromedioInt_NoAprox_Nota:273:=$r_mediaNota
			[Alumnos_SintesisAnual:210]PromedioInt_NoAprox_Puntos:274:=$r_mediaPuntos
			[Alumnos_SintesisAnual:210]PromedioInt_NoAprox_Literal:275:=$t_mediaLiteralOficial
			
			  //promedio final OFICIAL
			[Alumnos_SintesisAnual:210]PromedioFinalOficial_Real:25:=$r_mediaReal
			[Alumnos_SintesisAnual:210]PromedioFinalOficial_Nota:26:=$r_mediaNota
			[Alumnos_SintesisAnual:210]PromedioFinalOficial_Puntos:27:=$r_mediaPuntos
			[Alumnos_SintesisAnual:210]PromedioFinalOficial_Simbolo:28:=$t_mediaSimbolos
			[Alumnos_SintesisAnual:210]PromedioFinalOficial_Literal:29:=$t_mediaLiteralOficial
			[Alumnos_SintesisAnual:210]PromedioOf_NoAprox_Real:268:=$r_mediaReal
			[Alumnos_SintesisAnual:210]PromedioOf_NoAprox_Nota:269:=$r_mediaNota
			[Alumnos_SintesisAnual:210]PromedioOf_NoAprox_Puntos:270:=$r_mediaPuntos
			[Alumnos_SintesisAnual:210]PromedioOf_NoAprox_Literal:271:=$t_mediaLiteralOficial
			
			SAVE RECORD:C53([Alumnos_SintesisAnual:210])
			
			READ ONLY:C145([Alumnos_Calificaciones:208])
			READ ONLY:C145([Asignaturas:18])
			
			If ($l_minimoEnEstiloInterno=0)
				$l_opcionCalculoPromedio:=3
			Else 
				$l_opcionCalculoPromedio:=1
			End if 
			
			CREATE SET:C116([Alumnos_Calificaciones:208];"Calificaciones")
			
			SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
			QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas_Historico:84]Promediable:6=True:C214)
			
			If (Records in selection:C76([Alumnos_Calificaciones:208])>0)
				ORDER BY:C49([Alumnos_Calificaciones:208];[Asignaturas_Historico:84]OrdenGeneral:42;>)
				SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P01_Final_Real:112;$ar_PromedioPeriodo_real_P1;[Alumnos_Calificaciones:208]P02_Final_Real:187;$ar_PromedioPeriodo_real_P2;[Alumnos_Calificaciones:208]P03_Final_Real:262;$ar_PromedioPeriodo_real_P3;[Alumnos_Calificaciones:208]P04_Final_Real:337;$ar_PromedioPeriodo_real_P4;[Alumnos_Calificaciones:208]P05_Final_Real:412;$ar_PromedioPeriodo_real_P5)
				SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P01_Final_Nota:113;$ar_PromedioPeriodo_nota_P1;[Alumnos_Calificaciones:208]P02_Final_Nota:188;$ar_PromedioPeriodo_nota_P2;[Alumnos_Calificaciones:208]P03_Final_Nota:263;$ar_PromedioPeriodo_nota_P3;[Alumnos_Calificaciones:208]P04_Final_Nota:338;$ar_PromedioPeriodo_nota_P4;[Alumnos_Calificaciones:208]P05_Final_Nota:413;$ar_PromedioPeriodo_nota_P5)
				SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P01_Final_Puntos:114;$ar_PromedioPeriodo_puntos_P1;[Alumnos_Calificaciones:208]P02_Final_Puntos:189;$ar_PromedioPeriodo_puntos_P2;[Alumnos_Calificaciones:208]P03_Final_Puntos:264;$ar_PromedioPeriodo_puntos_P3;[Alumnos_Calificaciones:208]P04_Final_Puntos:339;$ar_PromedioPeriodo_puntos_P4;[Alumnos_Calificaciones:208]P05_Final_Puntos:414;$ar_PromedioPeriodo_puntos_P5)
				SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]Anual_Real:11;$ar_PromedioAnual_real;[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;$ar_PromedioFinal_real;[Alumnos_Calificaciones:208]Anual_Nota:12;$ar_PromedioAnual_nota;[Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27;$ar_PromedioFinal_nota;[Alumnos_Calificaciones:208]Anual_Puntos:13;$ar_PromedioAnual_puntos;[Alumnos_Calificaciones:208]EvaluacionFinal_Puntos:28;$ar_PromedioFinal_puntos)
				SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;$ar_PromedioOficial_real;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33;$ar_PromedioOficial_nota;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34;$ar_PromedioOficial_puntos;[Asignaturas_Historico:84]Promediable:6;$ab_IncidePromedioOficial;[Asignaturas_Historico:84]IncideEnPromedioInterno:27;$ab_IncidePromedioInterno;[Asignaturas_Historico:84]Horas_Semanales:35;$ai_HorasSemanales;[Asignaturas_Historico:84]PonderacionPromedioINT:23;$ar_FactorInterno;[Asignaturas_Historico:84]PonderacionEnPromedioOF:26;$ar_FactorOficial)
				SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
				
				$l_estiloInternoEsValido:=EVS_LeeEstiloEvalHistorico ($x_blobEstiloInterno)
				  //periodo 1
				$ar_PromedioPeriodo_real_P1{0}:=-10
				$b_hayEvaluaciones:=(AT_SearchArray (->$ar_PromedioPeriodo_real_P1;">")>0)
				If ($b_hayEvaluaciones)
					Case of 
						: ($l_modoPromedioInterno=Ponderado por factor)
							$r_mediaReal:=AL_PromedioPonderadoPorFactor (->$ar_PromedioPeriodo_real_P1;->$ar_FactorInterno)
							$r_mediaNota:=AL_PromedioPonderadoPorFactor (->$ar_PromedioPeriodo_nota_P1;->$ar_FactorInterno)
							$r_mediaPuntos:=AL_PromedioPonderadoPorFactor (->$ar_PromedioPeriodo_puntos_P1;->$ar_FactorInterno)
							
						: ($l_modoPromedioInterno=Ponderado por Int Horaria)
							$r_mediaReal:=AL_PromedioPonderadoPorHoras (->$ar_PromedioPeriodo_real_P1;->$ai_HorasSemanales)
							$r_mediaNota:=AL_PromedioPonderadoPorHoras (->$ar_PromedioPeriodo_nota_P1;->$ai_HorasSemanales)
							$r_mediaPuntos:=AL_PromedioPonderadoPorHoras (->$ar_PromedioPeriodo_puntos_P1;->$ai_HorasSemanales)
							
						: ($l_modoPromedioInterno=Sin ponderaciones)
							$r_mediaReal:=Round:C94(AT_Mean (->$ar_PromedioPeriodo_real_P1;$l_opcionCalculoPromedio);11)
							$r_mediaNota:=Round:C94(AT_Mean (->$ar_PromedioPeriodo_nota_P1;$l_opcionCalculoPromedio);11)
							$r_mediaPuntos:=Round:C94(AT_Mean (->$ar_PromedioPeriodo_puntos_P1;$l_opcionCalculoPromedio);11)
					End case 
					
					$r_media:=$r_mediaReal
					If (iPrintMode=Simbolos)
						$r_media:=$r_mediaReal
						Case of 
							: ((viEVS_EquMode=Notas) & (vi_ConvertSymbolicAverage=1))
								$r_mediaNota:=EV2_Real_a_Nota ($r_media;$l_truncarPromedio;iGradesDecPP)
								$r_mediaReal:=EV2_Nota_a_Real ($r_mediaNota)
								$t_mediaSimbolos:=EV2_Real_a_Simbolo ($r_mediaReal)
								$r_mediaPuntos:=EV2_Real_a_Puntos ($r_mediaReal;$l_truncarPromedio;iPointsDecPP)
							: ((viEVS_EquMode=Puntos) & (vi_ConvertSymbolicAverage=1))
								$r_mediaPuntos:=EV2_Real_a_Puntos ($r_media;$l_truncarPromedio;iPointsDecPP)
								$r_mediaReal:=EV2_Puntos_a_Real ($r_mediaPuntos)
								$t_mediaSimbolos:=EV2_Real_a_Simbolo ($r_mediaReal)
								$r_mediaNota:=EV2_Real_a_Nota ($r_mediaReal;$l_truncarPromedio;iGradesDecPP)
							Else 
								$t_mediaSimbolos:=NTA_PercentValue2StringValue ($r_mediaReal;Simbolos;$l_IdEstiloEvaluacionInterno)
						End case 
					Else 
						Case of 
							: (iPrintMode=Notas)
								$r_mediaNota:=EV2_Real_a_Nota ($r_media;$l_truncarPromedio;iGradesDecPP)
								$r_mediaReal:=EV2_Nota_a_Real ($r_mediaNota)
								$t_mediaSimbolos:=EV2_Real_a_Simbolo ($r_mediaReal)
								$r_mediaPuntos:=EV2_Real_a_Puntos ($r_mediaReal;$l_truncarPromedio;iPointsDecPP)
							: (iPrintMode=Puntos)
								$r_mediaPuntos:=EV2_Real_a_Puntos ($r_media;$l_truncarPromedio;iPointsDecPP)
								$r_mediaReal:=EV2_Puntos_a_Real ($r_mediaPuntos)
								$t_mediaSimbolos:=EV2_Real_a_Simbolo ($r_mediaReal)
								$r_mediaNota:=EV2_Real_a_Nota ($r_mediaReal;$l_truncarPromedio;iGradesDecPP)
						End case 
					End if 
					$t_mediaLiteralInterno:=NTA_PercentValue2StringValue ($r_mediaReal;$l_modoImpresionInterno;$l_IdEstiloEvaluacionInterno)
					[Alumnos_SintesisAnual:210]P01_PromedioInterno_Real:92:=$r_mediaReal
					[Alumnos_SintesisAnual:210]P01_PromedioInterno_Nota:93:=$r_mediaNota
					[Alumnos_SintesisAnual:210]P01_PromedioInterno_Puntos:94:=$r_mediaPuntos
					[Alumnos_SintesisAnual:210]P01_PromedioInterno_Simbolo:95:=$t_mediaSimbolos
					[Alumnos_SintesisAnual:210]P01_PromedioInterno_Literal:96:=$t_mediaLiteralInterno
				End if 
				
				  //periodo 2
				$ar_PromedioPeriodo_real_P2{0}:=-10
				$b_hayEvaluaciones:=(AT_SearchArray (->$ar_PromedioPeriodo_real_P2;">")>0)
				If ($b_hayEvaluaciones)
					Case of 
						: ($l_modoPromedioInterno=Ponderado por factor)
							$r_mediaReal:=AL_PromedioPonderadoPorFactor (->$ar_PromedioPeriodo_real_P2;->$ar_FactorInterno)
							$r_mediaNota:=AL_PromedioPonderadoPorFactor (->$ar_PromedioPeriodo_nota_P2;->$ar_FactorInterno)
							$r_mediaPuntos:=AL_PromedioPonderadoPorFactor (->$ar_PromedioPeriodo_puntos_P2;->$ar_FactorInterno)
							
						: ($l_modoPromedioInterno=Ponderado por Int Horaria)
							$r_mediaReal:=AL_PromedioPonderadoPorHoras (->$ar_PromedioPeriodo_real_P2;->$ai_HorasSemanales)
							$r_mediaNota:=AL_PromedioPonderadoPorHoras (->$ar_PromedioPeriodo_nota_P2;->$ai_HorasSemanales)
							$r_mediaPuntos:=AL_PromedioPonderadoPorHoras (->$ar_PromedioPeriodo_puntos_P2;->$ai_HorasSemanales)
							
						: ($l_modoPromedioInterno=Sin ponderaciones)
							$r_mediaReal:=Round:C94(AT_Mean (->$ar_PromedioPeriodo_real_P2;$l_opcionCalculoPromedio);11)
							$r_mediaNota:=Round:C94(AT_Mean (->$ar_PromedioPeriodo_nota_P2;$l_opcionCalculoPromedio);11)
							$r_mediaPuntos:=Round:C94(AT_Mean (->$ar_PromedioPeriodo_puntos_P2;$l_opcionCalculoPromedio);11)
					End case 
					
					$r_media:=$r_mediaReal
					If (iPrintMode=Simbolos)
						$r_media:=$r_mediaReal
						Case of 
							: ((viEVS_EquMode=Notas) & (vi_ConvertSymbolicAverage=1))
								$r_mediaNota:=EV2_Real_a_Nota ($r_media;$l_truncarPromedio;iGradesDecPP)
								$r_mediaReal:=EV2_Nota_a_Real ($r_mediaNota)
								$t_mediaSimbolos:=EV2_Real_a_Simbolo ($r_mediaReal)
								$r_mediaPuntos:=EV2_Real_a_Puntos ($r_mediaReal;$l_truncarPromedio;iPointsDecPP)
							: ((viEVS_EquMode=Puntos) & (vi_ConvertSymbolicAverage=1))
								$r_mediaPuntos:=EV2_Real_a_Puntos ($r_media;$l_truncarPromedio;iPointsDecPP)
								$r_mediaReal:=EV2_Puntos_a_Real ($r_mediaPuntos)
								$t_mediaSimbolos:=EV2_Real_a_Simbolo ($r_mediaReal)
								$r_mediaNota:=EV2_Real_a_Nota ($r_mediaReal;$l_truncarPromedio;iGradesDecPP)
							Else 
								$t_mediaSimbolos:=NTA_PercentValue2StringValue ($r_mediaReal;Simbolos;$l_IdEstiloEvaluacionInterno)
						End case 
					Else 
						Case of 
							: (iPrintMode=Notas)
								$r_mediaNota:=EV2_Real_a_Nota ($r_media;$l_truncarPromedio;iGradesDecPP)
								$r_mediaReal:=EV2_Nota_a_Real ($r_mediaNota)
								$t_mediaSimbolos:=EV2_Real_a_Simbolo ($r_mediaReal)
								$r_mediaPuntos:=EV2_Real_a_Puntos ($r_mediaReal;$l_truncarPromedio;iPointsDecPP)
							: (iPrintMode=Puntos)
								$r_mediaPuntos:=EV2_Real_a_Puntos ($r_media;$l_truncarPromedio;iPointsDecPP)
								$r_mediaReal:=EV2_Puntos_a_Real ($r_mediaPuntos)
								$t_mediaSimbolos:=EV2_Real_a_Simbolo ($r_mediaReal)
								$r_mediaNota:=EV2_Real_a_Nota ($r_mediaReal;$l_truncarPromedio;iGradesDecPP)
						End case 
					End if 
					$t_mediaLiteralInterno:=NTA_PercentValue2StringValue ($r_mediaReal;$l_modoImpresionInterno;$l_IdEstiloEvaluacionInterno)
					[Alumnos_SintesisAnual:210]P02_PromedioInterno_Real:121:=$r_mediaReal
					[Alumnos_SintesisAnual:210]P02_PromedioInterno_Nota:122:=$r_mediaNota
					[Alumnos_SintesisAnual:210]P02_PromedioInterno_Puntos:123:=$r_mediaPuntos
					[Alumnos_SintesisAnual:210]P02_PromedioInterno_Simbolo:124:=$t_mediaSimbolos
					[Alumnos_SintesisAnual:210]P02_PromedioInterno_Literal:125:=$t_mediaLiteralInterno
				End if 
				
				  //periodo 3
				$ar_PromedioPeriodo_real_P3{0}:=-10
				$b_hayEvaluaciones:=(AT_SearchArray (->$ar_PromedioPeriodo_real_P3;">")>0)
				If ($b_hayEvaluaciones)
					Case of 
						: ($l_modoPromedioInterno=Ponderado por factor)
							$r_mediaReal:=AL_PromedioPonderadoPorFactor (->$ar_PromedioPeriodo_real_P3;->$ar_FactorInterno)
							$r_mediaNota:=AL_PromedioPonderadoPorFactor (->$ar_PromedioPeriodo_nota_P3;->$ar_FactorInterno)
							$r_mediaPuntos:=AL_PromedioPonderadoPorFactor (->$ar_PromedioPeriodo_puntos_P3;->$ar_FactorInterno)
							
						: ($l_modoPromedioInterno=Ponderado por Int Horaria)
							$r_mediaReal:=AL_PromedioPonderadoPorHoras (->$ar_PromedioPeriodo_real_P3;->$ai_HorasSemanales)
							$r_mediaNota:=AL_PromedioPonderadoPorHoras (->$ar_PromedioPeriodo_nota_P3;->$ai_HorasSemanales)
							$r_mediaPuntos:=AL_PromedioPonderadoPorHoras (->$ar_PromedioPeriodo_puntos_P3;->$ai_HorasSemanales)
							
						: ($l_modoPromedioInterno=Sin ponderaciones)
							$r_mediaReal:=Round:C94(AT_Mean (->$ar_PromedioPeriodo_real_P3;$l_opcionCalculoPromedio);11)
							$r_mediaNota:=Round:C94(AT_Mean (->$ar_PromedioPeriodo_nota_P3;$l_opcionCalculoPromedio);11)
							$r_mediaPuntos:=Round:C94(AT_Mean (->$ar_PromedioPeriodo_puntos_P3;$l_opcionCalculoPromedio);11)
					End case 
					
					$r_media:=$r_mediaReal
					If (iPrintMode=Simbolos)
						$r_media:=$r_mediaReal
						Case of 
							: ((viEVS_EquMode=Notas) & (vi_ConvertSymbolicAverage=1))
								$r_mediaNota:=EV2_Real_a_Nota ($r_media;$l_truncarPromedio;iGradesDecPP)
								$r_mediaReal:=EV2_Nota_a_Real ($r_mediaNota)
								$t_mediaSimbolos:=EV2_Real_a_Simbolo ($r_mediaReal)
								$r_mediaPuntos:=EV2_Real_a_Puntos ($r_mediaReal;$l_truncarPromedio;iPointsDecPP)
							: ((viEVS_EquMode=Puntos) & (vi_ConvertSymbolicAverage=1))
								$r_mediaPuntos:=EV2_Real_a_Puntos ($r_media;$l_truncarPromedio;iPointsDecPP)
								$r_mediaReal:=EV2_Puntos_a_Real ($r_mediaPuntos)
								$t_mediaSimbolos:=EV2_Real_a_Simbolo ($r_mediaReal)
								$r_mediaNota:=EV2_Real_a_Nota ($r_mediaReal;$l_truncarPromedio;iGradesDecPP)
							Else 
								$t_mediaSimbolos:=NTA_PercentValue2StringValue ($r_mediaReal;Simbolos;$l_IdEstiloEvaluacionInterno)
						End case 
					Else 
						Case of 
							: (iPrintMode=Notas)
								$r_mediaNota:=EV2_Real_a_Nota ($r_media;$l_truncarPromedio;iGradesDecPP)
								$r_mediaReal:=EV2_Nota_a_Real ($r_mediaNota)
								$t_mediaSimbolos:=EV2_Real_a_Simbolo ($r_mediaReal)
								$r_mediaPuntos:=EV2_Real_a_Puntos ($r_mediaReal;$l_truncarPromedio;iPointsDecPP)
							: (iPrintMode=Puntos)
								$r_mediaPuntos:=EV2_Real_a_Puntos ($r_media;$l_truncarPromedio;iPointsDecPP)
								$r_mediaReal:=EV2_Puntos_a_Real ($r_mediaPuntos)
								$t_mediaSimbolos:=EV2_Real_a_Simbolo ($r_mediaReal)
								$r_mediaNota:=EV2_Real_a_Nota ($r_mediaReal;$l_truncarPromedio;iGradesDecPP)
						End case 
					End if 
					$t_mediaLiteralInterno:=NTA_PercentValue2StringValue ($r_mediaReal;$l_modoImpresionInterno;$l_IdEstiloEvaluacionInterno)
					[Alumnos_SintesisAnual:210]P03_PromedioInterno_Real:150:=$r_mediaReal
					[Alumnos_SintesisAnual:210]P03_PromedioInterno_Nota:151:=$r_mediaNota
					[Alumnos_SintesisAnual:210]P03_PromedioInterno_Puntos:152:=$r_mediaPuntos
					[Alumnos_SintesisAnual:210]P03_PromedioInterno_Simbolo:153:=$t_mediaSimbolos
					[Alumnos_SintesisAnual:210]P03_PromedioInterno_Literal:154:=$t_mediaLiteralInterno
				End if 
				
				  //periodo 4
				$ar_PromedioPeriodo_real_P4{0}:=-10
				$b_hayEvaluaciones:=(AT_SearchArray (->$ar_PromedioPeriodo_real_P4;">")>0)
				If ($b_hayEvaluaciones)
					Case of 
						: ($l_modoPromedioInterno=Ponderado por factor)
							$r_mediaReal:=AL_PromedioPonderadoPorFactor (->$ar_PromedioPeriodo_real_P4;->$ar_FactorInterno)
							$r_mediaNota:=AL_PromedioPonderadoPorFactor (->$ar_PromedioPeriodo_nota_P4;->$ar_FactorInterno)
							$r_mediaPuntos:=AL_PromedioPonderadoPorFactor (->$ar_PromedioPeriodo_puntos_P4;->$ar_FactorInterno)
							
						: ($l_modoPromedioInterno=Ponderado por Int Horaria)
							$r_mediaReal:=AL_PromedioPonderadoPorHoras (->$ar_PromedioPeriodo_real_P4;->$ai_HorasSemanales)
							$r_mediaNota:=AL_PromedioPonderadoPorHoras (->$ar_PromedioPeriodo_nota_P4;->$ai_HorasSemanales)
							$r_mediaPuntos:=AL_PromedioPonderadoPorHoras (->$ar_PromedioPeriodo_puntos_P4;->$ai_HorasSemanales)
							
						: ($l_modoPromedioInterno=Sin ponderaciones)
							$r_mediaReal:=Round:C94(AT_Mean (->$ar_PromedioPeriodo_real_P4;$l_opcionCalculoPromedio);11)
							$r_mediaNota:=Round:C94(AT_Mean (->$ar_PromedioPeriodo_nota_P4;$l_opcionCalculoPromedio);11)
							$r_mediaPuntos:=Round:C94(AT_Mean (->$ar_PromedioPeriodo_puntos_P4;$l_opcionCalculoPromedio);11)
					End case 
					
					$r_media:=$r_mediaReal
					If (iPrintMode=Simbolos)
						$r_media:=$r_mediaReal
						Case of 
							: ((viEVS_EquMode=Notas) & (vi_ConvertSymbolicAverage=1))
								$r_mediaNota:=EV2_Real_a_Nota ($r_media;$l_truncarPromedio;iGradesDecPP)
								$r_mediaReal:=EV2_Nota_a_Real ($r_mediaNota)
								$t_mediaSimbolos:=EV2_Real_a_Simbolo ($r_mediaReal)
								$r_mediaPuntos:=EV2_Real_a_Puntos ($r_mediaReal;$l_truncarPromedio;iPointsDecPP)
							: ((viEVS_EquMode=Puntos) & (vi_ConvertSymbolicAverage=1))
								$r_mediaPuntos:=EV2_Real_a_Puntos ($r_media;$l_truncarPromedio;iPointsDecPP)
								$r_mediaReal:=EV2_Puntos_a_Real ($r_mediaPuntos)
								$t_mediaSimbolos:=EV2_Real_a_Simbolo ($r_mediaReal)
								$r_mediaNota:=EV2_Real_a_Nota ($r_mediaReal;$l_truncarPromedio;iGradesDecPP)
							Else 
								$t_mediaSimbolos:=NTA_PercentValue2StringValue ($r_mediaReal;Simbolos;$l_IdEstiloEvaluacionInterno)
						End case 
					Else 
						Case of 
							: (iPrintMode=Notas)
								$r_mediaNota:=EV2_Real_a_Nota ($r_media;$l_truncarPromedio;iGradesDecPP)
								$r_mediaReal:=EV2_Nota_a_Real ($r_mediaNota)
								$t_mediaSimbolos:=EV2_Real_a_Simbolo ($r_mediaReal)
								$r_mediaPuntos:=EV2_Real_a_Puntos ($r_mediaReal;$l_truncarPromedio;iPointsDecPP)
							: (iPrintMode=Puntos)
								$r_mediaPuntos:=EV2_Real_a_Puntos ($r_media;$l_truncarPromedio;iPointsDecPP)
								$r_mediaReal:=EV2_Puntos_a_Real ($r_mediaPuntos)
								$t_mediaSimbolos:=EV2_Real_a_Simbolo ($r_mediaReal)
								$r_mediaNota:=EV2_Real_a_Nota ($r_mediaReal;$l_truncarPromedio;iGradesDecPP)
						End case 
					End if 
					$t_mediaLiteralInterno:=NTA_PercentValue2StringValue ($r_mediaReal;$l_modoImpresionInterno;$l_IdEstiloEvaluacionInterno)
					[Alumnos_SintesisAnual:210]P04_PromedioInterno_Real:179:=$r_mediaReal
					[Alumnos_SintesisAnual:210]P04_PromedioInterno_Nota:180:=$r_mediaNota
					[Alumnos_SintesisAnual:210]P04_PromedioInterno_Puntos:181:=$r_mediaPuntos
					[Alumnos_SintesisAnual:210]P04_PromedioInterno_Simbolo:182:=$t_mediaSimbolos
					[Alumnos_SintesisAnual:210]P04_PromedioInterno_Literal:183:=$t_mediaLiteralInterno
				End if 
				
				  //periodo 5
				$ar_PromedioPeriodo_real_P5{0}:=-10
				$b_hayEvaluaciones:=(AT_SearchArray (->$ar_PromedioPeriodo_real_P5;">")>0)
				If ($b_hayEvaluaciones)
					Case of 
						: ($l_modoPromedioInterno=Ponderado por factor)
							$r_mediaReal:=AL_PromedioPonderadoPorFactor (->$ar_PromedioPeriodo_real_P5;->$ar_FactorInterno)
							$r_mediaNota:=AL_PromedioPonderadoPorFactor (->$ar_PromedioPeriodo_nota_P5;->$ar_FactorInterno)
							$r_mediaPuntos:=AL_PromedioPonderadoPorFactor (->$ar_PromedioPeriodo_puntos_P5;->$ar_FactorInterno)
							
						: ($l_modoPromedioInterno=Ponderado por Int Horaria)
							$r_mediaReal:=AL_PromedioPonderadoPorHoras (->$ar_PromedioPeriodo_real_P5;->$ai_HorasSemanales)
							$r_mediaNota:=AL_PromedioPonderadoPorHoras (->$ar_PromedioPeriodo_nota_P5;->$ai_HorasSemanales)
							$r_mediaPuntos:=AL_PromedioPonderadoPorHoras (->$ar_PromedioPeriodo_puntos_P5;->$ai_HorasSemanales)
							
						: ($l_modoPromedioInterno=Sin ponderaciones)
							$r_mediaReal:=Round:C94(AT_Mean (->$ar_PromedioPeriodo_real_P5;$l_opcionCalculoPromedio);51)
							$r_mediaNota:=Round:C94(AT_Mean (->$ar_PromedioPeriodo_nota_P5;$l_opcionCalculoPromedio);11)
							$r_mediaPuntos:=Round:C94(AT_Mean (->$ar_PromedioPeriodo_puntos_P5;$l_opcionCalculoPromedio);11)
					End case 
					
					$r_media:=$r_mediaReal
					If (iPrintMode=Simbolos)
						$r_media:=$r_mediaReal
						Case of 
							: ((viEVS_EquMode=Notas) & (vi_ConvertSymbolicAverage=1))
								$r_mediaNota:=EV2_Real_a_Nota ($r_media;$l_truncarPromedio;iGradesDecPP)
								$r_mediaReal:=EV2_Nota_a_Real ($r_mediaNota)
								$t_mediaSimbolos:=EV2_Real_a_Simbolo ($r_mediaReal)
								$r_mediaPuntos:=EV2_Real_a_Puntos ($r_mediaReal;$l_truncarPromedio;iPointsDecPP)
							: ((viEVS_EquMode=Puntos) & (vi_ConvertSymbolicAverage=1))
								$r_mediaPuntos:=EV2_Real_a_Puntos ($r_media;$l_truncarPromedio;iPointsDecPP)
								$r_mediaReal:=EV2_Puntos_a_Real ($r_mediaPuntos)
								$t_mediaSimbolos:=EV2_Real_a_Simbolo ($r_mediaReal)
								$r_mediaNota:=EV2_Real_a_Nota ($r_mediaReal;$l_truncarPromedio;iGradesDecPP)
							Else 
								$t_mediaSimbolos:=NTA_PercentValue2StringValue ($r_mediaReal;Simbolos;$l_IdEstiloEvaluacionInterno)
						End case 
					Else 
						Case of 
							: (iPrintMode=Notas)
								$r_mediaNota:=EV2_Real_a_Nota ($r_media;$l_truncarPromedio;iGradesDecPP)
								$r_mediaReal:=EV2_Nota_a_Real ($r_mediaNota)
								$t_mediaSimbolos:=EV2_Real_a_Simbolo ($r_mediaReal)
								$r_mediaPuntos:=EV2_Real_a_Puntos ($r_mediaReal;$l_truncarPromedio;iPointsDecPP)
							: (iPrintMode=Puntos)
								$r_mediaPuntos:=EV2_Real_a_Puntos ($r_media;$l_truncarPromedio;iPointsDecPP)
								$r_mediaReal:=EV2_Puntos_a_Real ($r_mediaPuntos)
								$t_mediaSimbolos:=EV2_Real_a_Simbolo ($r_mediaReal)
								$r_mediaNota:=EV2_Real_a_Nota ($r_mediaReal;$l_truncarPromedio;iGradesDecPP)
						End case 
					End if 
					$t_mediaLiteralInterno:=NTA_PercentValue2StringValue ($r_mediaReal;$l_modoImpresionInterno;$l_IdEstiloEvaluacionInterno)
					[Alumnos_SintesisAnual:210]P05_PromedioInterno_Real:208:=$r_mediaReal
					[Alumnos_SintesisAnual:210]P05_PromedioInterno_Nota:209:=$r_mediaNota
					[Alumnos_SintesisAnual:210]P05_PromedioInterno_Puntos:210:=$r_mediaPuntos
					[Alumnos_SintesisAnual:210]P05_PromedioInterno_Simbolo:211:=$t_mediaSimbolos
					[Alumnos_SintesisAnual:210]P05_PromedioInterno_Literal:212:=$t_mediaLiteralInterno
				End if 
				
				  //promedio Anual INTERNO
				$ar_PromedioAnual_real{0}:=-10
				$b_hayEvaluaciones:=(AT_SearchArray (->$ar_PromedioAnual_real;">")>0)
				If ($b_hayEvaluaciones)
					Case of 
						: ($l_modoPromedioInterno=Ponderado por factor)
							$r_mediaReal:=AL_PromedioPonderadoPorFactor (->$ar_PromedioAnual_real;->$ar_FactorInterno)
							$r_mediaNota:=AL_PromedioPonderadoPorFactor (->$ar_PromedioAnual_nota;->$ar_FactorInterno)
							$r_mediaPuntos:=AL_PromedioPonderadoPorFactor (->$ar_PromedioAnual_puntos;->$ar_FactorInterno)
							
						: ($l_modoPromedioInterno=Ponderado por Int Horaria)
							$r_mediaReal:=AL_PromedioPonderadoPorHoras (->$ar_PromedioAnual_real;->$ai_HorasSemanales)
							$r_mediaNota:=AL_PromedioPonderadoPorHoras (->$ar_PromedioAnual_nota;->$ai_HorasSemanales)
							$r_mediaPuntos:=AL_PromedioPonderadoPorHoras (->$ar_PromedioAnual_puntos;->$ai_HorasSemanales)
							
						: ($l_modoPromedioInterno=Sin ponderaciones)
							$r_mediaReal:=Round:C94(AT_Mean (->$ar_PromedioAnual_real;$l_opcionCalculoPromedio);11)
							$r_mediaNota:=Round:C94(AT_Mean (->$ar_PromedioAnual_nota;$l_opcionCalculoPromedio);11)
							$r_mediaPuntos:=Round:C94(AT_Mean (->$ar_PromedioAnual_puntos;$l_opcionCalculoPromedio);11)
					End case 
					
					$r_media:=$r_mediaReal
					If (iPrintMode=Simbolos)
						$r_media:=$r_mediaReal
						Case of 
							: ((viEVS_EquMode=Notas) & (vi_ConvertSymbolicAverage=1))
								$r_mediaNota:=EV2_Real_a_Nota ($r_media;$l_truncarPromedio;iGradesDecPF)
								$r_mediaReal:=EV2_Nota_a_Real ($r_mediaNota)
								$t_mediaSimbolos:=EV2_Real_a_Simbolo ($r_mediaReal)
								$r_mediaPuntos:=EV2_Real_a_Puntos ($r_mediaReal;$l_truncarPromedio;iPointsDecPF)
							: ((viEVS_EquMode=Puntos) & (vi_ConvertSymbolicAverage=1))
								$r_mediaPuntos:=EV2_Real_a_Puntos ($r_media;$l_truncarPromedio;iPointsDecPF)
								$r_mediaReal:=EV2_Puntos_a_Real ($r_mediaPuntos)
								$t_mediaSimbolos:=EV2_Real_a_Simbolo ($r_mediaReal)
								$r_mediaNota:=EV2_Real_a_Nota ($r_mediaReal;$l_truncarPromedio;iGradesDecPF)
							Else 
								$t_mediaSimbolos:=NTA_PercentValue2StringValue ($r_mediaReal;Simbolos;$l_IdEstiloEvaluacionInterno)
						End case 
					Else 
						Case of 
							: (iPrintMode=Notas)
								$r_mediaNota:=EV2_Real_a_Nota ($r_media;$l_truncarPromedio;iGradesDecPF)
								$r_mediaReal:=EV2_Nota_a_Real ($r_mediaNota)
								$t_mediaSimbolos:=EV2_Real_a_Simbolo ($r_mediaReal)
								$r_mediaPuntos:=EV2_Real_a_Puntos ($r_mediaReal;$l_truncarPromedio;iPointsDecPF)
							: (iPrintMode=Puntos)
								$r_mediaPuntos:=EV2_Real_a_Puntos ($r_media;$l_truncarPromedio;iPointsDecPF)
								$r_mediaReal:=EV2_Puntos_a_Real ($r_mediaPuntos)
								$t_mediaSimbolos:=EV2_Real_a_Simbolo ($r_mediaReal)
								$r_mediaNota:=EV2_Real_a_Nota ($r_mediaReal;$l_truncarPromedio;iGradesDecPF)
						End case 
					End if 
					$t_mediaLiteralInterno:=NTA_PercentValue2StringValue ($r_mediaReal;$l_modoImpresionInterno;$l_IdEstiloEvaluacionInterno)
					[Alumnos_SintesisAnual:210]PromedioAnualInterno_Real:10:=$r_mediaReal
					[Alumnos_SintesisAnual:210]PromedioAnualInterno_Nota:11:=$r_mediaNota
					[Alumnos_SintesisAnual:210]PromedioAnualInterno_Puntos:12:=$r_mediaPuntos
					[Alumnos_SintesisAnual:210]PromedioAnualInterno_Simbolo:13:=$t_mediaSimbolos
					[Alumnos_SintesisAnual:210]PromedioAnualInterno_Literal:14:=$t_mediaLiteralInterno
				End if 
				
				  //promedio final INTERNO
				$ar_PromedioFinal_real{0}:=-10
				$b_hayEvaluaciones:=(AT_SearchArray (->$ar_PromedioFinal_real;">")>0)
				If ($b_hayEvaluaciones)
					Case of 
						: ($l_modoPromedioInterno=Ponderado por factor)
							$r_mediaReal:=AL_PromedioPonderadoPorFactor (->$ar_PromedioFinal_real;->$ar_FactorInterno)
							  //$r_mediaNota:=AL_PromedioPonderadoPorFactor (->$ar_PromedioFinal_nota;->$ar_FactorInterno)
							$r_mediaPuntos:=AL_PromedioPonderadoPorFactor (->$ar_PromedioFinal_puntos;->$ar_FactorInterno)
							
						: ($l_modoPromedioInterno=Ponderado por Int Horaria)
							$r_mediaReal:=AL_PromedioPonderadoPorHoras (->$ar_PromedioFinal_real;->$ai_HorasSemanales)
							  //$r_mediaNota:=AL_PromedioPonderadoPorHoras (->$ar_PromedioFinal_nota;->$ai_HorasSemanales)
							$r_mediaPuntos:=AL_PromedioPonderadoPorHoras (->$ar_PromedioFinal_puntos;->$ai_HorasSemanales)
							
						: ($l_modoPromedioInterno=Sin ponderaciones)
							$r_mediaReal:=Round:C94(AT_Mean (->$ar_PromedioFinal_real;$l_opcionCalculoPromedio);11)
							  //$r_mediaNota:=Round(AT_Mean (->$ar_PromedioFinal_nota;$l_opcionCalculoPromedio);11)
							$r_mediaPuntos:=Round:C94(AT_Mean (->$ar_PromedioFinal_puntos;$l_opcionCalculoPromedio);11)
					End case 
					
					  //Calculo este promedio con el real ya que se dieron casos en que los arreglos de notas venían con escalas distintas (5.6  - 70 - 1.0 etc)
					$r_mediaNota:=EV2_Real_a_Nota ($r_mediaReal;0;11)
					
					If ($r_mediaReal>=vrNTA_MinimoEscalaReferencia)
						Case of 
							: (iEvaluationMode=Notas)
								$t_mediaLiteral:=String:C10($r_mediaNota)
							: (iEvaluationMode=Puntos)
								$t_mediaLiteral:=String:C10($r_mediaPuntos)
							: ((iEvaluationMode=Porcentaje) | (iEvaluationMode=Simbolos))
								$t_mediaLiteral:=String:C10($r_mediaReal)
						End case 
					End if 
					[Alumnos_SintesisAnual:210]PromedioInt_NoAprox_Real:272:=$r_mediaReal
					[Alumnos_SintesisAnual:210]PromedioInt_NoAprox_Nota:273:=$r_mediaNota
					[Alumnos_SintesisAnual:210]PromedioInt_NoAprox_Puntos:274:=$r_mediaPuntos
					[Alumnos_SintesisAnual:210]PromedioInt_NoAprox_Literal:275:=$t_mediaLiteral
					
					$r_media:=$r_mediaReal
					If (iPrintMode=Simbolos)
						$r_media:=$r_mediaReal
						Case of 
							: ((viEVS_EquMode=Notas) & (vi_ConvertSymbolicAverage=1))
								$r_mediaNota:=EV2_Real_a_Nota ($r_media;$l_truncarPromedio;iGradesDecNF)
								$r_mediaReal:=EV2_Nota_a_Real ($r_mediaNota)
								$t_mediaSimbolos:=EV2_Real_a_Simbolo ($r_mediaReal)
								$r_mediaPuntos:=EV2_Real_a_Puntos ($r_mediaReal;$l_truncarPromedio;iPointsDecNF)
							: ((viEVS_EquMode=Puntos) & (vi_ConvertSymbolicAverage=1))
								$r_mediaPuntos:=EV2_Real_a_Puntos ($r_media;$l_truncarPromedio;iPointsDecNF)
								$r_mediaReal:=EV2_Puntos_a_Real ($r_mediaPuntos)
								$t_mediaSimbolos:=EV2_Real_a_Simbolo ($r_mediaReal)
								$r_mediaNota:=EV2_Real_a_Nota ($r_mediaReal;$l_truncarPromedio;iGradesDecNF)
							Else 
								$t_mediaSimbolos:=NTA_PercentValue2StringValue ($r_mediaReal;Simbolos;$l_IdEstiloEvaluacionInterno)
						End case 
					Else 
						Case of 
							: (iPrintMode=Notas)
								$r_mediaNota:=EV2_Real_a_Nota ($r_media;$l_truncarPromedio;iGradesDecNF)
								$r_mediaReal:=EV2_Nota_a_Real ($r_mediaNota)
								$t_mediaSimbolos:=EV2_Real_a_Simbolo ($r_mediaReal)
								$r_mediaPuntos:=EV2_Real_a_Puntos ($r_mediaReal;$l_truncarPromedio;iPointsDecNF)
							: (iPrintMode=Puntos)
								$r_mediaPuntos:=EV2_Real_a_Puntos ($r_media;$l_truncarPromedio;iPointsDecNF)
								$r_mediaReal:=EV2_Puntos_a_Real ($r_mediaPuntos)
								$t_mediaSimbolos:=EV2_Real_a_Simbolo ($r_mediaReal)
								$r_mediaNota:=EV2_Real_a_Nota ($r_mediaReal;$l_truncarPromedio;iGradesDecNF)
						End case 
					End if 
					$t_mediaLiteralInterno:=NTA_PercentValue2StringValue ($r_mediaReal;$l_modoImpresionInterno;$l_IdEstiloEvaluacionInterno)
					[Alumnos_SintesisAnual:210]PromedioFinalInterno_Real:20:=$r_mediaReal
					[Alumnos_SintesisAnual:210]PromedioFinalInterno_Nota:21:=$r_mediaNota
					[Alumnos_SintesisAnual:210]PromedioFinalInterno_Puntos:22:=$r_mediaPuntos
					[Alumnos_SintesisAnual:210]PromedioFinalInterno_Simbolo:23:=$t_mediaSimbolos
					[Alumnos_SintesisAnual:210]PromedioFinalInterno_Literal:24:=$t_mediaLiteralInterno
					SAVE RECORD:C53([Alumnos_SintesisAnual:210])
				End if 
				
			End if 
			
			  //CALCULO DE PROMEDIOS OFICIALES
			$l_estiloOficialEsValido:=EVS_LeeEstiloEvalHistorico ($x_blobEstiloOficial)  // lectura del estilo oficial
			
			SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
			USE SET:C118("Calificaciones")
			QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas_Historico:84]Promediable:6=True:C214)
			
			If (Records in selection:C76([Alumnos_Calificaciones:208])>0)
				$l_estiloOficialEsValido:=EVS_LeeEstiloEvalHistorico ($x_blobEstiloOficial)  // lectura del estilo oficial
				ORDER BY:C49([Alumnos_Calificaciones:208];[Asignaturas_Historico:84]OrdenGeneral:42;>)
				SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P01_Final_Real:112;$ar_PromedioPeriodo_real_P1;[Alumnos_Calificaciones:208]P02_Final_Real:187;$ar_PromedioPeriodo_real_P2;[Alumnos_Calificaciones:208]P03_Final_Real:262;$ar_PromedioPeriodo_real_P3;[Alumnos_Calificaciones:208]P04_Final_Real:337;$ar_PromedioPeriodo_real_P4;[Alumnos_Calificaciones:208]P05_Final_Real:412;$ar_PromedioPeriodo_real_P5)
				SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P01_Final_Nota:113;$ar_PromedioPeriodo_nota_P1;[Alumnos_Calificaciones:208]P02_Final_Nota:188;$ar_PromedioPeriodo_nota_P2;[Alumnos_Calificaciones:208]P03_Final_Nota:263;$ar_PromedioPeriodo_nota_P3;[Alumnos_Calificaciones:208]P04_Final_Nota:338;$ar_PromedioPeriodo_nota_P4;[Alumnos_Calificaciones:208]P05_Final_Nota:413;$ar_PromedioPeriodo_nota_P5)
				SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P01_Final_Puntos:114;$ar_PromedioPeriodo_puntos_P1;[Alumnos_Calificaciones:208]P02_Final_Puntos:189;$ar_PromedioPeriodo_puntos_P2;[Alumnos_Calificaciones:208]P03_Final_Puntos:264;$ar_PromedioPeriodo_puntos_P3;[Alumnos_Calificaciones:208]P04_Final_Puntos:339;$ar_PromedioPeriodo_puntos_P4;[Alumnos_Calificaciones:208]P05_Final_Puntos:414;$ar_PromedioPeriodo_puntos_P5)
				SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]Anual_Real:11;$ar_PromedioAnual_real;[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;$ar_PromedioFinal_real;[Alumnos_Calificaciones:208]Anual_Nota:12;$ar_PromedioAnual_nota;[Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27;$ar_PromedioFinal_nota;[Alumnos_Calificaciones:208]Anual_Puntos:13;$ar_PromedioAnual_puntos;[Alumnos_Calificaciones:208]EvaluacionFinal_Puntos:28;$ar_PromedioFinal_puntos)
				SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;$ar_PromedioOficial_real;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33;$ar_PromedioOficial_nota;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34;$ar_PromedioOficial_puntos;[Asignaturas_Historico:84]Promediable:6;$ab_IncidePromedioOficial;[Asignaturas_Historico:84]IncideEnPromedioInterno:27;$ab_IncidePromedioInterno;[Asignaturas_Historico:84]Horas_Semanales:35;$ai_HorasSemanales;[Asignaturas_Historico:84]PonderacionEnPromedioOF:26;$ar_FactorOficial)
				SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
				
				If ($l_minimoEnEstiloOficial=0)
					$l_opcionCalculoPromedio:=3  //0 o mayor que 0
				Else 
					$l_opcionCalculoPromedio:=1  //solo valores positivos
				End if 
				
				  //periodo 1
				$ar_PromedioPeriodo_real_P1{0}:=-10
				$b_hayEvaluaciones:=(AT_SearchArray (->$ar_PromedioPeriodo_real_P1;">")>0)
				If ($b_hayEvaluaciones)
					
					Case of 
						: ($l_modoPromedioOficial=Ponderado por factor)
							$r_mediaReal:=AL_PromedioPonderadoPorFactor (->$ar_PromedioPeriodo_real_P1;->$ar_FactorOficial)
							$r_mediaNota:=AL_PromedioPonderadoPorFactor (->$ar_PromedioPeriodo_nota_P1;->$ar_FactorOficial)
							$r_mediaPuntos:=AL_PromedioPonderadoPorFactor (->$ar_PromedioPeriodo_puntos_P1;->$ar_FactorOficial)
							
						: ($l_modoPromedioOficial=Ponderado por Int Horaria)
							$r_mediaReal:=AL_PromedioPonderadoPorHoras (->$ar_PromedioPeriodo_real_P1;->$ai_HorasSemanales)
							$r_mediaNota:=AL_PromedioPonderadoPorHoras (->$ar_PromedioPeriodo_nota_P1;->$ai_HorasSemanales)
							$r_mediaPuntos:=AL_PromedioPonderadoPorHoras (->$ar_PromedioPeriodo_puntos_P1;->$ai_HorasSemanales)
							
						: ($l_modoPromedioOficial=Sin ponderaciones)
							$r_mediaReal:=Round:C94(AT_Mean (->$ar_PromedioPeriodo_real_P1;$l_opcionCalculoPromedio);11)
							$r_mediaNota:=Round:C94(AT_Mean (->$ar_PromedioPeriodo_nota_P1;$l_opcionCalculoPromedio);11)
							$r_mediaPuntos:=Round:C94(AT_Mean (->$ar_PromedioPeriodo_puntos_P1;$l_opcionCalculoPromedio);11)
					End case 
					
					$r_media:=$r_mediaReal
					If (iPrintMode=Simbolos)
						$r_media:=$r_mediaReal
						Case of 
							: ((viEVS_EquMode=Notas) & (vi_ConvertSymbolicAverage=1))
								$r_mediaNota:=EV2_Real_a_Nota ($r_media;$l_truncarPromedio;iGradesDecPP)
								$r_mediaReal:=EV2_Nota_a_Real ($r_mediaNota)
								$t_mediaSimbolos:=EV2_Real_a_Simbolo ($r_mediaReal)
								$r_mediaPuntos:=EV2_Real_a_Puntos ($r_mediaReal;$l_truncarPromedio;iPointsDecPP)
							: ((viEVS_EquMode=Puntos) & (vi_ConvertSymbolicAverage=1))
								$r_mediaPuntos:=EV2_Real_a_Puntos ($r_media;$l_truncarPromedio;iPointsDecPP)
								$r_mediaReal:=EV2_Puntos_a_Real ($r_mediaPuntos)
								$t_mediaSimbolos:=EV2_Real_a_Simbolo ($r_mediaReal)
								$r_mediaNota:=EV2_Real_a_Nota ($r_mediaReal;$l_truncarPromedio;iGradesDecPP)
							Else 
								$t_mediaSimbolos:=NTA_PercentValue2StringValue ($r_mediaReal;Simbolos;$l_IdEstiloEvaluacionInterno)
						End case 
					Else 
						Case of 
							: (iPrintMode=Notas)
								$r_mediaNota:=EV2_Real_a_Nota ($r_media;$l_truncarPromedio;iGradesDecPP)
								$r_mediaReal:=EV2_Nota_a_Real ($r_mediaNota)
								$t_mediaSimbolos:=EV2_Real_a_Simbolo ($r_mediaReal)
								$r_mediaPuntos:=EV2_Real_a_Puntos ($r_mediaReal;$l_truncarPromedio;iPointsDecPP)
							: (iPrintMode=Puntos)
								$r_mediaPuntos:=EV2_Real_a_Puntos ($r_media;$l_truncarPromedio;iPointsDecPP)
								$r_mediaReal:=EV2_Puntos_a_Real ($r_mediaPuntos)
								$t_mediaSimbolos:=EV2_Real_a_Simbolo ($r_mediaReal)
								$r_mediaNota:=EV2_Real_a_Nota ($r_mediaReal;$l_truncarPromedio;iGradesDecPP)
						End case 
					End if 
					$t_mediaLiteralOficial:=NTA_PercentValue2StringValue ($r_mediaReal;$l_modoImpresionOficial;$l_IdEstiloEvaluacionOficial)
					[Alumnos_SintesisAnual:210]P01_PromedioOficial_Real:237:=$r_mediaReal
					[Alumnos_SintesisAnual:210]P01_PromedioOficial_Nota:238:=$r_mediaNota
					[Alumnos_SintesisAnual:210]P01_PromedioOficial_Puntos:239:=$r_mediaPuntos
					[Alumnos_SintesisAnual:210]P01_PromedioOficial_Simbolo:240:=$t_mediaSimbolos
					[Alumnos_SintesisAnual:210]P01_PromedioOficial_Literal:241:=$t_mediaLiteralOficial
				End if 
				
				  //periodo 2
				$ar_PromedioPeriodo_real_P2{0}:=-10
				$b_hayEvaluaciones:=(AT_SearchArray (->$ar_PromedioPeriodo_real_P2;">")>0)
				If ($b_hayEvaluaciones)
					
					Case of 
						: ($l_modoPromedioOficial=Ponderado por factor)
							$r_mediaReal:=AL_PromedioPonderadoPorFactor (->$ar_PromedioPeriodo_real_P2;->$ar_FactorOficial)
							$r_mediaNota:=AL_PromedioPonderadoPorFactor (->$ar_PromedioPeriodo_nota_P2;->$ar_FactorOficial)
							$r_mediaPuntos:=AL_PromedioPonderadoPorFactor (->$ar_PromedioPeriodo_puntos_P2;->$ar_FactorOficial)
							
						: ($l_modoPromedioOficial=Ponderado por Int Horaria)
							$r_mediaReal:=AL_PromedioPonderadoPorHoras (->$ar_PromedioPeriodo_real_P2;->$ai_HorasSemanales)
							$r_mediaNota:=AL_PromedioPonderadoPorHoras (->$ar_PromedioPeriodo_nota_P2;->$ai_HorasSemanales)
							$r_mediaPuntos:=AL_PromedioPonderadoPorHoras (->$ar_PromedioPeriodo_puntos_P2;->$ai_HorasSemanales)
							
						: ($l_modoPromedioOficial=Sin ponderaciones)
							$r_mediaReal:=Round:C94(AT_Mean (->$ar_PromedioPeriodo_real_P2;$l_opcionCalculoPromedio);11)
							$r_mediaNota:=Round:C94(AT_Mean (->$ar_PromedioPeriodo_nota_P2;$l_opcionCalculoPromedio);11)
							$r_mediaPuntos:=Round:C94(AT_Mean (->$ar_PromedioPeriodo_puntos_P2;$l_opcionCalculoPromedio);11)
					End case 
					
					$r_media:=$r_mediaReal
					If (iPrintMode=Simbolos)
						$r_media:=$r_mediaReal
						Case of 
							: ((viEVS_EquMode=Notas) & (vi_ConvertSymbolicAverage=1))
								$r_mediaNota:=EV2_Real_a_Nota ($r_media;$l_truncarPromedio;iGradesDecPP)
								$r_mediaReal:=EV2_Nota_a_Real ($r_mediaNota)
								$t_mediaSimbolos:=EV2_Real_a_Simbolo ($r_mediaReal)
								$r_mediaPuntos:=EV2_Real_a_Puntos ($r_mediaReal;$l_truncarPromedio;iPointsDecPP)
							: ((viEVS_EquMode=Puntos) & (vi_ConvertSymbolicAverage=1))
								$r_mediaPuntos:=EV2_Real_a_Puntos ($r_media;$l_truncarPromedio;iPointsDecPP)
								$r_mediaReal:=EV2_Puntos_a_Real ($r_mediaPuntos)
								$t_mediaSimbolos:=EV2_Real_a_Simbolo ($r_mediaReal)
								$r_mediaNota:=EV2_Real_a_Nota ($r_mediaReal;$l_truncarPromedio;iGradesDecPP)
							Else 
								$t_mediaSimbolos:=NTA_PercentValue2StringValue ($r_mediaReal;Simbolos;$l_IdEstiloEvaluacionInterno)
						End case 
					Else 
						Case of 
							: (iPrintMode=Notas)
								$r_mediaNota:=EV2_Real_a_Nota ($r_media;$l_truncarPromedio;iGradesDecPP)
								$r_mediaReal:=EV2_Nota_a_Real ($r_mediaNota)
								$t_mediaSimbolos:=EV2_Real_a_Simbolo ($r_mediaReal)
								$r_mediaPuntos:=EV2_Real_a_Puntos ($r_mediaReal;$l_truncarPromedio;iPointsDecPP)
							: (iPrintMode=Puntos)
								$r_mediaPuntos:=EV2_Real_a_Puntos ($r_media;$l_truncarPromedio;iPointsDecPP)
								$r_mediaReal:=EV2_Puntos_a_Real ($r_mediaPuntos)
								$t_mediaSimbolos:=EV2_Real_a_Simbolo ($r_mediaReal)
								$r_mediaNota:=EV2_Real_a_Nota ($r_mediaReal;$l_truncarPromedio;iGradesDecPP)
						End case 
					End if 
					$t_mediaLiteralOficial:=NTA_PercentValue2StringValue ($r_mediaReal;$l_modoImpresionOficial;$l_IdEstiloEvaluacionOficial)
					[Alumnos_SintesisAnual:210]P02_PromedioOficial_Real:242:=$r_mediaReal
					[Alumnos_SintesisAnual:210]P02_PromedioOficial_Nota:243:=$r_mediaNota
					[Alumnos_SintesisAnual:210]P02_PromedioOficial_Puntos:244:=$r_mediaPuntos
					[Alumnos_SintesisAnual:210]P02_PromedioOficial_Simbolo:245:=$t_mediaSimbolos
					[Alumnos_SintesisAnual:210]P02_PromedioOficial_Literal:246:=$t_mediaLiteralOficial
				End if 
				
				  //periodo 3
				$ar_PromedioPeriodo_real_P3{0}:=-10
				$b_hayEvaluaciones:=(AT_SearchArray (->$ar_PromedioPeriodo_real_P3;">")>0)
				If ($b_hayEvaluaciones)
					
					Case of 
						: ($l_modoPromedioOficial=Ponderado por factor)
							$r_mediaReal:=AL_PromedioPonderadoPorFactor (->$ar_PromedioPeriodo_real_P3;->$ar_FactorOficial)
							$r_mediaNota:=AL_PromedioPonderadoPorFactor (->$ar_PromedioPeriodo_nota_P3;->$ar_FactorOficial)
							$r_mediaPuntos:=AL_PromedioPonderadoPorFactor (->$ar_PromedioPeriodo_puntos_P3;->$ar_FactorOficial)
							
						: ($l_modoPromedioOficial=Ponderado por Int Horaria)
							$r_mediaReal:=AL_PromedioPonderadoPorHoras (->$ar_PromedioPeriodo_real_P3;->$ai_HorasSemanales)
							$r_mediaNota:=AL_PromedioPonderadoPorHoras (->$ar_PromedioPeriodo_nota_P3;->$ai_HorasSemanales)
							$r_mediaPuntos:=AL_PromedioPonderadoPorHoras (->$ar_PromedioPeriodo_puntos_P3;->$ai_HorasSemanales)
							
						: ($l_modoPromedioOficial=Sin ponderaciones)
							$r_mediaReal:=Round:C94(AT_Mean (->$ar_PromedioPeriodo_real_P3;$l_opcionCalculoPromedio);11)
							$r_mediaNota:=Round:C94(AT_Mean (->$ar_PromedioPeriodo_nota_P3;$l_opcionCalculoPromedio);11)
							$r_mediaPuntos:=Round:C94(AT_Mean (->$ar_PromedioPeriodo_puntos_P3;$l_opcionCalculoPromedio);11)
					End case 
					
					$r_media:=$r_mediaReal
					If (iPrintMode=Simbolos)
						$r_media:=$r_mediaReal
						Case of 
							: ((viEVS_EquMode=Notas) & (vi_ConvertSymbolicAverage=1))
								$r_mediaNota:=EV2_Real_a_Nota ($r_media;$l_truncarPromedio;iGradesDecPP)
								$r_mediaReal:=EV2_Nota_a_Real ($r_mediaNota)
								$t_mediaSimbolos:=EV2_Real_a_Simbolo ($r_mediaReal)
								$r_mediaPuntos:=EV2_Real_a_Puntos ($r_mediaReal;$l_truncarPromedio;iPointsDecPP)
							: ((viEVS_EquMode=Puntos) & (vi_ConvertSymbolicAverage=1))
								$r_mediaPuntos:=EV2_Real_a_Puntos ($r_media;$l_truncarPromedio;iPointsDecPP)
								$r_mediaReal:=EV2_Puntos_a_Real ($r_mediaPuntos)
								$t_mediaSimbolos:=EV2_Real_a_Simbolo ($r_mediaReal)
								$r_mediaNota:=EV2_Real_a_Nota ($r_mediaReal;$l_truncarPromedio;iGradesDecPP)
							Else 
								$t_mediaSimbolos:=NTA_PercentValue2StringValue ($r_mediaReal;Simbolos;$l_IdEstiloEvaluacionInterno)
						End case 
					Else 
						Case of 
							: (iPrintMode=Notas)
								$r_mediaNota:=EV2_Real_a_Nota ($r_media;$l_truncarPromedio;iGradesDecPP)
								$r_mediaReal:=EV2_Nota_a_Real ($r_mediaNota)
								$t_mediaSimbolos:=EV2_Real_a_Simbolo ($r_mediaReal)
								$r_mediaPuntos:=EV2_Real_a_Puntos ($r_mediaReal;$l_truncarPromedio;iPointsDecPP)
							: (iPrintMode=Puntos)
								$r_mediaPuntos:=EV2_Real_a_Puntos ($r_media;$l_truncarPromedio;iPointsDecPP)
								$r_mediaReal:=EV2_Puntos_a_Real ($r_mediaPuntos)
								$t_mediaSimbolos:=EV2_Real_a_Simbolo ($r_mediaReal)
								$r_mediaNota:=EV2_Real_a_Nota ($r_mediaReal;$l_truncarPromedio;iGradesDecPP)
						End case 
					End if 
					$t_mediaLiteralOficial:=NTA_PercentValue2StringValue ($r_mediaReal;$l_modoImpresionOficial;$l_IdEstiloEvaluacionOficial)
					[Alumnos_SintesisAnual:210]P03_PromedioOficial_Real:247:=$r_mediaReal
					[Alumnos_SintesisAnual:210]P03_PromedioOficial_Nota:248:=$r_mediaNota
					[Alumnos_SintesisAnual:210]P03_PromedioOficial_Puntos:249:=$r_mediaPuntos
					[Alumnos_SintesisAnual:210]P03_PromedioOficial_Simbolo:250:=$t_mediaSimbolos
					[Alumnos_SintesisAnual:210]P03_PromedioOficial_Literal:251:=$t_mediaLiteralOficial
				End if 
				
				  //periodo 4
				$ar_PromedioPeriodo_real_P4{0}:=-10
				$b_hayEvaluaciones:=(AT_SearchArray (->$ar_PromedioPeriodo_real_P4;">")>0)
				If ($b_hayEvaluaciones)
					
					Case of 
						: ($l_modoPromedioOficial=Ponderado por factor)
							$r_mediaReal:=AL_PromedioPonderadoPorFactor (->$ar_PromedioPeriodo_real_P4;->$ar_FactorOficial)
							$r_mediaNota:=AL_PromedioPonderadoPorFactor (->$ar_PromedioPeriodo_nota_P4;->$ar_FactorOficial)
							$r_mediaPuntos:=AL_PromedioPonderadoPorFactor (->$ar_PromedioPeriodo_puntos_P4;->$ar_FactorOficial)
							
						: ($l_modoPromedioOficial=Ponderado por Int Horaria)
							$r_mediaReal:=AL_PromedioPonderadoPorHoras (->$ar_PromedioPeriodo_real_P4;->$ai_HorasSemanales)
							$r_mediaNota:=AL_PromedioPonderadoPorHoras (->$ar_PromedioPeriodo_nota_P4;->$ai_HorasSemanales)
							$r_mediaPuntos:=AL_PromedioPonderadoPorHoras (->$ar_PromedioPeriodo_puntos_P4;->$ai_HorasSemanales)
							
						: ($l_modoPromedioOficial=Sin ponderaciones)
							$r_mediaReal:=Round:C94(AT_Mean (->$ar_PromedioPeriodo_real_P4;$l_opcionCalculoPromedio);11)
							$r_mediaNota:=Round:C94(AT_Mean (->$ar_PromedioPeriodo_nota_P4;$l_opcionCalculoPromedio);11)
							$r_mediaPuntos:=Round:C94(AT_Mean (->$ar_PromedioPeriodo_puntos_P4;$l_opcionCalculoPromedio);11)
					End case 
					
					If (iPrintMode=Simbolos)
						$r_media:=$r_mediaReal
						Case of 
							: ((viEVS_EquMode=Notas) & (vi_ConvertSymbolicAverage=1))
								$r_mediaNota:=EV2_Real_a_Nota ($r_media;$l_truncarPromedio;iGradesDecPP)
								$r_mediaReal:=EV2_Nota_a_Real ($r_mediaNota)
								$t_mediaSimbolos:=EV2_Real_a_Simbolo ($r_mediaReal)
								$r_mediaPuntos:=EV2_Real_a_Puntos ($r_mediaReal;$l_truncarPromedio;iPointsDecPP)
							: ((viEVS_EquMode=Puntos) & (vi_ConvertSymbolicAverage=1))
								$r_mediaPuntos:=EV2_Real_a_Puntos ($r_media;$l_truncarPromedio;iPointsDecPP)
								$r_mediaReal:=EV2_Puntos_a_Real ($r_mediaPuntos)
								$t_mediaSimbolos:=EV2_Real_a_Simbolo ($r_mediaReal)
								$r_mediaNota:=EV2_Real_a_Nota ($r_mediaReal;$l_truncarPromedio;iGradesDecPP)
							Else 
								$t_mediaSimbolos:=NTA_PercentValue2StringValue ($r_mediaReal;Simbolos;$l_IdEstiloEvaluacionOficial)
						End case 
					Else 
						$t_mediaSimbolos:=NTA_PercentValue2StringValue ($r_mediaReal;Simbolos;$l_IdEstiloEvaluacionOficial)
					End if 
					$t_mediaLiteralOficial:=NTA_PercentValue2StringValue ($r_mediaReal;$l_modoImpresionOficial;$l_IdEstiloEvaluacionOficial)
					[Alumnos_SintesisAnual:210]P04_PromedioOficial_Real:252:=$r_mediaReal
					[Alumnos_SintesisAnual:210]P04_PromedioOficial_Nota:253:=$r_mediaNota
					[Alumnos_SintesisAnual:210]P04_PromedioOficial_Puntos:254:=$r_mediaPuntos
					[Alumnos_SintesisAnual:210]P04_PromedioOficial_Simbolo:255:=$t_mediaSimbolos
					[Alumnos_SintesisAnual:210]P04_PromedioOficial_Literal:256:=$t_mediaLiteralOficial
				End if 
				
				  //periodo 5
				$ar_PromedioPeriodo_real_P5{0}:=-10
				$b_hayEvaluaciones:=(AT_SearchArray (->$ar_PromedioPeriodo_real_P5;">")>0)
				If ($b_hayEvaluaciones)
					
					Case of 
						: ($l_modoPromedioOficial=Ponderado por factor)
							$r_mediaReal:=AL_PromedioPonderadoPorFactor (->$ar_PromedioPeriodo_real_P5;->$ar_FactorOficial)
							$r_mediaNota:=AL_PromedioPonderadoPorFactor (->$ar_PromedioPeriodo_nota_P5;->$ar_FactorOficial)
							$r_mediaPuntos:=AL_PromedioPonderadoPorFactor (->$ar_PromedioPeriodo_puntos_P5;->$ar_FactorOficial)
							
						: ($l_modoPromedioOficial=Ponderado por Int Horaria)
							$r_mediaReal:=AL_PromedioPonderadoPorHoras (->$ar_PromedioPeriodo_real_P5;->$ai_HorasSemanales)
							$r_mediaNota:=AL_PromedioPonderadoPorHoras (->$ar_PromedioPeriodo_nota_P5;->$ai_HorasSemanales)
							$r_mediaPuntos:=AL_PromedioPonderadoPorHoras (->$ar_PromedioPeriodo_puntos_P5;->$ai_HorasSemanales)
							
						: ($l_modoPromedioOficial=Sin ponderaciones)
							$r_mediaReal:=Round:C94(AT_Mean (->$ar_PromedioPeriodo_real_P5;$l_opcionCalculoPromedio);11)
							$r_mediaNota:=Round:C94(AT_Mean (->$ar_PromedioPeriodo_nota_P5;$l_opcionCalculoPromedio);11)
							$r_mediaPuntos:=Round:C94(AT_Mean (->$ar_PromedioPeriodo_puntos_P5;$l_opcionCalculoPromedio);11)
					End case 
					
					$r_media:=$r_mediaReal
					If (iPrintMode=Simbolos)
						$r_media:=$r_mediaReal
						Case of 
							: ((viEVS_EquMode=Notas) & (vi_ConvertSymbolicAverage=1))
								$r_mediaNota:=EV2_Real_a_Nota ($r_media;$l_truncarPromedio;iGradesDecPP)
								$r_mediaReal:=EV2_Nota_a_Real ($r_mediaNota)
								$t_mediaSimbolos:=EV2_Real_a_Simbolo ($r_mediaReal)
								$r_mediaPuntos:=EV2_Real_a_Puntos ($r_mediaReal;$l_truncarPromedio;iPointsDecPP)
							: ((viEVS_EquMode=Puntos) & (vi_ConvertSymbolicAverage=1))
								$r_mediaPuntos:=EV2_Real_a_Puntos ($r_media;$l_truncarPromedio;iPointsDecPP)
								$r_mediaReal:=EV2_Puntos_a_Real ($r_mediaPuntos)
								$t_mediaSimbolos:=EV2_Real_a_Simbolo ($r_mediaReal)
								$r_mediaNota:=EV2_Real_a_Nota ($r_mediaReal;$l_truncarPromedio;iGradesDecPP)
							Else 
								$t_mediaSimbolos:=NTA_PercentValue2StringValue ($r_mediaReal;Simbolos;$l_IdEstiloEvaluacionInterno)
						End case 
					Else 
						Case of 
							: (iPrintMode=Notas)
								$r_mediaNota:=EV2_Real_a_Nota ($r_media;$l_truncarPromedio;iGradesDecPP)
								$r_mediaReal:=EV2_Nota_a_Real ($r_mediaNota)
								$t_mediaSimbolos:=EV2_Real_a_Simbolo ($r_mediaReal)
								$r_mediaPuntos:=EV2_Real_a_Puntos ($r_mediaReal;$l_truncarPromedio;iPointsDecPP)
							: (iPrintMode=Puntos)
								$r_mediaPuntos:=EV2_Real_a_Puntos ($r_media;$l_truncarPromedio;iPointsDecPP)
								$r_mediaReal:=EV2_Puntos_a_Real ($r_mediaPuntos)
								$t_mediaSimbolos:=EV2_Real_a_Simbolo ($r_mediaReal)
								$r_mediaNota:=EV2_Real_a_Nota ($r_mediaReal;$l_truncarPromedio;iGradesDecPP)
						End case 
					End if 
					$t_mediaLiteralOficial:=NTA_PercentValue2StringValue ($r_mediaReal;$l_modoImpresionOficial;$l_IdEstiloEvaluacionOficial)
					[Alumnos_SintesisAnual:210]P05_PromedioOficial_Real:257:=$r_mediaReal
					[Alumnos_SintesisAnual:210]P05_PromedioOficial_Nota:258:=$r_mediaNota
					[Alumnos_SintesisAnual:210]P05_PromedioOficial_Puntos:259:=$r_mediaPuntos
					[Alumnos_SintesisAnual:210]P05_PromedioOficial_Simbolo:260:=$t_mediaSimbolos
					[Alumnos_SintesisAnual:210]P05_PromedioOficial_Literal:261:=$t_mediaLiteralOficial
				End if 
				
				  //promedio anual OFICIAL
				$ar_PromedioAnual_real{0}:=-10
				$b_hayEvaluaciones:=(AT_SearchArray (->$ar_PromedioAnual_real;">")>0)
				If ($b_hayEvaluaciones)
					
					Case of 
						: ($l_modoPromedioOficial=Ponderado por factor)
							$r_mediaReal:=AL_PromedioPonderadoPorFactor (->$ar_PromedioAnual_real;->$ar_FactorOficial)
							$r_mediaNota:=AL_PromedioPonderadoPorFactor (->$ar_PromedioAnual_nota;->$ar_FactorOficial)
							$r_mediaPuntos:=AL_PromedioPonderadoPorFactor (->$ar_PromedioAnual_puntos;->$ar_FactorOficial)
							
						: ($l_modoPromedioOficial=Ponderado por Int Horaria)
							$r_mediaReal:=AL_PromedioPonderadoPorHoras (->$ar_PromedioAnual_real;->$ai_HorasSemanales)
							$r_mediaNota:=AL_PromedioPonderadoPorHoras (->$ar_PromedioAnual_nota;->$ai_HorasSemanales)
							$r_mediaPuntos:=AL_PromedioPonderadoPorHoras (->$ar_PromedioAnual_puntos;->$ai_HorasSemanales)
							
						: ($l_modoPromedioOficial=Sin ponderaciones)
							$r_mediaReal:=Round:C94(AT_Mean (->$ar_PromedioAnual_real;$l_opcionCalculoPromedio);11)
							$r_mediaNota:=Round:C94(AT_Mean (->$ar_PromedioAnual_nota;$l_opcionCalculoPromedio);11)
							$r_mediaPuntos:=Round:C94(AT_Mean (->$ar_PromedioAnual_puntos;$l_opcionCalculoPromedio);11)
					End case 
					
					$r_media:=$r_mediaReal
					If (iPrintMode=Simbolos)
						$r_media:=$r_mediaReal
						Case of 
							: ((viEVS_EquMode=Notas) & (vi_ConvertSymbolicAverage=1))
								$r_mediaNota:=EV2_Real_a_Nota ($r_media;$l_truncarPromedio;iGradesDecPF)
								$r_mediaReal:=EV2_Nota_a_Real ($r_mediaNota)
								$t_mediaSimbolos:=EV2_Real_a_Simbolo ($r_mediaReal)
								$r_mediaPuntos:=EV2_Real_a_Puntos ($r_mediaReal;$l_truncarPromedio;iPointsDecPF)
							: ((viEVS_EquMode=Puntos) & (vi_ConvertSymbolicAverage=1))
								$r_mediaPuntos:=EV2_Real_a_Puntos ($r_media;$l_truncarPromedio;iPointsDecPF)
								$r_mediaReal:=EV2_Puntos_a_Real ($r_mediaPuntos)
								$t_mediaSimbolos:=EV2_Real_a_Simbolo ($r_mediaReal)
								$r_mediaNota:=EV2_Real_a_Nota ($r_mediaReal;$l_truncarPromedio;iGradesDecPF)
							Else 
								$t_mediaSimbolos:=NTA_PercentValue2StringValue ($r_mediaReal;Simbolos;$l_IdEstiloEvaluacionInterno)
						End case 
					Else 
						Case of 
							: (iPrintMode=Notas)
								$r_mediaNota:=EV2_Real_a_Nota ($r_media;$l_truncarPromedio;iGradesDecPF)
								$r_mediaReal:=EV2_Nota_a_Real ($r_mediaNota)
								$t_mediaSimbolos:=EV2_Real_a_Simbolo ($r_mediaReal)
								$r_mediaPuntos:=EV2_Real_a_Puntos ($r_mediaReal)
							: (iPrintMode=Puntos)
								$r_mediaPuntos:=EV2_Real_a_Puntos ($r_media;$l_truncarPromedio)
								$r_mediaReal:=EV2_Puntos_a_Real ($r_mediaPuntos)
								$t_mediaSimbolos:=EV2_Real_a_Simbolo ($r_mediaReal)
								$r_mediaNota:=EV2_Real_a_Nota ($r_mediaReal;$l_truncarPromedio;iGradesDecPF)
						End case 
					End if 
					$t_mediaLiteralOficial:=NTA_PercentValue2StringValue ($r_mediaReal;$l_modoImpresionOficial;$l_IdEstiloEvaluacionOficial)
					[Alumnos_SintesisAnual:210]PromedioAnualOficial_Real:15:=$r_mediaReal
					[Alumnos_SintesisAnual:210]PromedioAnualOficial_Nota:16:=$r_mediaNota
					[Alumnos_SintesisAnual:210]PromedioAnualOficial_Puntos:17:=$r_mediaPuntos
					[Alumnos_SintesisAnual:210]PromedioAnualOficial_Simbolo:18:=$t_mediaSimbolos
					[Alumnos_SintesisAnual:210]PromedioAnualOficial_Literal:19:=$t_mediaLiteralOficial
				End if 
				
				  //promedio final OFICIAL
				$ar_PromedioOficial_real{0}:=-10
				$b_hayEvaluaciones:=(AT_SearchArray (->$ar_PromedioOficial_real;">")>0)
				If ($b_hayEvaluaciones)
					$r_mediaReal:=Round:C94(AT_Mean (->$ar_PromedioOficial_real;$l_opcionCalculoPromedio);11)
					$r_mediaNota:=Round:C94(AT_Mean (->$ar_PromedioOficial_nota;$l_opcionCalculoPromedio);11)
					$r_mediaPuntos:=Round:C94(AT_Mean (->$ar_PromedioOficial_puntos;$l_opcionCalculoPromedio);11)
					
					Case of 
						: ($l_modoPromedioOficial=Ponderado por factor)
							$r_mediaReal:=AL_PromedioPonderadoPorFactor (->$ar_PromedioOficial_real;->$ar_FactorOficial)
							$r_mediaNota:=AL_PromedioPonderadoPorFactor (->$ar_PromedioOficial_nota;->$ar_FactorOficial)
							$r_mediaPuntos:=AL_PromedioPonderadoPorFactor (->$ar_PromedioOficial_nota;->$ar_FactorOficial)
							
						: ($l_modoPromedioOficial=Ponderado por Int Horaria)
							$r_mediaReal:=AL_PromedioPonderadoPorHoras (->$ar_PromedioOficial_real;->$ai_HorasSemanales)
							$r_mediaNota:=AL_PromedioPonderadoPorHoras (->$ar_PromedioOficial_nota;->$ai_HorasSemanales)
							$r_mediaPuntos:=AL_PromedioPonderadoPorHoras (->$ar_PromedioOficial_puntos;->$ai_HorasSemanales)
							
						: ($l_modoPromedioOficial=Sin ponderaciones)
							$r_mediaReal:=Round:C94(AT_Mean (->$ar_PromedioOficial_real;$l_opcionCalculoPromedio);11)
							$r_mediaNota:=Round:C94(AT_Mean (->$ar_PromedioOficial_nota;$l_opcionCalculoPromedio);11)
							$r_mediaPuntos:=Round:C94(AT_Mean (->$ar_PromedioOficial_puntos;$l_opcionCalculoPromedio);11)
					End case 
					
					If ($r_mediaReal>=vrNTA_MinimoEscalaReferencia)
						Case of 
							: (iEvaluationMode=Notas)
								$t_mediaLiteral:=String:C10($r_mediaNota)
							: (iEvaluationMode=Puntos)
								$t_mediaLiteral:=String:C10($r_mediaPuntos)
							: ((iEvaluationMode=Porcentaje) | (iEvaluationMode=Simbolos))
								$t_mediaLiteral:=String:C10($r_mediaReal)
						End case 
					End if 
					[Alumnos_SintesisAnual:210]PromedioOf_NoAprox_Real:268:=$r_mediaReal
					[Alumnos_SintesisAnual:210]PromedioOf_NoAprox_Nota:269:=$r_mediaNota
					[Alumnos_SintesisAnual:210]PromedioOf_NoAprox_Puntos:270:=$r_mediaPuntos
					[Alumnos_SintesisAnual:210]PromedioOf_NoAprox_Literal:271:=$t_mediaLiteral
					
					$r_media:=$r_mediaReal
					If (iPrintMode=Simbolos)
						$r_media:=$r_mediaReal
						Case of 
							: ((viEVS_EquMode=Notas) & (vi_ConvertSymbolicAverage=1))
								$r_mediaNota:=EV2_Real_a_Nota ($r_media;$l_truncarPromedio;iGradesDecNO)
								$r_mediaReal:=EV2_Nota_a_Real ($r_mediaNota)
								$t_mediaSimbolos:=EV2_Real_a_Simbolo ($r_mediaReal)
								$r_mediaPuntos:=EV2_Real_a_Puntos ($r_mediaReal;$l_truncarPromedio;iPointsDecNO)
							: ((viEVS_EquMode=Puntos) & (vi_ConvertSymbolicAverage=1))
								$r_mediaPuntos:=EV2_Real_a_Puntos ($r_media;$l_truncarPromedio)
								$r_mediaReal:=EV2_Puntos_a_Real ($r_mediaPuntos)
								$t_mediaSimbolos:=EV2_Real_a_Simbolo ($r_mediaReal)
								$r_mediaNota:=EV2_Real_a_Nota ($r_mediaReal;$l_truncarPromedio;iGradesDecNO)
							Else 
								$t_mediaSimbolos:=NTA_PercentValue2StringValue ($r_mediaReal;Simbolos;$l_IdEstiloEvaluacionInterno)
						End case 
					Else 
						Case of 
							: (iPrintMode=Notas)
								$r_mediaNota:=EV2_Real_a_Nota ($r_media;$l_truncarPromedio;iGradesDecNO)
								$r_mediaReal:=EV2_Nota_a_Real ($r_mediaNota)
								$t_mediaSimbolos:=EV2_Real_a_Simbolo ($r_mediaReal)
								$r_mediaPuntos:=EV2_Real_a_Puntos ($r_mediaReal;$l_truncarPromedio;iPointsDecNO)
							: (iPrintMode=Puntos)
								$r_mediaPuntos:=EV2_Real_a_Puntos ($r_media;$l_truncarPromedio;iPointsDecNO)
								$r_mediaReal:=EV2_Puntos_a_Real ($r_mediaPuntos)
								$t_mediaSimbolos:=EV2_Real_a_Simbolo ($r_mediaReal)
								$r_mediaNota:=EV2_Real_a_Nota ($r_mediaReal;$l_truncarPromedio;iGradesDecNO)
						End case 
					End if 
					$t_mediaLiteralOficial:=NTA_PercentValue2StringValue ($r_mediaReal;$l_modoImpresionOficial;$l_IdEstiloEvaluacionOficial)
					[Alumnos_SintesisAnual:210]PromedioFinalOficial_Real:25:=$r_mediaReal
					[Alumnos_SintesisAnual:210]PromedioFinalOficial_Nota:26:=$r_mediaNota
					[Alumnos_SintesisAnual:210]PromedioFinalOficial_Puntos:27:=$r_mediaPuntos
					[Alumnos_SintesisAnual:210]PromedioFinalOficial_Simbolo:28:=$t_mediaSimbolos
					[Alumnos_SintesisAnual:210]PromedioFinalOficial_Literal:29:=$t_mediaLiteralOficial
				End if 
				SAVE RECORD:C53([Alumnos_SintesisAnual:210])
				
			End if 
			
			CLEAR SET:C117("Calificaciones")
		End if 
		SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		
		KRL_ReloadAsReadOnly (->[Alumnos_SintesisAnual:210])
		EV2_InitArrays 
	End if 
End if 

