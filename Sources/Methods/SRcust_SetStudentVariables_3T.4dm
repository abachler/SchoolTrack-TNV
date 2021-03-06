//%attributes = {}
  //SRcust_SetStudentVariables_3T
AT_Inc (0)

asSRVariables{AT_Inc }:="1;Variables sistema"
asSRVariables{AT_Inc }:="1;Fecha de impresión;sRDate;1"
asSRVariables{AT_Inc }:="1;Hora de impresión;sRTime;1"
asSRVariables{AT_Inc }:="1;Número de página;sRPage;1"
asSRVariables{AT_Inc }:="2;Datos del colegio"
asSRVariables{AT_Inc }:="2;Nombre del colegio;◊gCustom;1"
asSRVariables{AT_Inc }:="2;Director;◊gRector;1"
asSRVariables{AT_Inc }:="2;Dirección;◊gDireccion;1"
asSRVariables{AT_Inc }:="2;Comuna;◊gComuna;1"
asSRVariables{AT_Inc }:="2;Ciudad;◊gCiudad;1"
asSRVariables{AT_Inc }:="2;Provincia;◊gProvincia;1"
asSRVariables{AT_Inc }:="2;Región;◊gRegion;1"
asSRVariables{AT_Inc }:="2;RUT del colegio;◊gRut;1"
asSRVariables{AT_Inc }:="2;Rol de base de datos;◊gRolBD;1"
asSRVariables{AT_Inc }:="2;Año escolar;◊gYear;1"
asSRVariables{AT_Inc }:="2;Representante legal;<>gRepLegalNombre;1"
asSRVariables{AT_Inc }:="2;RUT representante legal;<>gRepLegalRUT;1"
asSRVariables{AT_Inc }:="2;Giro;<>gGiro;1"

  //Modo Impresión
asSRVariables{AT_Inc }:="3;Evaluaciones [Modo impresión]"
asSRVariables{AT_Inc }:="3;Nombre oficial del subsector;vs_SubjectName;1"
asSRVariables{AT_Inc }:="3;Nombre interno del subsector;vs_SubjectAlias;1"
asSRVariables{AT_Inc }:="3;Nombre del sector;vs_sector;1"
For ($i;1;12)
	asSRVariables{AT_Inc }:="3;Parcial "+String:C10($i)+";"+"vs_Evaluacion"+String:C10($i)+";1"
End for 
asSRVariables{AT_Inc }:="3;Promedio Parciales;vs_EvaluacionPresentacion;1"
asSRVariables{AT_Inc }:="3;Control de fin de trimestre;vs_EvaluacionEXP;1"
asSRVariables{AT_Inc }:="3;Promedio del trimestre;vs_EvaluacionPromedioPeriodo;1"
asSRVariables{AT_Inc }:="3;Promedio Parciales 1er Trimestre;vs_EvaluacionPresentacionP1;1"
asSRVariables{AT_Inc }:="3;Control 1er trimestre;vs_EvaluacionEXP1;1"
asSRVariables{AT_Inc }:="3;Promedio 1er trimestre;vs_EvaluacionPromedio1;1"
asSRVariables{AT_Inc }:="3;Promedio Parciales 2do Trimestre;vs_EvaluacionPresentacionP2;1"
asSRVariables{AT_Inc }:="3;Control 2do trimestre;vs_EvaluacionEXP2;1"
asSRVariables{AT_Inc }:="3;Promedio 2do trimestre;vs_EvaluacionPromedio2;1"
asSRVariables{AT_Inc }:="3;Promedio Parciales 3er Trimestre;vs_EvaluacionPresentacionP3;1"
asSRVariables{AT_Inc }:="3;Control 3er trimestre;vs_EvaluacionEXP3;1"
asSRVariables{AT_Inc }:="3;Promedio 3er trimestre;vs_EvaluacionPromedio3;1"
asSRVariables{AT_Inc }:="3;Promedio anual;vs_EvaluacionPromedioFinal;1"
asSRVariables{AT_Inc }:="3;Examen;vs_EvaluacionExamen;1"
asSRVariables{AT_Inc }:="3;Final Interno;vs_EvaluacionFinal;1"
asSRVariables{AT_Inc }:="3;Final Oficial;vs_EvaluacionOficial;1"
asSRVariables{AT_Inc }:="3;Promedio del grupo o curso [trimestre];vs_EvaluacionAvgSubject;1"
asSRVariables{AT_Inc }:="3;Minimo grupo o curso [trimestre];vs_EvaluacionMinSubject;1"
asSRVariables{AT_Inc }:="3;Máximo grupo o curso [trimestre];vs_EvaluacionMaxSubject;1"
asSRVariables{AT_Inc }:="3;Promedio del grupo o curso [final];vs_EvaluacionAvgSubjectF;1"
asSRVariables{AT_Inc }:="3;Minimo grupo o curso [final];vs_EvaluacionMinSubjectF;1"
asSRVariables{AT_Inc }:="3;Máximo grupo o curso [final];vs_EvaluacionMaxSubjectF;1"


  //NOTAS
