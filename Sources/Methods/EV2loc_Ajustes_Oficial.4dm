//%attributes = {}
  // MÉTODO: EV2loc_Ajustes_Oficial
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 02/04/11, 20:49:22
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // EV2loc_Ajustes_Oficial()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES



  // CODIGO PRINCIPAL
  //ajustes especiales país
  //20120615 ASM. Se comenta el codigo por problema en calculo de promedios ticket 111498
  //Case of 
  //: (<>vtXS_CountryCode="mx")
  //If (([Alumnos_Calificaciones]EvaluacionFinalOficial_Real<50) & ([Alumnos_Calificaciones]Anual_Real>=vrNTA_MinimoEscalaReferencia))
  //[Alumnos_Calificaciones]EvaluacionFinalOficial_Real:=50
  //[Alumnos_Calificaciones]EvaluacionFinalOficial_Nota:=EV2_Real_a_Nota ([Alumnos_Calificaciones]EvaluacionFinalOficial_Real;vi_gTroncarNotaFinal;iGradesDecNO)
  //[Alumnos_Calificaciones]EvaluacionFinalOficial_Puntos:=EV2_Real_a_Puntos ([Alumnos_Calificaciones]EvaluacionFinalOficial_Real;vi_gTroncarNotaFinal;iPointsDecNO)
  //[Alumnos_Calificaciones]EvaluacionFinalOficial_Simbolo:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones]EvaluacionFinalOficial_Real;Simbolos)
  //[Alumnos_Calificaciones]EvaluacionFinalOficial_Literal:=EV2_Real_a_Literal ([Alumnos_Calificaciones]EvaluacionFinalOficial_Real;iPrintMode;vlNTA_DecimalesNO)
  //End if 
  //End case 
