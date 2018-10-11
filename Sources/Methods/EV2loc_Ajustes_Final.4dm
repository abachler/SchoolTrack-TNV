//%attributes = {}
  // MÉTODO: EV2loc_Ajustes_Final
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 02/04/11, 20:45:36
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // EV2loc_Ajustes_Anual()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES



  // CODIGO PRINCIPAL


  //ajustes especiales país
  //20120615 ASM. Se comenta el codigo por problema en calculo de promedios ticket 111498
  //Case of 
  //: (<>vtXS_CountryCode="mx")
  //If (([Alumnos_Calificaciones]EvaluacionFinal_Real<50) & ([Alumnos_Calificaciones]EvaluacionFinal_Real>=vrNTA_MinimoEscalaReferencia))
  //[Alumnos_Calificaciones]EvaluacionFinal_Real:=50
  //[Alumnos_Calificaciones]EvaluacionFinal_Nota:=EV2_Real_a_Nota ([Alumnos_Calificaciones]EvaluacionFinal_Real;vi_gTroncarNotaFinal;iGradesDecNF)
  //[Alumnos_Calificaciones]EvaluacionFinal_Puntos:=EV2_Real_a_Puntos ([Alumnos_Calificaciones]EvaluacionFinal_Real;vi_gTroncarNotaFinal;iPointsDecNF)
  //[Alumnos_Calificaciones]EvaluacionFinal_Simbolo:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones]EvaluacionFinal_Real;Simbolos)
  //[Alumnos_Calificaciones]EvaluacionFinal_Literal:=EV2_Real_a_Literal ([Alumnos_Calificaciones]EvaluacionFinal_Real;iPrintMode;vlNTA_DecimalesNF)
  //End if 
  //End case 