asSRVariables{AT_Inc }:="4;Evaluaciones [Notas]"
asSRVariables{AT_Inc }:="4;Nombre oficial del subsector;vs_SubjectName;1"
asSRVariables{AT_Inc }:="4;Nombre interno del subsector;vs_SubjectAlias;1"
asSRVariables{AT_Inc }:="4;Nombre del sector;vs_sector;1"
For ($i;1;12)
	asSRVariables{AT_Inc }:="4;Parcial "+String:C10($i)+";"+"vs_nota"+String:C10($i)+";1"
End for 
asSRVariables{AT_Inc }:="4;Promedio Parciales;vs_NotaPresentacion;1"
asSRVariables{AT_Inc }:="4;Control de fin de trimestre;vs_NotaEXP;1"
asSRVariables{AT_Inc }:="4;Promedio del trimestre;vs_NotaPromedioPeriodo;1"
asSRVariables{AT_Inc }:="4;Promedio Parciales 1er Trimestre;vs_NotaPresentacionP1;1"
asSRVariables{AT_Inc }:="4;Control 1er trimestre;vs_NotaEXP1;1"
asSRVariables{AT_Inc }:="4;Promedio 1er trimestre;vs_NotaPromedio1;1"
asSRVariables{AT_Inc }:="4;Promedio Parciales 2do Trimestre;vs_NotaPresentacionP2;1"
asSRVariables{AT_Inc }:="4;Control 2do trimestre;vs_NotaEXP2;1"
asSRVariables{AT_Inc }:="4;Promedio 2do trimestre;vs_NotaPromedio2;1"
asSRVariables{AT_Inc }:="4;Promedio Parciales 3er Trimestre;vs_NotaPresentacionP3;1"
asSRVariables{AT_Inc }:="4;Control 3er trimestre;vs_NotaEXP3;1"
asSRVariables{AT_Inc }:="4;Promedio 3er trimestre;vs_NotaPromedio3;1"
asSRVariables{AT_Inc }:="4;Promedio anual;vs_NotaPromedioFinal;1"
asSRVariables{AT_Inc }:="4;Examen;vs_NotaExamen;1"
asSRVariables{AT_Inc }:="4;Final Interno;vs_NotaFinal;1"
asSRVariables{AT_Inc }:="4;Final Oficial;vs_NotaOficial;1"
asSRVariables{AT_Inc }:="4;Promedio del grupo o curso [trimestre];vs_NotaAvgSubject;1"
asSRVariables{AT_Inc }:="4;Minimo grupo o curso [trimestre];vs_NotaMinSubject;1"
asSRVariables{AT_Inc }:="4;Máximo grupo o curso [trimestre];vs_NotaMaxSubject;1"
asSRVariables{AT_Inc }:="4;Promedio del grupo o curso [final];vs_NotaAvgSubjectF;1"
asSRVariables{AT_Inc }:="4;Minimo grupo o curso [final];vs_NotaMinSubjectF;1"
asSRVariables{AT_Inc }:="4;Máximo grupo o curso [final];vs_NotaMaxSubjectF;1"

  //PUNTOS
asSRVariables{AT_Inc }:="5;Evaluaciones [Puntos]"
asSRVariables{AT_Inc }:="5;Nombre oficial del subsector;vs_SubjectName;1"
asSRVariables{AT_Inc }:="5;Nombre interno del subsector;vs_SubjectAlias;1"
asSRVariables{AT_Inc }:="5;Nombre del sector;vs_Sector;1"
For ($i;1;12)
	asSRVariables{AT_Inc }:="5;Parcial "+String:C10($i)+";"+"vs_Puntos"+String:C10($i)+";1;1"
