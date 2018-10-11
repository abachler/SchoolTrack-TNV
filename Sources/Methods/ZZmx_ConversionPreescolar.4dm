//%attributes = {}
  //ZZmx_ConversionPreescolar

  //◊noBatchProcessor:=True
  //
  //$result:=PREF_fGet (0;"ConvSubasignaturasPreescolar";"No")
  //If ($result="No")
  //QUERY([Asignaturas];[Asignaturas]Numero_del_Nivel<0)
  //CREATE SET([Asignaturas];"Universo")  `se utiliza la selección inicial
  //PERIODOS_Init 
  //EVS_LoadStyles 
  //
  //ALL RECORDS([xxSTR_Subasignaturas])
  //KRL_RelateSelection (->[Asignaturas]Numero;->[xxSTR_Subasignaturas]ID_Mother;"")
  //CREATE SET([Asignaturas];"conSubasignaturas")
  //INTERSECTION("Universo";"conSubasignaturas";"Universo")
  //USE SET("Universo")
  //SET_ClearSets ("Universo";"conSubasignaturas")
  //KRL_RelateSelection (->[xxSTR_Subasignaturas]ID_Mother;->[Asignaturas]Numero;"")
  //CREATE SET([xxSTR_Subasignaturas];"SubAsignaturas_aEliminar")
  //
  //
  //  `CONVERSION DE SUBASIGNATURAS
  //ARRAY LONGINT($aRecNums;0)
  //LONGINT ARRAY FROM SELECTION([Asignaturas];$aRecNums;"")
  //CD_THERMOMETREXSEC (1;0;"Convirtiendo subasignaturas en asignaturas consolidables...")
  //For ($i;1;Size of array($aRecNums))
  //CD_THERMOMETREXSEC (0;$i/Size of array($aRecNums)*100)
  //READ WRITE([Asignaturas])
  //GOTO RECORD([Asignaturas];$aRecNums{$i})
  //$key:=String(◊gInstitucion)+"."+String(◊gYear)+"."+String([Asignaturas]Numero)+".@"
  //EVAL_LeeEvaluacionesFinales ($key)
  //
  //PERIODOS_LoadData ([Asignaturas]Numero_del_Nivel)
  //If (Not([Asignaturas]VariableConfig))
  //$fatObjectName:="Blob_ConfigNotas/"+String([Asignaturas]Numero)
  //AS_PropEval_Lectura ($fatObjectName)
  //COPY ARRAY(alAS_EvalPropSourceID;$aSourceID)
  //COPY ARRAY(atAS_EvalPropSourceName;$aSourceName)
  //COPY ARRAY(atAS_EvalPropPrintName;$aPrintName)
  //End if 
  //
  //For ($iperiodos;1;viSTR_Periodos_NumeroPeriodos)
  //If (aiSTR_Periodos_NumeroSubPeriodo{$iPeriodos}=0)
  //GOTO RECORD([Asignaturas];$aRecNums{$i})
  //If ([Asignaturas]VariableConfig)
  //$fatObjectName:="Blob_ConfigNotas/"+String([Asignaturas]Numero)+"/P"+String($iPeriodos)
  //AS_PropEval_Lectura ($fatObjectName)
  //COPY ARRAY(alAS_EvalPropSourceID;$aSourceID)
  //COPY ARRAY(atAS_EvalPropSourceName;$aSourceName)
  //COPY ARRAY(atAS_EvalPropPrintName;$aPrintName)
  //Else 
  //$fatObjectName:="Blob_ConfigNotas/"+String([Asignaturas]Numero)
  //End if 
  //  `AS_LoadPercentGrades ($iperiodos;->iViewMode;0;False)
  //For ($iColumnas;1;12)
  //GOTO RECORD([Asignaturas];$aRecNums{$i})
  //$sourceID:=$aSourceID{$iColumnas}
  //If ($sourceID<0)
  //ASsev_LeeDatosSubasignatura ([Asignaturas]Numero;$iPeriodos;$iColumnas;False)
  //ASsev_UpdateList (Record number([xxSTR_Subasignaturas]))
  //ASsev_GuardaNomina (Record number([xxSTR_Subasignaturas]))
  //
  //$nombre:=$aSourceName{$iColumnas}
  //$nombreInterno:=$aPrintName{$iColumnas}
  //$idMadre:=[Asignaturas]Numero
  //$nombreMadre:=[Asignaturas]Asignatura
  //$curso:=[Asignaturas]Curso
  //$nivel:=[Asignaturas]Numero_del_Nivel
  //$nombreNivel:=[Asignaturas]Nivel
  //$idProfesor:=[Asignaturas]Profesor_Numero
  //$orden:=[Asignaturas]OrdenGeneral
  //$estiloEvaluacion:=[Asignaturas]Numero_de_EstiloEvaluacion
  //  `AS_LoadPercentGrades ($iperiodos;->iViewMode;0;False)
  //
  //ASsev_LeeDatosSubasignatura ([Asignaturas]Numero;$iPeriodos;$iColumnas;False)
  //$modoControles:=[xxSTR_Subasignaturas]ModoControles
  //$ponderacion:=[xxSTR_Subasignaturas]PonderacionControl
  //$valorSiControlInferior:=[xxSTR_Subasignaturas]ValorControlSiInferior
  //$valorSiControlSuperor:=[xxSTR_Subasignaturas]ValorControlSiSuperior
  //If ($modoControles=0)
  //For ($iControles;1;Size of array(aRealSubEvalControles))
  //aRealSubEvalControles{$iControles}:=-10
  //End for 
  //End if 
  //SORT ARRAY(aSubEvalID;aSubEvalOrden;aRealSubEval1;aRealSubEval2;aRealSubEval3;aRealSubEval4;aRealSubEval5;aRealSubEval6;aRealSubEval7;aRealSubEval8;aRealSubEval9;aRealSubEval10;aRealSubEval11;aRealSubEval12;aRealSubEvalPresentacion;aRealSubEvalControles;aRealSubEvalP1;>)
  //
  //QUERY([Asignaturas];[Asignaturas]Asignatura=$nombre;*)
  //QUERY([Asignaturas]; & ;[Asignaturas]Curso=$curso;*)
  //QUERY([Asignaturas]; & ;[Asignaturas]Numero_del_Nivel=$nivel;*)
  //QUERY([Asignaturas]; & ;[Asignaturas]Profesor_Numero=$idProfesor)
  //QUERY SELECTION([Asignaturas]; & [Asignaturas]Consolidantes'ID=$idMadre)
  //
  //
  //If (Records in selection([Asignaturas])=0)
  //GOTO RECORD([Asignaturas];$aRecNums{$i})
  //DUPLICATE RECORD([Asignaturas])
  //[Asignaturas]Numero:=SQ_SeqNumber (->[Asignaturas]Numero)
  //[Asignaturas]Asignatura:=$nombre
  //[Asignaturas]Curso:=$curso
  //[Asignaturas]Numero_del_Nivel:=$nivel
  //[Asignaturas]Profesor_Numero:=$idProfesor
  //[Asignaturas]Asignatura_No_Oficial:=True
  //[Asignaturas]Denominación_interna:=$nombre
  //[Asignaturas]IncideEnPromedioInterno:=False
  //[Asignaturas]Incide_en_promedio:=False
  //[Asignaturas]En_InformesInternos:=True
  //[Asignaturas]Incluida_en_Actas:=False
  //[Asignaturas]Incide_en_Asistencia:=False
  //[Asignaturas]Resultado_no_calculado:=True
  //[Asignaturas]Abreviación:=""
  //[Asignaturas]Codigo_interno:=""
  //[Asignaturas]CHILE_CodigoMineduc:=""
  //[Asignaturas]Consolida_en:=$nombreMadre
  //[Asignaturas]AsgConsol_ID:=$idMadre
  //[Asignaturas]OcultaEnExplorador:=True
  //[Asignaturas]OrdenGeneral:=$orden+"."+String($iColumnas;"00")
  //[Asignaturas]ModoControles:=$modoControles
  //[Asignaturas]Peso_relativo_controles:=$ponderacion
  //[Asignaturas]ValorControlesSiInferior:=$valorSiControlInferior
  //[Asignaturas]ValorControlesSiSuperior:=$valorSiControlSuperor
  //[Asignaturas]Es_Consolidante:=False
  //[Asignaturas]Numero_de_alumnos:=0
  //[Asignaturas]LastNumber:=0
  //SAVE RECORD([Asignaturas])
  //End if 
  //$idAsignatura:=[Asignaturas]Numero
  //EVS_ReadStyleData ([Asignaturas]Numero_de_EstiloEvaluacion)
  //
  //
  //$refPeriodo:=String(aiSTR_Periodos_Numero{$iPeriodos})
  //QUERY SUBRECORDS([Asignaturas]Consolidantes;([Asignaturas]Consolidantes'ID=$idMadre) & ([Asignaturas]Consolidantes'Periodo=$refPeriodo))
  //If (Records in subselection([Asignaturas]Consolidantes)=0)
  //CREATE SUBRECORD([Asignaturas]Consolidantes)
  //[Asignaturas]Consolidantes'ID:=$idMadre
  //[Asignaturas]Consolidantes'Periodo:=$refPeriodo
  //[Asignaturas]Consolidantes'Name:=$nombreMadre
  //SAVE RECORD([Asignaturas])
  //End if 
  //
  //alAS_EvalPropSourceID{$iColumnas}:=[Asignaturas]Numero
  //atAS_EvalPropSourceName{$iColumnas}:=[Asignaturas]Asignatura
  //abAS_EvalPropPrintDetail{$iColumnas}:=False
  //
  //  `QUERY([Alumnos_EvaluacionFinal];[Alumnos_EvaluacionFinal]ID_Asignatura=[Asignaturas]Numero)
  //  `ORDER BY([Alumnos_EvaluacionFinal];[Alumnos_EvaluacionFinal]ID_Alumno;>)
  //For ($iSubEvals;1;Size of array(aSubEvalID))
  //$el:=Find in array(aNtaIdAlumno;aSubEvalID{$iSubEvals})
  //If ($el>0)
  //READ WRITE([zzAlumnos_EvaluacionFinal])
  //$keyFinal:=String(◊gInstitucion)+"."+String(◊gYear)+"."+String($idAsignatura)+"."+String(aSubEvalID{$iSubEvals})
  //$recNumFinal:=Find in field([zzAlumnos_EvaluacionFinal]LlavePrincipal;$keyFinal)
  //If ($recNumFinal<0)
  //CREATE RECORD([zzAlumnos_EvaluacionFinal])
  //[zzAlumnos_EvaluacionFinal]ID_Alumno:=aNtaIdAlumno{$el}
  //RELATE ONE([zzAlumnos_EvaluacionFinal]ID_Alumno)
  //[zzAlumnos_EvaluacionFinal]ID_Asignatura:=$idAsignatura
  //[zzAlumnos_EvaluacionFinal]ID_institucion:=◊gInstitucion
  //[zzAlumnos_EvaluacionFinal]Agno:=◊gYear
  //[zzAlumnos_EvaluacionFinal]NoDeLista:=aNtaOrden{$el}
  //[zzAlumnos_EvaluacionFinal]NombreAsignatura:=[Asignaturas]Asignatura
  //[zzAlumnos_EvaluacionFinal]Curso:=[Alumnos]Curso
  //SAVE RECORD([zzAlumnos_EvaluacionFinal])
  //End if 
  //
  //READ WRITE([zzAlumnos_EvaluacionesPeriodica])
  //$keyPeriodicas:=String(◊gInstitucion)+"."+String(◊gYear)+"."+String($iPeriodos)+":"+String(0)+"."+String($idAsignatura)+"."+String(aSubEvalID{$iSubEvals})
  //$reNumPeriodicas:=Find in field([zzAlumnos_EvaluacionesPeriodica]LLavePrincipal;$keyPeriodicas)
  //If ($reNumPeriodicas<0)
  //CREATE RECORD([zzAlumnos_EvaluacionesPeriodica])
  //[zzAlumnos_EvaluacionesPeriodica]ID_Alumno:=aNtaIdAlumno{$el}
  //[zzAlumnos_EvaluacionesPeriodica]ID_Asignatura:=$idAsignatura
  //[zzAlumnos_EvaluacionesPeriodica]ID_Institucion:=◊gInstitucion
  //[zzAlumnos_EvaluacionesPeriodica]Agno:=◊gYear
  //[zzAlumnos_EvaluacionesPeriodica]Periodo:=$iperiodos
  //SAVE RECORD([zzAlumnos_EvaluacionesPeriodica])
  //End if 
  //
  //[zzAlumnos_EvaluacionesPeriodica]Eval_01_Real:=aRealSubEval1{$iSubEvals}
  //[zzAlumnos_EvaluacionesPeriodica]Eval_02_Real:=aRealSubEval2{$iSubEvals}
  //[zzAlumnos_EvaluacionesPeriodica]Eval_03_Real:=aRealSubEval3{$iSubEvals}
  //[zzAlumnos_EvaluacionesPeriodica]Eval_04_Real:=aRealSubEval4{$iSubEvals}
  //[zzAlumnos_EvaluacionesPeriodica]Eval_05_Real:=aRealSubEval5{$iSubEvals}
  //[zzAlumnos_EvaluacionesPeriodica]Eval_06_Real:=aRealSubEval6{$iSubEvals}
  //[zzAlumnos_EvaluacionesPeriodica]Eval_07_Real:=aRealSubEval7{$iSubEvals}
  //[zzAlumnos_EvaluacionesPeriodica]Eval_08_Real:=aRealSubEval8{$iSubEvals}
  //[zzAlumnos_EvaluacionesPeriodica]Eval_09_Real:=aRealSubEval9{$iSubEvals}
  //[zzAlumnos_EvaluacionesPeriodica]Eval_10_Real:=aRealSubEval10{$iSubEvals}
  //[zzAlumnos_EvaluacionesPeriodica]Eval_11_Real:=aRealSubEval11{$iSubEvals}
  //[zzAlumnos_EvaluacionesPeriodica]Eval_12_Real:=aRealSubEval12{$iSubEvals}
  //[zzAlumnos_EvaluacionesPeriodica]PresentExamen_Real:=aRealSubEvalPresentacion{$iSubEvals}
  //[zzAlumnos_EvaluacionesPeriodica]Examen_Real:=aRealSubEvalControles{$iSubEvals}
  //[zzAlumnos_EvaluacionesPeriodica]FinalPeriodo_Real:=aRealSubEvalP1{$iSubEvals}
  //
  //[zzAlumnos_EvaluacionesPeriodica]Eval_01_Nota:=EV2_Real_a_Nota (aRealSubEval1{$iSubEvals}))
  //[zzAlumnos_EvaluacionesPeriodica]Eval_02_Nota:=EV2_Real_a_Nota (aRealSubEval2{$iSubEvals}))
  //[zzAlumnos_EvaluacionesPeriodica]Eval_03_Nota:=EV2_Real_a_Nota (aRealSubEval3{$iSubEvals}))
  //[zzAlumnos_EvaluacionesPeriodica]Eval_04_Nota:=EV2_Real_a_Nota (aRealSubEval4{$iSubEvals}))
  //[zzAlumnos_EvaluacionesPeriodica]Eval_05_Nota:=EV2_Real_a_Nota (aRealSubEval5{$iSubEvals}))
  //[zzAlumnos_EvaluacionesPeriodica]Eval_06_Nota:=EV2_Real_a_Nota (aRealSubEval6{$iSubEvals}))
  //[zzAlumnos_EvaluacionesPeriodica]Eval_07_Nota:=EV2_Real_a_Nota (aRealSubEval7{$iSubEvals}))
  //[zzAlumnos_EvaluacionesPeriodica]Eval_08_Nota:=EV2_Real_a_Nota (aRealSubEval8{$iSubEvals}))
  //[zzAlumnos_EvaluacionesPeriodica]Eval_09_Nota:=EV2_Real_a_Nota (aRealSubEval9{$iSubEvals}))
  //[zzAlumnos_EvaluacionesPeriodica]Eval_10_Nota:=EV2_Real_a_Nota (aRealSubEval10{$iSubEvals}))
  //[zzAlumnos_EvaluacionesPeriodica]Eval_11_Nota:=EV2_Real_a_Nota (aRealSubEval11{$iSubEvals}))
  //[zzAlumnos_EvaluacionesPeriodica]Eval_12_Nota:=EV2_Real_a_Nota (aRealSubEval12{$iSubEvals}))
  //[zzAlumnos_EvaluacionesPeriodica]PresentExamen_Nota:=EV2_Real_a_Nota (aRealSubEvalPresentacion{$iSubEvals}))
  //[zzAlumnos_EvaluacionesPeriodica]Examen_Nota:=EV2_Real_a_Nota (aRealSubEvalControles{$iSubEvals}))
  //[zzAlumnos_EvaluacionesPeriodica]FinalPeriodo_Nota:=EV2_Real_a_Nota (aRealSubEvalP1{$iSubEvals}))
  //
  //[zzAlumnos_EvaluacionesPeriodica]Eval_01_Puntaje:=EV2_Real_a_Puntos (aRealSubEval1{$iSubEvals}))
  //[zzAlumnos_EvaluacionesPeriodica]Eval_02_Puntaje:=EV2_Real_a_Puntos (aRealSubEval2{$iSubEvals}))
  //[zzAlumnos_EvaluacionesPeriodica]Eval_03_Puntaje:=EV2_Real_a_Puntos (aRealSubEval3{$iSubEvals}))
  //[zzAlumnos_EvaluacionesPeriodica]Eval_04_Puntaje:=EV2_Real_a_Puntos (aRealSubEval4{$iSubEvals}))
  //[zzAlumnos_EvaluacionesPeriodica]Eval_05_Puntaje:=EV2_Real_a_Puntos (aRealSubEval5{$iSubEvals}))
  //[zzAlumnos_EvaluacionesPeriodica]Eval_06_Puntaje:=EV2_Real_a_Puntos (aRealSubEval6{$iSubEvals}))
  //[zzAlumnos_EvaluacionesPeriodica]Eval_07_Puntaje:=EV2_Real_a_Puntos (aRealSubEval7{$iSubEvals}))
  //[zzAlumnos_EvaluacionesPeriodica]Eval_08_Puntaje:=EV2_Real_a_Puntos (aRealSubEval8{$iSubEvals}))
  //[zzAlumnos_EvaluacionesPeriodica]Eval_09_Puntaje:=EV2_Real_a_Puntos (aRealSubEval9{$iSubEvals}))
  //[zzAlumnos_EvaluacionesPeriodica]Eval_10_Puntaje:=EV2_Real_a_Puntos (aRealSubEval10{$iSubEvals}))
  //[zzAlumnos_EvaluacionesPeriodica]Eval_11_Puntaje:=EV2_Real_a_Puntos (aRealSubEval11{$iSubEvals}))
  //[zzAlumnos_EvaluacionesPeriodica]Eval_12_Puntaje:=EV2_Real_a_Puntos (aRealSubEval12{$iSubEvals}))
  //[zzAlumnos_EvaluacionesPeriodica]PresentExamen_Puntaje:=EV2_Real_a_Puntos (aRealSubEvalPresentacion{$iSubEvals}))
  //[zzAlumnos_EvaluacionesPeriodica]Examen_Puntaje:=EV2_Real_a_Puntos (aRealSubEvalControles{$iSubEvals}))
  //[zzAlumnos_EvaluacionesPeriodica]FinalPeriodo_Puntaje:=EV2_Real_a_Puntos (aRealSubEvalP1{$iSubEvals}))
  //
  //[zzAlumnos_EvaluacionesPeriodica]Eval_01_LiteralInterno:=NTA_PercentValue2StringValue (aRealSubEval1{$iSubEvals})
  //[zzAlumnos_EvaluacionesPeriodica]Eval_02_LiteralInterno:=NTA_PercentValue2StringValue (aRealSubEval2{$iSubEvals})
  //[zzAlumnos_EvaluacionesPeriodica]Eval_03_LiteralInterno:=NTA_PercentValue2StringValue (aRealSubEval3{$iSubEvals})
  //[zzAlumnos_EvaluacionesPeriodica]Eval_04_LiteralInterno:=NTA_PercentValue2StringValue (aRealSubEval4{$iSubEvals})
  //[zzAlumnos_EvaluacionesPeriodica]Eval_05_LiteralInterno:=NTA_PercentValue2StringValue (aRealSubEval5{$iSubEvals})
  //[zzAlumnos_EvaluacionesPeriodica]Eval_06_LiteralInterno:=NTA_PercentValue2StringValue (aRealSubEval6{$iSubEvals})
  //[zzAlumnos_EvaluacionesPeriodica]Eval_07_LiteralInterno:=NTA_PercentValue2StringValue (aRealSubEval7{$iSubEvals})
  //[zzAlumnos_EvaluacionesPeriodica]Eval_08_LiteralInterno:=NTA_PercentValue2StringValue (aRealSubEval8{$iSubEvals})
  //[zzAlumnos_EvaluacionesPeriodica]Eval_09_LiteralInterno:=NTA_PercentValue2StringValue (aRealSubEval9{$iSubEvals})
  //[zzAlumnos_EvaluacionesPeriodica]Eval_10_LiteralInterno:=NTA_PercentValue2StringValue (aRealSubEval10{$iSubEvals})
  //[zzAlumnos_EvaluacionesPeriodica]Eval_11_LiteralInterno:=NTA_PercentValue2StringValue (aRealSubEval11{$iSubEvals})
  //[zzAlumnos_EvaluacionesPeriodica]Eval_12_LiteralInterno:=NTA_PercentValue2StringValue (aRealSubEval12{$iSubEvals})
  //[zzAlumnos_EvaluacionesPeriodica]PresentExamen_LiteralInterno:=NTA_PercentValue2StringValue (aRealSubEvalPresentacion{$iSubEvals})
  //[zzAlumnos_EvaluacionesPeriodica]Examen_LiteralInterno:=NTA_PercentValue2StringValue (aRealSubEvalControles{$iSubEvals})
  //[zzAlumnos_EvaluacionesPeriodica]FinalPeriodo_LiteralInterno:=NTA_PercentValue2StringValue (aRealSubEvalP1{$iSubEvals})
  //
  //[zzAlumnos_EvaluacionesPeriodica]Eval_01_Simbolo:=EV2_Real_a_Simbolo (aRealSubEval1{$iSubEvals})
  //[zzAlumnos_EvaluacionesPeriodica]Eval_02_Simbolo:=EV2_Real_a_Simbolo (aRealSubEval2{$iSubEvals})
  //[zzAlumnos_EvaluacionesPeriodica]Eval_03_Simbolo:=EV2_Real_a_Simbolo (aRealSubEval3{$iSubEvals})
  //[zzAlumnos_EvaluacionesPeriodica]Eval_04_Simbolo:=EV2_Real_a_Simbolo (aRealSubEval4{$iSubEvals})
  //[zzAlumnos_EvaluacionesPeriodica]Eval_05_Simbolo:=EV2_Real_a_Simbolo (aRealSubEval5{$iSubEvals})
  //[zzAlumnos_EvaluacionesPeriodica]Eval_06_Simbolo:=EV2_Real_a_Simbolo (aRealSubEval6{$iSubEvals})
  //[zzAlumnos_EvaluacionesPeriodica]Eval_07_Simbolo:=EV2_Real_a_Simbolo (aRealSubEval7{$iSubEvals})
  //[zzAlumnos_EvaluacionesPeriodica]Eval_08_Simbolo:=EV2_Real_a_Simbolo (aRealSubEval8{$iSubEvals})
  //[zzAlumnos_EvaluacionesPeriodica]Eval_09_Simbolo:=EV2_Real_a_Simbolo (aRealSubEval9{$iSubEvals})
  //[zzAlumnos_EvaluacionesPeriodica]Eval_10_Simbolo:=EV2_Real_a_Simbolo (aRealSubEval10{$iSubEvals})
  //[zzAlumnos_EvaluacionesPeriodica]Eval_11_Simbolo:=EV2_Real_a_Simbolo (aRealSubEval11{$iSubEvals})
  //[zzAlumnos_EvaluacionesPeriodica]Eval_12_Simbolo:=EV2_Real_a_Simbolo (aRealSubEval12{$iSubEvals})
  //[zzAlumnos_EvaluacionesPeriodica]PresentExamen_Simbolo:=EV2_Real_a_Simbolo (aRealSubEvalPresentacion{$iSubEvals})
  //[zzAlumnos_EvaluacionesPeriodica]Examen_Simbolo:=EV2_Real_a_Simbolo (aRealSubEvalControles{$iSubEvals})
  //[zzAlumnos_EvaluacionesPeriodica]FinalPeriodo_Simbolo:=EV2_Real_a_Simbolo (aRealSubEvalP1{$iSubEvals})
  //
  //QUERY([xxSTR_Niveles];[xxSTR_Niveles]NoNivel;=;[Asignaturas]Numero_del_Nivel)
  //EVS_ReadStyleData ([xxSTR_Niveles]EvStyle_oficial)
  //[zzAlumnos_EvaluacionesPeriodica]Eval_01_LiteralOficial:=NTA_PercentValue2StringValue (aRealSubEval1{$iSubEvals};iPrintActa)
  //[zzAlumnos_EvaluacionesPeriodica]Eval_02_LiteralOficial:=NTA_PercentValue2StringValue (aRealSubEval2{$iSubEvals};iPrintActa)
  //[zzAlumnos_EvaluacionesPeriodica]Eval_03_LiteralOficial:=NTA_PercentValue2StringValue (aRealSubEval3{$iSubEvals};iPrintActa)
  //[zzAlumnos_EvaluacionesPeriodica]Eval_04_LiteralOficial:=NTA_PercentValue2StringValue (aRealSubEval4{$iSubEvals};iPrintActa)
  //[zzAlumnos_EvaluacionesPeriodica]Eval_05_LiteralOficial:=NTA_PercentValue2StringValue (aRealSubEval5{$iSubEvals};iPrintActa)
  //[zzAlumnos_EvaluacionesPeriodica]Eval_06_LiteralOficial:=NTA_PercentValue2StringValue (aRealSubEval6{$iSubEvals};iPrintActa)
  //[zzAlumnos_EvaluacionesPeriodica]Eval_07_LiteralOficial:=NTA_PercentValue2StringValue (aRealSubEval7{$iSubEvals};iPrintActa)
  //[zzAlumnos_EvaluacionesPeriodica]Eval_08_LiteralOficial:=NTA_PercentValue2StringValue (aRealSubEval8{$iSubEvals};iPrintActa)
  //[zzAlumnos_EvaluacionesPeriodica]Eval_09_LiteralOficial:=NTA_PercentValue2StringValue (aRealSubEval9{$iSubEvals};iPrintActa)
  //[zzAlumnos_EvaluacionesPeriodica]Eval_10_LiteralOficial:=NTA_PercentValue2StringValue (aRealSubEval10{$iSubEvals};iPrintActa)
  //[zzAlumnos_EvaluacionesPeriodica]Eval_11_LiteralOficial:=NTA_PercentValue2StringValue (aRealSubEval11{$iSubEvals};iPrintActa)
  //[zzAlumnos_EvaluacionesPeriodica]Eval_12_LiteralOficial:=NTA_PercentValue2StringValue (aRealSubEval12{$iSubEvals};iPrintActa)
  //[zzAlumnos_EvaluacionesPeriodica]PresentExamen_LiteralOficial:=NTA_PercentValue2StringValue (aRealSubEvalPresentacion{$iSubEvals};iPrintActa)
  //[zzAlumnos_EvaluacionesPeriodica]Examen_LiteralOficial:=NTA_PercentValue2StringValue (aRealSubEvalControles{$iSubEvals};iPrintActa)
  //[zzAlumnos_EvaluacionesPeriodica]FinalPeriodo_LiteralOficial:=NTA_PercentValue2StringValue (aRealSubEvalP1{$iSubEvals};iPrintActa)
  //SAVE RECORD([zzAlumnos_EvaluacionesPeriodica])
  //
  //EVS_ReadStyleData ($estiloEvaluacion)
  //
  //GOTO RECORD([Asignaturas];$aRecNums{$i})
  //EVAL_LeeEvaluacionesFinales ($key)
  //End if 
  //End for 
  //If ([Asignaturas]VariableConfig)
  //AS_PropEval_Escritura ($fatObjectName)
  //End if 
  //End if 
  //End for 
  //If (Not([Asignaturas]VariableConfig))
  //AS_PropEval_Escritura ($fatObjectName)
  //End if 
  //End if 
  //End for 
  //End for 
  //CD_THERMOMETREXSEC (-1)
  //
  //USE SET("SubAsignaturas_aEliminar")
  //KRL_DeleteSelection (->[xxSTR_Subasignaturas])
  //
  //PREF_Set (0;"ConvSubasignaturasPreescolar";"Si")
  //
  //  `
  //  `ARRAY DATE(adSTR_Calendario_Feriados;0)
  //  `APPEND TO ARRAY(adSTR_Calendario_Feriados;DT_GetDateFromDayMonthYear (16;9;2007))
  //  `APPEND TO ARRAY(adSTR_Calendario_Feriados;DT_GetDateFromDayMonthYear (17;11;2007))
  //  `APPEND TO ARRAY(adSTR_Calendario_Feriados;DT_GetDateFromDayMonthYear (24;12;2007))
  //  `APPEND TO ARRAY(adSTR_Calendario_Feriados;DT_GetDateFromDayMonthYear (31;12;2007))
  //  `APPEND TO ARRAY(adSTR_Calendario_Feriados;DT_GetDateFromDayMonthYear (1;1;2008))
  //  `APPEND TO ARRAY(adSTR_Calendario_Feriados;DT_GetDateFromDayMonthYear (4;2;2008))
  //  `APPEND TO ARRAY(adSTR_Calendario_Feriados;DT_GetDateFromDayMonthYear (17;3;2008))
  //  `APPEND TO ARRAY(adSTR_Calendario_Feriados;DT_GetDateFromDayMonthYear (20;3;2008))
  //  `APPEND TO ARRAY(adSTR_Calendario_Feriados;DT_GetDateFromDayMonthYear (21;3;2008))
  //  `APPEND TO ARRAY(adSTR_Calendario_Feriados;DT_GetDateFromDayMonthYear (22;3;2008))
  //  `APPEND TO ARRAY(adSTR_Calendario_Feriados;DT_GetDateFromDayMonthYear (1;5;2008))
  //  `$fechaInicio:=!20/08/07!
  //  `$fecha:=!20/08/07!
  //  `$fechaTermino:=!31/05/08!
  //  `Repeat 
  //  `If ((Day number($fecha)=Saturday ) | (Day number($fecha)=Sunday ))
  //  `APPEND TO ARRAY(adSTR_Calendario_Feriados;$fecha)
  //  `End if 
  //  `$fecha:=$fecha+1
  //  `Until ($fecha>$fechaTermino)
  //  `$otRef:=OT New 
  //  `OT PutArray ($otRef;"adSTR_Calendario_Feriados";adSTR_Calendario_Feriados)
  //  `$blobFeriados:=OT ObjectToNewBLOB ($otRef)
  //  `  `creación de configuración para primaria
  //  `CREATE RECORD([xxSTR_Periodos])
  //  `[xxSTR_Periodos]ID:=SQ_SeqNumber (->[xxSTR_Periodos]ID)
  //  `[xxSTR_Periodos]ConSubPeriodos:=True
  //  `[xxSTR_Periodos]Inicio_Ejercicio:=!20/08/07!
  //  `[xxSTR_Periodos]Fin_Ejercicio:=!16/05/08!
  //  `[xxSTR_Periodos]Nombre_Configuracion:="Pre-escolar, 5 Períodos"
  //  `[xxSTR_Periodos]Tipo_de_Periodos:=7
  //  `[xxSTR_Periodos]Feriados:=$blobFeriados
  //  `[xxSTR_Periodos]Horarios:=$blobHorario
  //  `[xxSTR_Periodos]Dias_Habiles:=DT_GetWorkingDays ([xxSTR_Periodos]Inicio_Ejercicio;[xxSTR_Periodos]Fin_Ejercicio)
  //  `[xxSTR_Periodos]Horas_Jornada:=8
  //  `SAVE RECORD([xxSTR_Periodos])
  //  `vlMX_idPreescolar:=[xxSTR_Periodos]ID
  //  `
  //  `CREATE RECORD([xxSTR_DatosPeriodos])
  //  `[xxSTR_DatosPeriodos]ID_Institucion:=0
  //  `[xxSTR_DatosPeriodos]ID_Configuracion:=vlMX_idPreescolar
  //  `[xxSTR_DatosPeriodos]FechaInicio:=!20/08/07!
  //  `[xxSTR_DatosPeriodos]FechaTermino:=!22/10/07!
  //  `[xxSTR_DatosPeriodos]FechaCierre:=!28/10/07!
  //  `[xxSTR_DatosPeriodos]DiasHabiles:=DT_GetWorkingDays ([xxSTR_DatosPeriodos]FechaInicio;[xxSTR_DatosPeriodos]FechaTermino)
  //  `[xxSTR_DatosPeriodos]Nombre:="1er Bimestre"
  //  `[xxSTR_DatosPeriodos]NumeroPeriodo:=1
  //  `[xxSTR_DatosPeriodos]NumeroSubPeriodo:=0
  //  `SAVE RECORD([xxSTR_DatosPeriodos])
  //  `
  //  `CREATE RECORD([xxSTR_DatosPeriodos])
  //  `[xxSTR_DatosPeriodos]ID_Institucion:=0
  //  `[xxSTR_DatosPeriodos]ID_Configuracion:=vlMX_idPreescolar
  //  `[xxSTR_DatosPeriodos]FechaInicio:=!23/10/07!
  //  `[xxSTR_DatosPeriodos]FechaTermino:=!21/12/07!
  //  `[xxSTR_DatosPeriodos]FechaCierre:=!30/12/07!
  //  `[xxSTR_DatosPeriodos]DiasHabiles:=DT_GetWorkingDays ([xxSTR_DatosPeriodos]FechaInicio;[xxSTR_DatosPeriodos]FechaTermino)
  //  `[xxSTR_DatosPeriodos]Nombre:="2º Bimestre"
  //  `[xxSTR_DatosPeriodos]NumeroPeriodo:=2
  //  `[xxSTR_DatosPeriodos]NumeroSubPeriodo:=0
  //  `SAVE RECORD([xxSTR_DatosPeriodos])
  //  `
  //  `CREATE RECORD([xxSTR_DatosPeriodos])
  //  `[xxSTR_DatosPeriodos]ID_Institucion:=0
  //  `[xxSTR_DatosPeriodos]ID_Configuracion:=vlMX_idPreescolar
  //  `[xxSTR_DatosPeriodos]FechaInicio:=!07/01/08!
  //  `[xxSTR_DatosPeriodos]FechaTermino:=!29/02/08!
  //  `[xxSTR_DatosPeriodos]FechaCierre:=!07/03/08!
  //  `[xxSTR_DatosPeriodos]DiasHabiles:=DT_GetWorkingDays ([xxSTR_DatosPeriodos]FechaInicio;[xxSTR_DatosPeriodos]FechaTermino)
  //  `[xxSTR_DatosPeriodos]Nombre:="Evaluación Semestral"
  //  `[xxSTR_DatosPeriodos]NumeroPeriodo:=3
  //  `[xxSTR_DatosPeriodos]NumeroSubPeriodo:=0
  //  `SAVE RECORD([xxSTR_DatosPeriodos])
  //  `
  //  `CREATE RECORD([xxSTR_DatosPeriodos])
  //  `[xxSTR_DatosPeriodos]ID_Institucion:=0
  //  `[xxSTR_DatosPeriodos]ID_Configuracion:=vlMX_idPreescolar
  //  `[xxSTR_DatosPeriodos]FechaInicio:=!03/03/08!
  //  `[xxSTR_DatosPeriodos]FechaTermino:=!10/05/05!
  //  `[xxSTR_DatosPeriodos]FechaCierre:=!16/05/05!
  //  `[xxSTR_DatosPeriodos]DiasHabiles:=DT_GetWorkingDays ([xxSTR_DatosPeriodos]FechaInicio;[xxSTR_DatosPeriodos]FechaTermino)
  //  `[xxSTR_DatosPeriodos]Nombre:="4º Bimestre"
  //  `[xxSTR_DatosPeriodos]NumeroPeriodo:=4
  //  `[xxSTR_DatosPeriodos]NumeroSubPeriodo:=0
  //  `SAVE RECORD([xxSTR_DatosPeriodos])
  //  `
  //  `CREATE RECORD([xxSTR_DatosPeriodos])
  //  `[xxSTR_DatosPeriodos]ID_Institucion:=0
  //  `[xxSTR_DatosPeriodos]ID_Configuracion:=vlMX_idPreescolar
  //  `[xxSTR_DatosPeriodos]FechaInicio:=!11/05/08!
  //  `[xxSTR_DatosPeriodos]FechaTermino:=!16/05/08!
  //  `[xxSTR_DatosPeriodos]FechaCierre:=!20/05/08!
  //  `[xxSTR_DatosPeriodos]DiasHabiles:=DT_GetWorkingDays ([xxSTR_DatosPeriodos]FechaInicio;[xxSTR_DatosPeriodos]FechaTermino)
  //  `[xxSTR_DatosPeriodos]Nombre:="Evaluación Final"
  //  `[xxSTR_DatosPeriodos]NumeroPeriodo:=5
  //  `[xxSTR_DatosPeriodos]NumeroSubPeriodo:=0
  //  `SAVE RECORD([xxSTR_DatosPeriodos])
  //  `
  //  `QUERY([xxSTR_Niveles];[xxSTR_Niveles]NoNivel<0)
  //  `READ WRITE([xxSTR_Niveles])
  //  `APPLY TO SELECTION([xxSTR_Niveles];[xxSTR_Niveles]ID_ConfiguracionPeriodos:=vlMX_idPreescolar)
  //  `UNLOAD RECORD([xxSTR_Niveles])
  //
  //
  //
  //NIV_LoadArrays 
  //
  //◊noBatchProcessor:=False
  //End if 
  //
