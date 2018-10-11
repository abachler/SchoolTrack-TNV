//%attributes = {}
  //AS_EVLG_SaveEvaluaciones


  //$idAsignatura:=$1
  //$nivelEvaluacion:=$2
  //$idEje:=$3
  //$idLogro:=$3  `asigno $3 ($3 puede ser el ID del eje, el ID del logro, o el ID de la instancia de evaluación)
  //$idInstancia:=$3
  //$periodo:=$4
  //
  //If (vbEVLG_EvaluacionesModificadas)
  //Case of 
  //: ($nivelEvaluacion=Eje_Aprendizaje )
  //USE SET("EjesEnEvaluacion")
  //ORDER BY([Alumnos_Ejes];[Alumnos_Ejes]Key;>)
  //SORT ARRAY(atEVLG_LLavesEjes;atEVLG_Indicadores;asEVLG_EvaluacionSimbolos;arEVLG_EvaluacionReal;>)
  //READ WRITE([Alumnos_Ejes])
  //Case of 
  //: ($periodo=1)
  //ARRAY TO SELECTION(atEVLG_Indicadores;[Alumnos_Ejes]Periodo1_Observaciones;asEVLG_EvaluacionSimbolos;[Alumnos_Ejes]Periodo1_Simbolo;arEVLG_EvaluacionReal;[Alumnos_Ejes]Periodo1_Real)
  //: ($periodo=2)
  //ARRAY TO SELECTION(atEVLG_Indicadores;[Alumnos_Ejes]Periodo2_Observaciones;asEVLG_EvaluacionSimbolos;[Alumnos_Ejes]Periodo2_Simbolo;arEVLG_EvaluacionReal;[Alumnos_Ejes]Periodo2_Real)
  //: ($periodo=3)
  //ARRAY TO SELECTION(atEVLG_Indicadores;[Alumnos_Ejes]Periodo3_Observaciones;asEVLG_EvaluacionSimbolos;[Alumnos_Ejes]Periodo3_Simbolo;arEVLG_EvaluacionReal;[Alumnos_Ejes]Periodo3_Real)
  //: ($periodo=4)
  //ARRAY TO SELECTION(atEVLG_Indicadores;[Alumnos_Ejes]Periodo4_Observaciones;asEVLG_EvaluacionSimbolos;[Alumnos_Ejes]Periodo4_Simbolo;arEVLG_EvaluacionReal;[Alumnos_Ejes]Periodo4_Real)
  //End case 
  //ARRAY TO SELECTION(atEVLG_Indicadores;[Alumnos_Ejes]Inutilizado;asEVLG_EvaluacionSimbolos;[Alumnos_Ejes]Periodo1_Simbolo;arEVLG_EvaluacionReal;[Alumnos_Ejes]Periodo1_Real)
  //UNLOAD RECORD([Alumnos_Ejes])
  //READ ONLY([Alumnos_Ejes])
  //
  //: ($nivelEvaluacion=Dimension_Aprendizaje )
  //
  //: ($nivelEvaluacion=Logro_Aprendizaje )
  //READ WRITE([Alumnos_Logros])
  //USE SET("LogrosEnEvaluacion")
  //ORDER BY([Alumnos_Logros];[Alumnos_Logros]Key;>)
  //$idEjeLogro:=[Alumnos_Logros]ID_Eje
  //SORT ARRAY(atEVLG_LLavesEjes;atEVLG_Indicadores;asEVLG_EvaluacionSimbolos;arEVLG_EvaluacionReal;>)
  //Case of 
  //: (vtEVLG_TipoEvaluacion="Evaluación")
  //Case of 
  //: ($periodo=1)
  //ARRAY TO SELECTION(atEVLG_Indicadores;[Alumnos_Logros]Periodo1_Evaluacion_Indicador;asEVLG_EvaluacionSimbolos;[Alumnos_Logros]Periodo1_Evaluacion_Simbolo;arEVLG_EvaluacionReal;[Alumnos_Logros]Periodo1_Evaluacion_Real)
  //: ($periodo=2)
  //ARRAY TO SELECTION(atEVLG_Indicadores;[Alumnos_Logros]Periodo2_Evaluacion_Indicador;asEVLG_EvaluacionSimbolos;[Alumnos_Logros]Periodo2_Evaluacion_Simbolo;arEVLG_EvaluacionReal;[Alumnos_Logros]Periodo2_Evaluacion_Real)
  //: ($periodo=3)
  //ARRAY TO SELECTION(atEVLG_Indicadores;[Alumnos_Logros]Periodo3_Evaluacion_Indicador;asEVLG_EvaluacionSimbolos;[Alumnos_Logros]Periodo3_Evaluacion_Simbolo;arEVLG_EvaluacionReal;[Alumnos_Logros]Periodo3_Evaluacion_Real)
  //: ($periodo=4)
  //ARRAY TO SELECTION(atEVLG_Indicadores;[Alumnos_Logros]Periodo4_Evaluacion_Indicador;asEVLG_EvaluacionSimbolos;[Alumnos_Logros]Periodo4_Evaluacion_Simbolo;arEVLG_EvaluacionReal;[Alumnos_Logros]Periodo4_Evaluacion_Real)
  //End case 
  //
  //: (vtEVLG_TipoEvaluacion="Recuperación")
  //Case of 
  //: ($periodo=1)
  //ARRAY TO SELECTION(atEVLG_Indicadores;[Alumnos_Logros]Periodo1_Recuperacion_Indicador;asEVLG_EvaluacionSimbolos;[Alumnos_Logros]Periodo1_Recuperacion_Simbolo;arEVLG_EvaluacionReal;[Alumnos_Logros]Periodo1_Recuperacion_Real)
  //: ($periodo=2)
  //ARRAY TO SELECTION(atEVLG_Indicadores;[Alumnos_Logros]Periodo2_Recuperacion_Indicador;asEVLG_EvaluacionSimbolos;[Alumnos_Logros]Periodo2_Recuperacion_Simbolo;arEVLG_EvaluacionReal;[Alumnos_Logros]Periodo2_Recuperacion_Real)
  //: ($periodo=3)
  //ARRAY TO SELECTION(atEVLG_Indicadores;[Alumnos_Logros]Periodo3_Recuperacion_Indicador;asEVLG_EvaluacionSimbolos;[Alumnos_Logros]Periodo3_Recuperacion_Simbolo;arEVLG_EvaluacionReal;[Alumnos_Logros]Periodo3_Recuperacion_Real)
  //: ($periodo=4)
  //ARRAY TO SELECTION(atEVLG_Indicadores;[Alumnos_Logros]Periodo4_Recuperacion_Indicador;asEVLG_EvaluacionSimbolos;[Alumnos_Logros]Periodo4_Recuperacion_Simbolo;arEVLG_EvaluacionReal;[Alumnos_Logros]Periodo4_Recuperacion_Real)
  //End case 
  //
  //: (vtEVLG_TipoEvaluacion="Auto Evaluacion")
  //Case of 
  //: ($periodo=1)
  //ARRAY TO SELECTION(atEVLG_Indicadores;[Alumnos_Logros]Periodo1_AutoEval_Indicador;asEVLG_EvaluacionSimbolos;[Alumnos_Logros]Periodo1_AutoEval_Simbolo;arEVLG_EvaluacionReal;[Alumnos_Logros]Periodo1_AutoEval_Real)
  //: ($periodo=2)
  //ARRAY TO SELECTION(atEVLG_Indicadores;[Alumnos_Logros]Periodo2_AutoEval_Indicador;asEVLG_EvaluacionSimbolos;[Alumnos_Logros]Periodo2_AutoEval_Simbolo;arEVLG_EvaluacionReal;[Alumnos_Logros]Periodo2_AutoEval_Real)
  //: ($periodo=3)
  //ARRAY TO SELECTION(atEVLG_Indicadores;[Alumnos_Logros]Periodo3_AutoEval_Indicador;asEVLG_EvaluacionSimbolos;[Alumnos_Logros]Periodo3_AutoEval_Simbolo;arEVLG_EvaluacionReal;[Alumnos_Logros]Periodo3_AutoEval_Real)
  //: ($periodo=4)
  //ARRAY TO SELECTION(atEVLG_Indicadores;[Alumnos_Logros]Periodo4_AutoEval_Indicador;asEVLG_EvaluacionSimbolos;[Alumnos_Logros]Periodo4_AutoEval_Simbolo;arEVLG_EvaluacionReal;[Alumnos_Logros]Periodo4_AutoEval_Real)
  //End case 
  //
  //End case 
  //UNLOAD RECORD([Alumnos_Logros])
  //READ ONLY([Alumnos_Logros])
  //$m1:=Milliseconds
  //AS_EVLG_Calcula_EJE ([Asignaturas]Numero;$idEjeLogro;$periodo)
  //$m2:=Milliseconds
  //$m:=$m2-$m1
  //
  //: ($nivelEvaluacion=Finales_Aprendizajes )
  //USE SET("EvaluacionesFinales")
  //SORT ARRAY(atEVLG_LLavesEjes;atEVLG_Observaciones_Final;asEVLG_EvaluacionSimbolos_Final;arEVLG_EvaluacionReal_Final;asEVLG_EvaluacionSimbolos_P1;asEVLG_EvaluacionSimbolos_P2;asEVLG_EvaluacionSimbolos_P3;asEVLG_EvaluacionSimbolos_P4;arEVLG_EvaluacionReal_P1;arEVLG_EvaluacionReal_P2;arEVLG_EvaluacionReal_P3;arEVLG_EvaluacionReal_P4;>)
  //Case of 
  //: (Size of array(atSTR_Periodos_Nombre)=4)
  //ARRAY TO SELECTION(atEVLG_LLavesEjes;[Alumnos_EvaluacionesFinales]Key;atEVLG_Observaciones_Final;[Alumnos_EvaluacionesFinales]Final_Observaciones;asEVLG_EvaluacionSimbolos_Final;[Alumnos_EvaluacionesFinales]Final_Simbolo;arEVLG_EvaluacionReal_Final;[Alumnos_EvaluacionesFinales]Final_Real;asEVLG_EvaluacionSimbolos_P1;[Alumnos_EvaluacionesFinales]Periodo1_Simbolo;asEVLG_EvaluacionSimbolos_P2;[Alumnos_EvaluacionesFinales]Periodo2_Simbolo;asEVLG_EvaluacionSimbolos_P3;[Alumnos_EvaluacionesFinales]Periodo3_Simbolo;asEVLG_EvaluacionSimbolos_P4;[Alumnos_EvaluacionesFinales]Periodo4_Simbolo;arEVLG_EvaluacionReal_P1;[Alumnos_EvaluacionesFinales]Periodo1_Real;arEVLG_EvaluacionReal_P2;[Alumnos_EvaluacionesFinales]Periodo2_Real;arEVLG_EvaluacionReal_P3;[Alumnos_EvaluacionesFinales]Periodo3_Real;arEVLG_EvaluacionReal_P4;[Alumnos_EvaluacionesFinales]Periodo4_Real)
  //: (Size of array(atSTR_Periodos_Nombre)=3)
  //ARRAY TO SELECTION(atEVLG_LLavesEjes;[Alumnos_EvaluacionesFinales]Key;atEVLG_Observaciones_Final;[Alumnos_EvaluacionesFinales]Final_Observaciones;asEVLG_EvaluacionSimbolos_Final;[Alumnos_EvaluacionesFinales]Final_Simbolo;arEVLG_EvaluacionReal_Final;[Alumnos_EvaluacionesFinales]Final_Real;asEVLG_EvaluacionSimbolos_P1;[Alumnos_EvaluacionesFinales]Periodo1_Simbolo;asEVLG_EvaluacionSimbolos_P2;[Alumnos_EvaluacionesFinales]Periodo2_Simbolo;asEVLG_EvaluacionSimbolos_P3;[Alumnos_EvaluacionesFinales]Periodo3_Simbolo;arEVLG_EvaluacionReal_P1;[Alumnos_EvaluacionesFinales]Periodo1_Real;arEVLG_EvaluacionReal_P2;[Alumnos_EvaluacionesFinales]Periodo2_Real;arEVLG_EvaluacionReal_P3;[Alumnos_EvaluacionesFinales]Periodo3_Real)
  //: (Size of array(atSTR_Periodos_Nombre)=2)
  //ARRAY TO SELECTION(atEVLG_LLavesEjes;[Alumnos_EvaluacionesFinales]Key;atEVLG_Observaciones_Final;[Alumnos_EvaluacionesFinales]Final_Observaciones;asEVLG_EvaluacionSimbolos_Final;[Alumnos_EvaluacionesFinales]Final_Simbolo;arEVLG_EvaluacionReal_Final;[Alumnos_EvaluacionesFinales]Final_Real;asEVLG_EvaluacionSimbolos_P1;[Alumnos_EvaluacionesFinales]Periodo1_Simbolo;asEVLG_EvaluacionSimbolos_P2;[Alumnos_EvaluacionesFinales]Periodo2_Simbolo;arEVLG_EvaluacionReal_P1;[Alumnos_EvaluacionesFinales]Periodo1_Real;arEVLG_EvaluacionReal_P2;[Alumnos_EvaluacionesFinales]Periodo2_Real)
  //: (Size of array(atSTR_Periodos_Nombre)=1)
  //ARRAY TO SELECTION(atEVLG_LLavesEjes;[Alumnos_EvaluacionesFinales]Key;atEVLG_Observaciones_Final;[Alumnos_EvaluacionesFinales]Final_Observaciones;asEVLG_EvaluacionSimbolos_Final;[Alumnos_EvaluacionesFinales]Final_Simbolo;arEVLG_EvaluacionReal_Final;[Alumnos_EvaluacionesFinales]Final_Real;asEVLG_EvaluacionSimbolos_P1;[Alumnos_EvaluacionesFinales]Periodo1_Simbolo;arEVLG_EvaluacionReal_P1;[Alumnos_EvaluacionesFinales]Periodo1_Real)
  //End case 
  //
  //: ($nivelEvaluacion=Instancia_Aprendizaje )
  //ALERT("No implementado.")
  //End case 
  //
  //End if 