End for 
asSRVariables{AT_Inc }:="5;Promedio Parciales;vs_PuntosPresentacion;1"
asSRVariables{AT_Inc }:="5;Control de fin de trimestre;vs_PuntosEXP;1"
asSRVariables{AT_Inc }:="5;Promedio del trimestre;vs_PuntosPromedioPeriodo;1"
asSRVariables{AT_Inc }:="5;Promedio Parciales 1er Trimestre;vs_PuntosPresentacionP1;1"
asSRVariables{AT_Inc }:="5;Control 1er trimestre;vs_PuntosEXP1;1"
asSRVariables{AT_Inc }:="5;Promedio 1er trimestre;vs_PuntosPromedio1;1"
asSRVariables{AT_Inc }:="5;Promedio Parciales 2do Trimestre;vs_PuntosPresentacionP2;1"
asSRVariables{AT_Inc }:="5;Control 2do trimestre;vs_PuntosEXP2;1"
asSRVariables{AT_Inc }:="5;Promedio 2do trimestre;vs_PuntosPromedio2;1"
asSRVariables{AT_Inc }:="5;Promedio Parciales 3er Trimestre;vs_PuntosPresentacionP3;1"
asSRVariables{AT_Inc }:="5;Control 3er trimestre;vs_PuntosEXP3;1"
asSRVariables{AT_Inc }:="5;Promedio 3er trimestre;vs_PuntosPromedio3;1"
asSRVariables{AT_Inc }:="5;Promedio anual;vs_PuntosPromedioFinal;1"
asSRVariables{AT_Inc }:="5;Examen;vs_PuntosExamen;1"
asSRVariables{AT_Inc }:="5;Final Interno;vs_PuntosFinal;1"
asSRVariables{AT_Inc }:="5;Final Oficial;vs_PuntosOficial;1"
asSRVariables{AT_Inc }:="5;Promedio del grupo o curso [trimestre];vs_PuntosAvgSubject;1"
asSRVariables{AT_Inc }:="5;Minimo grupo o curso [trimestre];vs_PuntosMinSubject;1"
asSRVariables{AT_Inc }:="5;Máximo grupo o curso [trimestre];vs_PuntosMaxSubject;1"
asSRVariables{AT_Inc }:="5;Promedio del grupo o curso [final];vs_PuntosAvgSubjectF;1"
asSRVariables{AT_Inc }:="5;Minimo grupo o curso [final];vs_PuntosMinSubjectF;1"
asSRVariables{AT_Inc }:="5;Máximo grupo o curso [final];vs_PuntosMaxSubjectF;1"

  //PORCENTAJES
asSRVariables{AT_Inc }:="6;Evaluaciones [Porcentajes]"
asSRVariables{AT_Inc }:="6;Nombre oficial del subsector;vs_SubjectName;1"
asSRVariables{AT_Inc }:="6;Nombre interno del subsector;vs_SubjectAlias;1"
asSRVariables{AT_Inc }:="6;Nombre del sector;vs_Sector;1"
For ($i;1;12)
	asSRVariables{AT_Inc }:="6;Parcial "+String:C10($i)+";"+"vr_Porcentaje"+String:C10($i)+";1;1"
End for 
asSRVariables{AT_Inc }:="6;Promedio Parciales;vr_PorcentajePresentacion;1"
asSRVariables{AT_Inc }:="6;Control de fin de trimestre;vr_PorcentajeEXP;1"
asSRVariables{AT_Inc }:="6;Promedio del trimestre;vr_PorcentajePromedioPeriodo;1"
asSRVariables{AT_Inc }:="6;Promedio Parciales 1er Trimestre;vr_PorcentajePresentacionP1;1"
asSRVariables{AT_Inc }:="6;Control 1er trimestre;vr_PorcentajeEXP1;1"
asSRVariables{AT_Inc }:="6;Promedio 1er trimestre;vr_PorcentajePromedio1;1"
asSRVariables{AT_Inc }:="6;Promedio Parciales 2do Trimestre;vr_PorcentajePresentacionP2;1"
asSRVariables{AT_Inc }:="6;Control 2do trimestre;vr_PorcentajeEXP2;1"
asSRVariables{AT_Inc }:="6;Promedio 2do trimestre;vr_PorcentajePromedio2;1"
asSRVariables{AT_Inc }:="6;Promedio Parciales 3er Trimestre;vr_PorcentajePresentacionP3;1"
asSRVariables{AT_Inc }:="6;Control 3er trimestre;vr_PorcentajeEXP3;1"
asSRVariables{AT_Inc }:="6;Promedio 3er trimestre;vr_PorcentajePromedio3;1"
asSRVariables{AT_Inc }:="6;Promedio anual;vr_PorcentajePromedioFinal;1"
asSRVariables{AT_Inc }:="6;Examen;vr_PorcentajeExamen;1"
asSRVariables{AT_Inc }:="6;Final Interno;vr_PorcentajeFinal;1"
asSRVariables{AT_Inc }:="6;Final Oficial;vs_PorcentajeOficial;1"
asSRVariables{AT_Inc }:="6;Promedio del grupo o curso [trimestre];vs_PorcentajesAvgSubject;1"
asSRVariables{AT_Inc }:="6;Minimo grupo o curso [trimestre];vs_PorcentajesMinSubject;1"
asSRVariables{AT_Inc }:="6;Máximo grupo o curso [trimestre];vs_PorcentajesMaxSubject;1"
asSRVariables{AT_Inc }:="6;Promedio del grupo o curso [final];vs_PorcentajesAvgSubjectF;1"
asSRVariables{AT_Inc }:="6;Minimo grupo o curso [final];vs_PorcentajesMinSubjectF;1"
asSRVariables{AT_Inc }:="6;Máximo grupo o curso [final];vs_PorcentajesMaxSubjectF;1"

  //SIMBOLOS
