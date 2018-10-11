//%attributes = {}
  // MÉTODO: EV2loc_Ajustes_Anual
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 02/04/11, 20:48:08
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
  //If (([Alumnos_Calificaciones]Anual_Real<50) & ([Alumnos_Calificaciones]Anual_Real>=vrNTA_MinimoEscalaReferencia))
  //[Alumnos_Calificaciones]Anual_Real:=50
  //[Alumnos_Calificaciones]Anual_Nota:=EV2_Real_a_Nota ([Alumnos_Calificaciones]Anual_Real;vi_gTrFAvg;iGradesDecPF)
  //[Alumnos_Calificaciones]Anual_Puntos:=EV2_Real_a_Puntos ([Alumnos_Calificaciones]Anual_Real;vi_gTrFAvg;iPointsDecPF)
  //[Alumnos_Calificaciones]Anual_Simbolo:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones]Anual_Real;Simbolos)
  //[Alumnos_Calificaciones]Anual_Literal:=EV2_Real_a_Literal ([Alumnos_Calificaciones]Anual_Real;iPrintMode;vlNTA_DecimalesPF)
  //End if 
  //End case 

