//%attributes = {}
  //SRal_FinEnfermeriaMeses

  //Comunes
ARRAY POINTER:C280($aPtrs;0)

  //informe 1
C_LONGINT:C283(vTot1;vTot2;vTot3;vTot4;$TotalPeriodo)
ARRAY TEXT:C222(aENF_MesesP1;0)
ARRAY TEXT:C222(aENF_MesesP2;0)
ARRAY TEXT:C222(aENF_MesesP3;0)
ARRAY TEXT:C222(aENF_MesesP4;0)
ARRAY LONGINT:C221(aENF_CantidadesP1;0)
ARRAY LONGINT:C221(aENF_CantidadesP2;0)
ARRAY LONGINT:C221(aENF_CantidadesP3;0)
ARRAY LONGINT:C221(aENF_CantidadesP4;0)
ARRAY REAL:C219(aENF_PorcentajesP1;0)
ARRAY REAL:C219(aENF_PorcentajesP2;0)
ARRAY REAL:C219(aENF_PorcentajesP3;0)
ARRAY REAL:C219(aENF_PorcentajesP4;0)
ARRAY DATE:C224(aFechas;0)
ARRAY LONGINT:C221(aMes;0)
vTot1:=0
vTot2:=0
vTot3:=0
vTot4:=0

  //informe 2
C_LONGINT:C283(vTot5)
ARRAY LONGINT:C221(aCantidadXSeccion;0)
ARRAY REAL:C219(aPorcentajesXSeccion;0)
ARRAY LONGINT:C221(aVisitasAlumnosID;0)
vTot5:=0

  //informe 3
ARRAY LONGINT:C221(aLunes;0)
ARRAY LONGINT:C221(aMartes;0)
ARRAY LONGINT:C221(aMiercoles;0)
ARRAY LONGINT:C221(aJueves;0)
ARRAY LONGINT:C221(aViernes;0)
ARRAY LONGINT:C221(aVisitasAlumnosID;0)

  //informe 4
ARRAY LONGINT:C221(aMedica;0)
ARRAY LONGINT:C221(aDental;0)
ARRAY LONGINT:C221(aTraumatologica;0)

  //informe 5
ARRAY TEXT:C222(aDesdeStr;0)
ARRAY TEXT:C222(aHastaStr;0)
ARRAY LONGINT:C221(aDesde;0)
ARRAY LONGINT:C221(aHasta;0)
ARRAY LONGINT:C221(aHora1;0)
ARRAY LONGINT:C221(aHora2;0)
ARRAY LONGINT:C221(aHora3;0)
ARRAY LONGINT:C221(aHora4;0)
ARRAY LONGINT:C221(aHora5;0)
ARRAY LONGINT:C221(aHora6;0)
ARRAY LONGINT:C221(aHora7;0)
ARRAY LONGINT:C221(aHora8;0)
ARRAY LONGINT:C221(aHora9;0)
ARRAY LONGINT:C221(aHora10;0)
ARRAY LONGINT:C221(aHora11;0)
ARRAY LONGINT:C221(aHora12;0)
ARRAY LONGINT:C221(aHora13;0)
ARRAY LONGINT:C221(aHora14;0)
ARRAY LONGINT:C221(aHora15;0)
ARRAY LONGINT:C221(aHora16;0)
ARRAY LONGINT:C221(aHora17;0)
ARRAY LONGINT:C221(aHora18;0)
ARRAY LONGINT:C221(aHora19;0)
ARRAY LONGINT:C221(aHora20;0)

  //informe 6
ARRAY LONGINT:C221(aProcedencia1;0)
ARRAY LONGINT:C221(aProcedencia2;0)
ARRAY LONGINT:C221(aProcedencia3;0)
ARRAY LONGINT:C221(aProcedencia4;0)
ARRAY LONGINT:C221(aProcedencia5;0)
ARRAY LONGINT:C221(aProcedencia6;0)
ARRAY LONGINT:C221(aProcedencia7;0)
ARRAY LONGINT:C221(aProcedencia8;0)
ARRAY LONGINT:C221(aProcedencia9;0)
ARRAY LONGINT:C221(aProcedencia10;0)
ARRAY LONGINT:C221(aProcedencia11;0)
ARRAY LONGINT:C221(aProcedencia12;0)
ARRAY LONGINT:C221(aProcedencia13;0)
ARRAY LONGINT:C221(aProcedencia14;0)
ARRAY LONGINT:C221(aProcedencia15;0)
ARRAY LONGINT:C221(aProcedencia16;0)
ARRAY LONGINT:C221(aProcedencia17;0)
ARRAY LONGINT:C221(aProcedencia18;0)
ARRAY LONGINT:C221(aProcedencia19;0)
ARRAY LONGINT:C221(aProcedencia20;0)
ARRAY LONGINT:C221(aProcedencia21;0)
ARRAY LONGINT:C221(aProcedencia22;0)
ARRAY LONGINT:C221(aProcedencia23;0)
ARRAY LONGINT:C221(aProcedencia24;0)
ARRAY LONGINT:C221(aProcedencia25;0)
ARRAY LONGINT:C221(aProcedencia26;0)
ARRAY LONGINT:C221(aProcedencia27;0)
ARRAY LONGINT:C221(aProcedencia28;0)
ARRAY LONGINT:C221(aProcedencia29;0)
ARRAY LONGINT:C221(aProcedencia30;0)
ARRAY LONGINT:C221(aProcedencia31;0)
ARRAY LONGINT:C221(aProcedencia32;0)


  //informe 7
ARRAY LONGINT:C221(aDestino1;0)
ARRAY LONGINT:C221(aDestino2;0)
ARRAY LONGINT:C221(aDestino3;0)
ARRAY LONGINT:C221(aDestino4;0)
ARRAY LONGINT:C221(aDestino5;0)
ARRAY LONGINT:C221(aDestino6;0)
ARRAY LONGINT:C221(aDestino7;0)
ARRAY LONGINT:C221(aDestino8;0)
ARRAY LONGINT:C221(aDestino9;0)
ARRAY LONGINT:C221(aDestino10;0)
ARRAY LONGINT:C221(aDestino11;0)
ARRAY LONGINT:C221(aDestino12;0)
ARRAY LONGINT:C221(aDestino13;0)
ARRAY LONGINT:C221(aDestino14;0)
ARRAY LONGINT:C221(aDestino15;0)
ARRAY LONGINT:C221(aDestino16;0)
ARRAY LONGINT:C221(aDestino17;0)
ARRAY LONGINT:C221(aDestino18;0)
ARRAY LONGINT:C221(aDestino19;0)
ARRAY LONGINT:C221(aDestino20;0)
ARRAY LONGINT:C221(aDestino21;0)
ARRAY LONGINT:C221(aDestino22;0)
ARRAY LONGINT:C221(aDestino23;0)
ARRAY LONGINT:C221(aDestino24;0)
ARRAY LONGINT:C221(aDestino25;0)
ARRAY LONGINT:C221(aDestino26;0)
ARRAY LONGINT:C221(aDestino27;0)
ARRAY LONGINT:C221(aDestino28;0)
ARRAY LONGINT:C221(aDestino29;0)
ARRAY LONGINT:C221(aDestino30;0)
ARRAY LONGINT:C221(aDestino31;0)
ARRAY LONGINT:C221(aDestino32;0)