asSRVariables{AT_Inc }:="7;Evaluaciones [Simbolos]"
asSRVariables{AT_Inc }:="7;Nombre oficial del subsector;vs_SubjectName;1"
asSRVariables{AT_Inc }:="7;Nombre interno del subsector;vs_SubjectAlias;1"
asSRVariables{AT_Inc }:="7;Nombre del sector;vs_Sector;1"
For ($i;1;12)
	asSRVariables{AT_Inc }:="7;Parcial "+String:C10($i)+";"+"vs_Simbolos"+String:C10($i)+";1;1"
End for 
asSRVariables{AT_Inc }:="7;Promedio Parciales;vs_SimbolosPresentacion;1"
asSRVariables{AT_Inc }:="7;Control de fin de trimestre;vs_SimbolosEXP;1"
asSRVariables{AT_Inc }:="7;Promedio del trimestre;vs_SimbolosPromedioPeriodo;1"
asSRVariables{AT_Inc }:="7;Promedio Parciales 1er Trimestre;vs_SimbolosPresentacionP1;1"
asSRVariables{AT_Inc }:="7;Control 1er trimestre;vs_SimbolosEXP1;1"
asSRVariables{AT_Inc }:="7;Promedio 1er trimestre;vs_SimbolosPromedio1;1"
asSRVariables{AT_Inc }:="7;Promedio Parciales 2do Trimestre;vs_SimbolosPresentacionP2;1"
asSRVariables{AT_Inc }:="7;Control 2do trimestre;vs_SimbolosEXP2;1"
asSRVariables{AT_Inc }:="7;Promedio 2do trimestre;vs_SimbolosPromedio2;1"
asSRVariables{AT_Inc }:="7;Promedio Parciales 3er Trimestre;vs_SimbolosPresentacionP3;1"
asSRVariables{AT_Inc }:="7;Control 3er trimestre;vs_SimbolosEXP3;1"
asSRVariables{AT_Inc }:="7;Promedio 3er trimestre;vs_SimbolosPromedio3;1"
asSRVariables{AT_Inc }:="7;Promedio anual;vs_SimbolosPromedioFinal;1"
asSRVariables{AT_Inc }:="7;Examen;vs_SimbolosExamen;1"
asSRVariables{AT_Inc }:="7;Final Interno;vs_SimbolosFinal;1"
asSRVariables{AT_Inc }:="7;Final Oficial;vs_SimbolosOficial;1"
asSRVariables{AT_Inc }:="7;Promedio del grupo o curso [trimestre];vs_SimbolosAvgSubject;1"
asSRVariables{AT_Inc }:="7;Minimo grupo o curso [trimestre];vs_SimbolosMinSubject;1"
asSRVariables{AT_Inc }:="7;Máximo grupo o curso [trimestre];vs_SimbolosMaxSubject;1"
asSRVariables{AT_Inc }:="7;Promedio del grupo o curso [final];vs_SimbolosAvgSubjectF;1"
asSRVariables{AT_Inc }:="7;Minimo grupo o curso [final];vs_SimbolosMinSubjectF;1"
asSRVariables{AT_Inc }:="7;Máximo grupo o curso [final];vs_SimbolosMaxSubjectF;1"

  //Descripciones SIMBOLOS
asSRVariables{AT_Inc }:="8;Evaluaciones [INDICADORES]"
asSRVariables{AT_Inc }:="8;Nombre oficial del subsector;vs_SubjectName;1"
asSRVariables{AT_Inc }:="8;Nombre interno del subsector;vs_SubjectAlias;1"
asSRVariables{AT_Inc }:="8;Nombre del sector;vs_Sector;1"
For ($i;1;12)
	asSRVariables{AT_Inc }:="8;Parcial "+String:C10($i)+";"+"vs_indicador"+String:C10($i)+";1;1"
End for 
asSRVariables{AT_Inc }:="8;Promedio Parciales;vs_indicadorPresentacion;1"
asSRVariables{AT_Inc }:="8;Control de fin de trimestre;vs_indicadorEXP;1"
asSRVariables{AT_Inc }:="8;Promedio del trimestre;vs_indicadorPromedioPeriodo;1"
asSRVariables{AT_Inc }:="8;Promedio Parciales 1er Trimestre;vs_indicadorPresentacionP1;1"
asSRVariables{AT_Inc }:="8;Control 1er trimestre;vs_indicadorEXP1;1"
asSRVariables{AT_Inc }:="8;Promedio 1er trimestre;vs_indicadorPromedio1;1"
asSRVariables{AT_Inc }:="8;Promedio Parciales 2do Trimestre;vs_indicadorPresentacionP2;1"
asSRVariables{AT_Inc }:="8;Control 2do trimestre;vs_indicadorEXP2;1"
asSRVariables{AT_Inc }:="8;Promedio 2do trimestre;vs_indicadorPromedio2;1"
asSRVariables{AT_Inc }:="8;Promedio Parciales 3er Trimestre;vs_indicadorPresentacionP3;1"
asSRVariables{AT_Inc }:="8;Control 3er trimestre;vs_indicadorEXP3;1"
asSRVariables{AT_Inc }:="8;Promedio 3er trimestre;vs_indicadorPromedio3;1"
asSRVariables{AT_Inc }:="8;Promedio anual;vs_indicadorPromedioFinal;1"
asSRVariables{AT_Inc }:="8;Examen;vs_indicadorExamen;1"
asSRVariables{AT_Inc }:="8;Final Interno;vs_indicadorFinal;1"
asSRVariables{AT_Inc }:="8;Final Oficial;vs_indicadorOficial;1"
  //asSRVariables{AT_Inc }:="8;Promedio del grupo o curso [trimestre];vs_indicadorAvg  `Subject;1"
  //asSRVariables{AT_Inc }:="8;Minimo grupo o curso [trimestre];vs_indicadorMinSubjec  `t;1"
  //asSRVariables{AT_Inc }:="8;Máximo grupo o curso [trimestre];vs_indicadorMaxSubjec  `t;1"
  //asSRVariables{AT_Inc }:="8;Promedio del grupo o curso [final];vs_indicadorAvgSubj  `ectF;1"
  //asSRVariables{AT_Inc }:="8;Minimo grupo o curso [final];vs_indicadorMinSubjectF;1  `"
  //asSRVariables{AT_Inc }:="8;Máximo grupo o curso [final];vs_indicadorMaxSubjectF;1  `"

  // SUBEVALUACIONES
asSRVariables{AT_Inc }:="9;Sub-Evaluaciones"
asSRVariables{AT_Inc }:="9;Nombre de la subasignatura;vs_SubjectName;1"
asSRVariables{AT_Inc }:="9;Coeficiente o ponderación;arSRal_SubEvalCoeff;2"
For ($i;1;12)
	asSRVariables{AT_Inc }:="9;Parcial "+String:C10($i)+" [Modo impresion];"+"atSRal_SubEval"+String:C10($i)+"_Eval;2"
End for 
For ($i;1;12)
	asSRVariables{AT_Inc }:="9;Parcial "+String:C10($i)+" [Notas];"+"atSRal_SubEval"+String:C10($i)+"_Nota;2"
End for 
For ($i;1;12)
	asSRVariables{AT_Inc }:="9;Parcial "+String:C10($i)+" [Puntos];"+"atSRal_SubEval"+String:C10($i)+"_Puntos;2"
End for 
For ($i;1;12)
	asSRVariables{AT_Inc }:="9;Parcial "+String:C10($i)+" [Porcentaje];"+"atSRal_SubEval"+String:C10($i)+"_Porcentajes;2"
End for 
For ($i;1;12)
	asSRVariables{AT_Inc }:="9;Parcial "+String:C10($i)+" [Simbolos];"+"atSRal_SubEval"+String:C10($i)+"_Simbolos;2"
End for 
For ($i;1;12)
	asSRVariables{AT_Inc }:="9;Parcial "+String:C10($i)+" [Simbolos];"+"atSRal_SubEval"+String:C10($i)+"_Indicadores;2"
End for 
asSRVariables{AT_Inc }:="9;Nota presentación [Modo impresión];"+"atSRal_SubEvalPRES_Eval;2"  // nuevo
asSRVariables{AT_Inc }:="9;Control trimestre [Modo impresion];"+"atSRal_SubEvalEXP_Eval;2"  // nuevo
asSRVariables{AT_Inc }:="9;Promedio trimestre [Modo impresion];"+"atSRal_SubEvalPeriodo_Eval;2"
asSRVariables{AT_Inc }:="9;Promedio trimestre 1 [Modo impresion];"+"atSRal_SubEvalP1_Eval;2"
asSRVariables{AT_Inc }:="9;Promedio trimestre 2 [Modo impresion];"+"atSRal_SubEvalP2_Eval;2"
asSRVariables{AT_Inc }:="9;Promedio trimestre 3 [Modo impresion];"+"atSRal_SubEvalP3_Eval;2"
asSRVariables{AT_Inc }:="9;Promedio Final [Modo impresion];"+"atSRal_SubEvalPF_Eval;2"
asSRVariables{AT_Inc }:="9;Examen [Modo impresion];"+";atSRal_SubEvalEX_Eval2"
asSRVariables{AT_Inc }:="9;Nota final [Modo impresion];"+"atSRal_SubEvalF_Eval;2"
asSRVariables{AT_Inc }:="9;Nota presentación [Notas];"+"atSRal_SubEvalPRES_Nota;2"  // nuevo
asSRVariables{AT_Inc }:="9;Control trimestre [Notas];"+"atSRal_SubEvalEXP_Nota;2"  // nuevo
asSRVariables{AT_Inc }:="9;Promedio trimestre [Notas];"+"atSRal_SubEvalPeriodo_Nota;2"
asSRVariables{AT_Inc }:="9;Promedio trimestre 1[Notas];"+"atSRal_SubEvalP1_Nota;2"
asSRVariables{AT_Inc }:="9;Promedio trimestre 2[Notas];"+"atSRal_SubEvalP2_Nota;2"
asSRVariables{AT_Inc }:="9;Promedio trimestre 3 [Notas];"+"atSRal_SubEvalP3_Nota;2"
asSRVariables{AT_Inc }:="9;Promedio Final [Notas];"+"atSRal_SubEvalPF_Nota;2"
asSRVariables{AT_Inc }:="9;Examen [Notas];"+";atSRal_SubEvalEX_Nota2"
asSRVariables{AT_Inc }:="9;Nota final [Notas];"+"atSRal_SubEvalF_Nota;2"
asSRVariables{AT_Inc }:="9;Nota presentación [Puntos];"+"atSRal_SubEvalPRES_Puntos;2"  // nuevo
asSRVariables{AT_Inc }:="9;Control trimestre [Puntos ];"+"atSRal_SubEvalEXP_Puntos;2"  // nuevo
asSRVariables{AT_Inc }:="9;Promedio trimestre  [Puntos];"+"atSRal_SubEvalPeriodo_Puntos;2"
asSRVariables{AT_Inc }:="9;Promedio trimestre 1 [Puntos];"+"atSRal_SubEvalP1_Puntos;2"
asSRVariables{AT_Inc }:="9;Promedio trimestre 2 [Puntos];"+"atSRal_SubEvalP2_Puntos;2"
asSRVariables{AT_Inc }:="9;Promedio trimestre 3 [Puntos];"+"atSRal_SubEvalP3_Puntos;2"
asSRVariables{AT_Inc }:="9;Promedio Final [Puntos];"+"atSRal_SubEvalPF_Puntos;2"
asSRVariables{AT_Inc }:="9;Examen [Puntos];"+";atSRal_SubEvalEX_Puntos2"
asSRVariables{AT_Inc }:="9;Nota final [Puntos];"+"atSRal_SubEvalF_Puntos;2"
asSRVariables{AT_Inc }:="9;Nota presentación [Simbolos];"+"atSRal_SubEvalPRES_Simbolos;2"  // nuevo
asSRVariables{AT_Inc }:="9;Control trimestre [Símbolos];"+"atSRal_SubEvalEXP_Simbolos;2"  // nuevo
asSRVariables{AT_Inc }:="9;Promedio trimestre  [Simbolos];"+"atSRal_SubEvalPeriodo_Simbolos;2"
asSRVariables{AT_Inc }:="9;Promedio trimestre 1 [Simbolos];"+"atSRal_SubEvalP1_Simbolos;2"
asSRVariables{AT_Inc }:="9;Promedio trimestre 2 [Simbolos];"+"atSRal_SubEvalP2_Simbolos;2"
asSRVariables{AT_Inc }:="9;Promedio trimestre 3 [Simbolos];"+"atSRal_SubEvalP3_Simbolos;2"
asSRVariables{AT_Inc }:="9;Promedio Final [Simbolos];"+"atSRal_SubEvalPF_Simbolos;2"
asSRVariables{AT_Inc }:="9;Examen [Simbolos];"+";atSRal_SubEvalEX_Simbolos2"
asSRVariables{AT_Inc }:="9;Nota final [Simbolos];"+"atSRal_SubEvalF_Simbolos;2"
asSRVariables{AT_Inc }:="9;Nota presentación [Indicadores];"+"atSRal_SubEvalPRES_Indicadores;2"  // nuevo
asSRVariables{AT_Inc }:="9;Control trimestre [Indicadores];"+"atSRal_SubEvalEXP_Indicadores;2"  // nuevo
asSRVariables{AT_Inc }:="9;Promedio trimestre  [Indicadores];"+"atSRal_SubEvalPeriodo_Indicador;2"
asSRVariables{AT_Inc }:="9;Promedio trimestre 1 [Indicadores];"+"atSRal_SubEvalP1_Indicadores;2"
asSRVariables{AT_Inc }:="9;Promedio trimestre 2 [Indicadores];"+"atSRal_SubEvalP2_Indicadores;2"
asSRVariables{AT_Inc }:="9;Promedio trimestre 3 [Indicadores];"+"atSRal_SubEvalP3_Indicadores;2"
asSRVariables{AT_Inc }:="9;Promedio Final [Indicadores];"+"atSRal_SubEvalPF_Indicadores;2"
asSRVariables{AT_Inc }:="9;Examen [Indicadores];"+";atSRal_SubEvalEX_Indicadores2"
asSRVariables{AT_Inc }:="9;Nota final [Indicadores];"+"atSRal_SubEvalF_Simbolos;2"


  // OBSERVACIONES Y COMENTARIOS
asSRVariables{AT_Inc }:="10;Observaciones [Subsectores]"
asSRVariables{AT_Inc }:="10;Observaciones del trimestre;vs_ObservacionesPeriodo;1"
asSRVariables{AT_Inc }:="10;Observaciones trimestre 1;vs_Observaciones1;1"
asSRVariables{AT_Inc }:="10;Observaciones trimestre 2;vs_Observaciones2;1"
asSRVariables{AT_Inc }:="10;Observaciones trimestre 3;vs_Observaciones3;1"
asSRVariables{AT_Inc }:="10;Observaciones finales;vs_ObservacionesF;1"

asSRVariables{AT_Inc }:="11;Observaciones [Generales]"
asSRVariables{AT_Inc }:="11;Observaciones del trimestre;vs_ObservacionesPeriodoG;1"
asSRVariables{AT_Inc }:="11;Observaciones trimestre 1;vs_Observaciones1G;1"
asSRVariables{AT_Inc }:="11;Observaciones trimestre 2;vs_Observaciones2G;1"
asSRVariables{AT_Inc }:="11;Observaciones trimestre 3;vs_Observaciones3G;1"

  //ASISTENCIA
asSRVariables{AT_Inc }:="12;Asistencia [trimestre]"
asSRVariables{AT_Inc }:="12;Inasistencias diarias;viSRal_InasistenciasPeriodo;1"
asSRVariables{AT_Inc }:="12;Días trimestre;viSRal_DiasPeriodo;1"
asSRVariables{AT_Inc }:="12;Horas de Inasistencias;viSRal_HorasInasistPeriodo;1"
asSRVariables{AT_Inc }:="12;Horas de Inasistencias Justificadas;viSRal_HorasInasistPeriodoJ;1"
asSRVariables{AT_Inc }:="12;Horas efectivas en el trimestre;viSRal_HorasPeriodo;1"
asSRVariables{AT_Inc }:="12;% de asistencia;vrSRal_PctAsistenciaPeriodo;1"

asSRVariables{AT_Inc }:="13;Asistencia [Acumulado]"
asSRVariables{AT_Inc }:="13;Inasistencias diarias;viSRal_InasistenciasTotal;1"
asSRVariables{AT_Inc }:="13;Días a la fecha;viSRal_DiasTotal;1"
asSRVariables{AT_Inc }:="13;Horas de Inasistencias;viSRal_HorasInasistTotal;1"
asSRVariables{AT_Inc }:="13;Horas de Inasistencias Justificadas;viSRal_HorasInasistTotalJ;1"
asSRVariables{AT_Inc }:="13;Horas efectivas a la fecha;viSRal_HorasTotal;1"
asSRVariables{AT_Inc }:="13;% de asistencia;vrSRal_PctAsistenciaTotal;1"

  //CONDUCTA
asSRVariables{AT_Inc }:="14;Conducta [trimestre]"
asSRVariables{AT_Inc }:="14;Atrasos;viSRal_AtrasosPeriodo;1"
asSRVariables{AT_Inc }:="14;Atrasos Jornada;viSRal_AtrasosPeriodoJornada;1"
asSRVariables{AT_Inc }:="14;Atrasos Sesiones;viSRal_AtrasosPeriodoSesiones;1"
asSRVariables{AT_Inc }:="14;Minutos de retardo acumulados;viSRal_MinutosAtrasosPeriodo;1"
asSRVariables{AT_Inc }:="14;Horas de faltas por retardos;viSRal_FaltasHoras_Periodo;1"
asSRVariables{AT_Inc }:="14;Días de faltas por retardos;viSRal_FaltasDias_Periodo;1"
asSRVariables{AT_Inc }:="14;Anotaciones positivas;viSRal_AntPositivasPeriodo;1"
asSRVariables{AT_Inc }:="14;Anotaciones negativas;viSRal_AntNegativasPeriodo;1"
asSRVariables{AT_Inc }:="14;Castigos;viSRal_CastigosPeriodo;1"
asSRVariables{AT_Inc }:="14;Suspensiones;viSRal_SuspensionesPeriodo;1"

asSRVariables{AT_Inc }:="15;Conducta [Acumulado]"
asSRVariables{AT_Inc }:="15;Atrasos;viSRal_AtrasosTotal;1"
asSRVariables{AT_Inc }:="15;Atrasos Jornada;viSRal_AtrasosTotalJornada;1"
asSRVariables{AT_Inc }:="15;Atrasos Sesiones;viSRal_AtrasosTotalSesiones;1"
asSRVariables{AT_Inc }:="15;Total minutos de retardo acumulados;viSRal_MinutosAtrasosTotal;1"
asSRVariables{AT_Inc }:="15;Total Horas de faltas por retardos;viSRal_FaltasAtraso_Horas;1"
asSRVariables{AT_Inc }:="15;Total Días de faltas por retardos;viSRal_FaltasAtraso_Dias;1"
asSRVariables{AT_Inc }:="15;Anotaciones positivas;viSRal_AntPositivasTotal;"
asSRVariables{AT_Inc }:="15;Anotaciones negativas;viSRal_AntNegativasTotal;1"
asSRVariables{AT_Inc }:="15;Castigos;viSRal_CastigosTotal;1"
asSRVariables{AT_Inc }:="15;Suspensiones;viSRal_SuspensionesTotal;1"


asSRVariables{AT_Inc }:="16;Promedios generales"
asSRVariables{AT_Inc }:="16;Promedio del trimestre;vs_PromedioG_Periodo;1"
asSRVariables{AT_Inc }:="16;Promedio trimestre 1;vs_PromedioG_Periodo1;1"
asSRVariables{AT_Inc }:="16;Promedio trimestre 2;vs_PromedioG_Periodo2;1"
asSRVariables{AT_Inc }:="16;Promedio trimestre 3;vs_PromedioG_Periodo3;1"
asSRVariables{AT_Inc }:="16;Promedio Anual, antes de examenes;vs_PromedioG_Final;1"
asSRVariables{AT_Inc }:="16;Promedio General Interno;vs_NotaFinalG;1"
asSRVariables{AT_Inc }:="16;Promedio General Oficial;vs_NotaFinalOficialG;1"

  //OBJETIVOS SUBSECTOR
asSRVariables{AT_Inc }:="17;Objetivos [Subsector]"
asSRVariables{AT_Inc }:="17;Objetivos del Trimestre;vt_Objetivos_P;1"
asSRVariables{AT_Inc }:="17;Objetivo Trimestre 1;vt_Objetivos_P1;1"
asSRVariables{AT_Inc }:="17;Objetivo Trimestre 2;vt_Objetivos_P2;1"
asSRVariables{AT_Inc }:="17;Objetivo Trimestre 3;vt_Objetivos_P3;1"

  // ESFUERZOS
asSRVariables{AT_Inc }:="18;Esfuerzo [Subsector]"
asSRVariables{AT_Inc }:="18;Esfuerzo del Trimestre;vt_Esfuerzo_P;1"
asSRVariables{AT_Inc }:="18;Esfuerzo Trimestre 1;vt_Esfuerzo_P1;1"
asSRVariables{AT_Inc }:="18;Esfuerzo Trimestre 2;vt_Esfuerzo_P2;1"
asSRVariables{AT_Inc }:="18;Esfuerzo Trimestre 3;vt_Esfuerzo_P3;1"


  //EVALUACION DE APRENDIZAJES
asSRVariables{AT_Inc }:="19;Evaluación de aprendizajes"
asSRVariables{AT_Inc }:="19;Enunciado;vt_EVAPR_Enunciado"
asSRVariables{AT_Inc }:="19;Evaluación del Período;vt_EVAPR_Periodo"
asSRVariables{AT_Inc }:="19;Evaluación del Período 1;vt_EVAPR_P1"
asSRVariables{AT_Inc }:="19;Evaluación del Período 2;vt_EVAPR_P2"
asSRVariables{AT_Inc }:="19;Evaluación del Período 3;vt_EVAPR_P3"
asSRVariables{AT_Inc }:="19;Máximo;vt_EVAPR_Maximo"
asSRVariables{AT_Inc }:="19;Indicador del período;vt_EVAPR_Indicador_Periodo"
asSRVariables{AT_Inc }:="19;Indicador del Período 1;vt_EVAPR_Indicador_P1"
asSRVariables{AT_Inc }:="19;Indicador del Período 2;vt_EVAPR_Indicador_P2"
asSRVariables{AT_Inc }:="19;Indicador del Período 3;vt_EVAPR_Indicador_P3"


  // Postulacion Universidades Chilenas
If (<>vtXS_CountryCode="cl")
	asSRVariables{AT_Inc }:="20;Postulacion a Universidades [solo 4˚ Medio]"
	asSRVariables{AT_Inc }:="20;Suma Notas Enseñanza Media;vr_SumaEM;1"
	asSRVariables{AT_Inc }:="20;Total Notas Enseñanza Media;vr_DivisorEM;1"
	asSRVariables{AT_Inc }:="20;Promedio Enseñanza Media;vr_PromedioEMedia;1"
	asSRVariables{AT_Inc }:="20;Puntaje Postulacion Universidades;vi_PuntajeEM;1"
End if 