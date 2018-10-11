//%attributes = {}
  //EV2_InitArrays

If (Count parameters:C259=1)
	$size:=$1
Else 
	$size:=0
End if 

ARRAY LONGINT:C221(aNtaRecNum;$size)
ARRAY TEXT:C222(at_KeyEvaluacionPrincipal;$size)
ARRAY TEXT:C222(at_KeyEvaluacionesPeriodicas;$size)
ARRAY INTEGER:C220(aNtaRegEximicion;$size)

ARRAY BOOLEAN:C223(aNtaReprobada;$size)
ARRAY INTEGER:C220(aNtaOrden;$size)  //21/02/97, para orden por numero
_O_ARRAY STRING:C218(5;aNta1;$size)
_O_ARRAY STRING:C218(5;aNta2;$size)
_O_ARRAY STRING:C218(5;aNta3;$size)
_O_ARRAY STRING:C218(5;aNta4;$size)
_O_ARRAY STRING:C218(5;aNta5;$size)
_O_ARRAY STRING:C218(5;aNta6;$size)
_O_ARRAY STRING:C218(5;aNta7;$size)
_O_ARRAY STRING:C218(5;aNta8;$size)
_O_ARRAY STRING:C218(5;aNta9;$size)
_O_ARRAY STRING:C218(5;aNta10;$size)
_O_ARRAY STRING:C218(5;aNta11;$size)
_O_ARRAY STRING:C218(5;aNta12;$size)
  //20/11/96
  //Nuevo codigo para gestion de examenes periódcos
_O_ARRAY STRING:C218(5;aNtaEXP;$size)
_O_ARRAY STRING:C218(5;aNtaEXP1;$size)
_O_ARRAY STRING:C218(5;aNtaEXP2;$size)
_O_ARRAY STRING:C218(5;aNtaEXP3;$size)
_O_ARRAY STRING:C218(5;aNtaEXP4;$size)
_O_ARRAY STRING:C218(5;aNtaEXP5;$size)


ARRAY TEXT:C222(aNtaBX;$size)  //20160622 - ABK: bonificacionesExtraAcademicas

  //=================
_O_ARRAY STRING:C218(5;aNtaP1;$size)
_O_ARRAY STRING:C218(5;aNtaP2;$size)
_O_ARRAY STRING:C218(5;aNtaP3;$size)
_O_ARRAY STRING:C218(5;aNtaP4;$size)
_O_ARRAY STRING:C218(5;aNtaP5;$size)
_O_ARRAY STRING:C218(5;aNtaPF;$size)
_O_ARRAY STRING:C218(5;aNtaEX;$size)
_O_ARRAY STRING:C218(5;aNtaEXX;$size)
_O_ARRAY STRING:C218(5;aNtaF;$size)
_O_ARRAY STRING:C218(5;aNtaOf;$size)
_O_ARRAY STRING:C218(5;aNtaPTC_Literal;$size)  // MOD Ticket N° 213167 Patrico Aliaga 20180806
_O_ARRAY STRING:C218(5;aNtaPrevYear;$size)
_O_ARRAY STRING:C218(5;aNtaPresentP;$size)

_O_ARRAY STRING:C218(5;aNtaEsfuerzo;$size)  //Arreglo para contener evaluacion de esfuerzo (JHB, 29/7/2004)
ARRAY REAL:C219(aRealNtaEsfuerzo;$size)

ARRAY TEXT:C222(aNtaStdNme;$size)
ARRAY TEXT:C222(aNtaAsignatura;$size)
ARRAY TEXT:C222(aNtaCurso;$size)
ARRAY REAL:C219(aNtaAsgAvg;$size)
ARRAY TEXT:C222(aNtaStatus;$size)
ARRAY LONGINT:C221(aNtaIDAlumno;$size)
_O_ARRAY STRING:C218(5;aNtaCopyCol;$size)
ARRAY REAL:C219(aRealNtaCopyCol;$size)
_O_ARRAY STRING:C218(5;aStrAsgAverage;$size)
ARRAY BOOLEAN:C223(ab_AsgOficial;$size)

ARRAY REAL:C219(aRealNta1;$size)
ARRAY REAL:C219(aRealNta2;$size)
ARRAY REAL:C219(aRealNta3;$size)
ARRAY REAL:C219(aRealNta4;$size)
ARRAY REAL:C219(aRealNta5;$size)
ARRAY REAL:C219(aRealNta6;$size)
ARRAY REAL:C219(aRealNta7;$size)
ARRAY REAL:C219(aRealNta8;$size)
ARRAY REAL:C219(aRealNta9;$size)
ARRAY REAL:C219(aRealNta10;$size)
ARRAY REAL:C219(aRealNta11;$size)
ARRAY REAL:C219(aRealNta12;$size)
ARRAY REAL:C219(aRealNtaEXP;$size)
ARRAY REAL:C219(aRealNtaBX;$size)  //20160622 - ABK: bonificacionesExtraAcademicas
ARRAY REAL:C219(aRealNtaP1;$size)
ARRAY REAL:C219(aRealNtaP2;$size)
ARRAY REAL:C219(aRealNtaP3;$size)
ARRAY REAL:C219(aRealNtaP4;$size)
ARRAY REAL:C219(aRealNtaP5;$size)
ARRAY REAL:C219(aRealNtaPF;$size)
ARRAY REAL:C219(aRealNtaEX;$size)
ARRAY REAL:C219(aRealNtaEXX;$size)
ARRAY REAL:C219(aRealNtaF;$size)
ARRAY REAL:C219(aRealNtaOficial;$size)
ARRAY REAL:C219(aNtaPTC_Real;$size)  // MOD Ticket N° 213167 Patrico Aliaga 20180806
ARRAY REAL:C219(aRealAsgAverage;$size)
ARRAY REAL:C219(aRealNtaPresentP;$size)
ARRAY REAL:C219(aRealNtaBonus;$size)

ARRAY REAL:C219(aRealStats1;$size)
ARRAY REAL:C219(aRealStats2;$size)
ARRAY REAL:C219(aRealStats3;$size)
ARRAY REAL:C219(aRealStats4;$size)
ARRAY REAL:C219(aRealStats5;$size)
ARRAY REAL:C219(aRealStats6;$size)
ARRAY REAL:C219(aRealStats7;$size)
ARRAY REAL:C219(aRealStats8;$size)
ARRAY REAL:C219(aRealStats9;$size)
ARRAY REAL:C219(aRealStats10;$size)
ARRAY REAL:C219(aRealStats11;$size)
ARRAY REAL:C219(aRealStats12;$size)
ARRAY REAL:C219(aRealStatsBX;$size)  // 20160131 - PAR: Se agrega posicion de Bonificaciones para contener estadisticas
ARRAY REAL:C219(aRealStatsEXP;$size)
ARRAY REAL:C219(aRealStatsNtaBX;$size)  //20160622 - ABK: bonificacionesExtraAcademicas
ARRAY REAL:C219(aRealStatsP1;$size)
ARRAY REAL:C219(aRealStatsP2;$size)
ARRAY REAL:C219(aRealStatsP3;$size)
ARRAY REAL:C219(aRealStatsP4;$size)
ARRAY REAL:C219(aRealStatsP5;$size)
ARRAY REAL:C219(aRealStatsPF;$size)
ARRAY REAL:C219(aRealStatsEX;$size)
ARRAY REAL:C219(aRealStatsEXX;$size)
ARRAY REAL:C219(aRealStatsF;$size)

C_BLOB:C604(vx_Grades)
ARRAY POINTER:C280(aNtaStrArrPointers;0)
ARRAY POINTER:C280(aNtaStrArrPointers;27)
aNtaStrArrPointers{1}:=->aNta1
aNtaStrArrPointers{2}:=->aNta2
aNtaStrArrPointers{3}:=->aNta3
aNtaStrArrPointers{4}:=->aNta4
aNtaStrArrPointers{5}:=->aNta5
aNtaStrArrPointers{6}:=->aNta6
aNtaStrArrPointers{7}:=->aNta7
aNtaStrArrPointers{8}:=->aNta8
aNtaStrArrPointers{9}:=->aNta9
aNtaStrArrPointers{10}:=->aNta10
aNtaStrArrPointers{11}:=->aNta11
aNtaStrArrPointers{12}:=->aNta12
aNtaStrArrPointers{13}:=->aNtaBX  //20160622 - ABK: bonificacionesExtraAcademicas
aNtaStrArrPointers{14}:=->aNtaEXP
aNtaStrArrPointers{15}:=->aNtaP1
aNtaStrArrPointers{16}:=->aNtaP2
aNtaStrArrPointers{17}:=->aNtaP3
aNtaStrArrPointers{18}:=->aNtaP4
aNtaStrArrPointers{19}:=->aNtaP5
aNtaStrArrPointers{20}:=->aNtaPF
aNtaStrArrPointers{21}:=->aNtaEX
aNtaStrArrPointers{22}:=->aNtaEXX
aNtaStrArrPointers{23}:=->aNtaF
aNtaStrArrPointers{24}:=->aStrAsgAverage
aNtaStrArrPointers{25}:=->aNtaPresentP
aNtaStrArrPointers{26}:=->aNtaOf
aNtaStrArrPointers{27}:=->aNtaPTC_Literal



ARRAY POINTER:C280(aNtaRealArrPointers;0)
ARRAY POINTER:C280(aNtaRealArrPointers;27)
aNtaRealArrPointers{1}:=->aRealNta1
aNtaRealArrPointers{2}:=->aRealNta2
aNtaRealArrPointers{3}:=->aRealNta3
aNtaRealArrPointers{4}:=->aRealNta4
aNtaRealArrPointers{5}:=->aRealNta5
aNtaRealArrPointers{6}:=->aRealNta6
aNtaRealArrPointers{7}:=->aRealNta7
aNtaRealArrPointers{8}:=->aRealNta8
aNtaRealArrPointers{9}:=->aRealNta9
aNtaRealArrPointers{10}:=->aRealNta10
aNtaRealArrPointers{11}:=->aRealNta11
aNtaRealArrPointers{12}:=->aRealNta12
aNtaRealArrPointers{13}:=->aRealNtaBX  //20160622 - ABK: bonificacionesExtraAcademicas
aNtaRealArrPointers{14}:=->aRealNtaEXP
aNtaRealArrPointers{15}:=->aRealNtaP1
aNtaRealArrPointers{16}:=->aRealNtaP2
aNtaRealArrPointers{17}:=->aRealNtaP3
aNtaRealArrPointers{18}:=->aRealNtaP4
aNtaRealArrPointers{19}:=->aRealNtaP5
aNtaRealArrPointers{20}:=->aRealNtaPF
aNtaRealArrPointers{21}:=->aRealNtaEX
aNtaRealArrPointers{22}:=->aRealNtaEXX
aNtaRealArrPointers{23}:=->aRealNtaF
aNtaRealArrPointers{24}:=->aRealAsgAverage
aNtaRealArrPointers{25}:=->aRealNtaPresentP
aNtaRealArrPointers{26}:=->aRealNtaOficial
aNtaRealArrPointers{27}:=->aNtaPTC_Real


ARRAY POINTER:C280(aStatsRealArrPointers;0)
ARRAY POINTER:C280(aStatsRealArrPointers;23)
aStatsRealArrPointers{1}:=->aRealStats1
aStatsRealArrPointers{2}:=->aRealStats2
aStatsRealArrPointers{3}:=->aRealStats3
aStatsRealArrPointers{4}:=->aRealStats4
aStatsRealArrPointers{5}:=->aRealStats5
aStatsRealArrPointers{6}:=->aRealStats6
aStatsRealArrPointers{7}:=->aRealStats7
aStatsRealArrPointers{8}:=->aRealStats8
aStatsRealArrPointers{9}:=->aRealStats9
aStatsRealArrPointers{10}:=->aRealStats10
aStatsRealArrPointers{11}:=->aRealStats11
aStatsRealArrPointers{12}:=->aRealStats12
aStatsRealArrPointers{13}:=->aRealStatsBX  // 20160131 - PAR: Se agrega posicion de Bonificaciones para contener estadisticas
aStatsRealArrPointers{14}:=->aRealStatsEXP
aStatsRealArrPointers{15}:=->aRealStatsP1
aStatsRealArrPointers{16}:=->aRealStatsP2
aStatsRealArrPointers{17}:=->aRealStatsP3
aStatsRealArrPointers{18}:=->aRealStatsP4
aStatsRealArrPointers{19}:=->aRealStatsP5
aStatsRealArrPointers{20}:=->aRealStatsPF
aStatsRealArrPointers{21}:=->aRealStatsEX
aStatsRealArrPointers{22}:=->aRealStatsEXX
aStatsRealArrPointers{23}:=->aRealStatsF



ARRAY TEXT:C222(aNtaArrNames;0)
ARRAY TEXT:C222(aNtaArrNames;27)
aNtaArrNames{1}:="aNta1"
aNtaArrNames{2}:="aNta2"
aNtaArrNames{3}:="aNta3"
aNtaArrNames{4}:="aNta4"
aNtaArrNames{5}:="aNta5"
aNtaArrNames{6}:="aNta6"
aNtaArrNames{7}:="aNta7"
aNtaArrNames{8}:="aNta8"
aNtaArrNames{9}:="aNta9"
aNtaArrNames{10}:="aNta10"
aNtaArrNames{11}:="aNta11"
aNtaArrNames{12}:="aNta12"
aNtaArrNames{13}:="aNtaBX"  //20160622 - ABK: bonificacionesExtraAcademicas
aNtaArrNames{14}:="aNtaEXP"
aNtaArrNames{15}:="aNtaP1"
aNtaArrNames{16}:="aNtaP2"
aNtaArrNames{17}:="aNtaP3"
aNtaArrNames{18}:="aNtaP4"
aNtaArrNames{19}:="aNtaP5"
aNtaArrNames{20}:="aNtaPF"
aNtaArrNames{21}:="aNtaEX"
aNtaArrNames{22}:="aNtaEXX"
aNtaArrNames{23}:="aNtaF"
aNtaArrNames{24}:="aStrAsgAverage"
aNtaArrNames{25}:="aNtaPresentP"
aNtaArrNames{26}:="aNtaOF"
aNtaArrNames{27}:="aNtaPTC_Literal"

ARRAY POINTER:C280(aNtaFldPtr;12)

ARRAY LONGINT:C221(aCpyIDAlumno;0)
_O_ARRAY STRING:C218(5;aCpyNta1;$size)
_O_ARRAY STRING:C218(5;aCpyNta2;$size)
_O_ARRAY STRING:C218(5;aCpyNta3;$size)
_O_ARRAY STRING:C218(5;aCpyNta4;$size)
_O_ARRAY STRING:C218(5;aCpyNta5;$size)
_O_ARRAY STRING:C218(5;aCpyNta6;$size)
_O_ARRAY STRING:C218(5;aCpyNta7;$size)
_O_ARRAY STRING:C218(5;aCpyNta8;$size)
_O_ARRAY STRING:C218(5;aCpyNta9;$size)
_O_ARRAY STRING:C218(5;aCpyNta10;$size)
_O_ARRAY STRING:C218(5;aCpyNta11;$size)
_O_ARRAY STRING:C218(5;aCpyNta12;$size)
_O_ARRAY STRING:C218(5;aCpyNtaBX;$size)  //20160622 - ABK: bonificacionesExtraAcademicas
_O_ARRAY STRING:C218(5;aCpyNtaEXP;$size)
_O_ARRAY STRING:C218(5;aCpyNtaP1;$size)
_O_ARRAY STRING:C218(5;aCpyNtaP2;$size)
_O_ARRAY STRING:C218(5;aCpyNtaP3;$size)
_O_ARRAY STRING:C218(5;aCpyNtaP4;$size)
_O_ARRAY STRING:C218(5;aCpyNtaP5;$size)
_O_ARRAY STRING:C218(5;aCpyNtaPF;$size)
_O_ARRAY STRING:C218(5;aCpyNtaEX;$size)
_O_ARRAY STRING:C218(5;aCpyNtaF;$size)
_O_ARRAY STRING:C218(5;aCpyNtaEXX;$size)
_O_ARRAY STRING:C218(5;aCpyNtaEsfuerzo;$size)

ARRAY POINTER:C280(aCpyNtaPtr;0)
ARRAY POINTER:C280(aCpyNtaPtr;24)
aCpyNtaPtr{1}:=->aCpyNta1
aCpyNtaPtr{2}:=->aCpyNta2
aCpyNtaPtr{3}:=->aCpyNta3
aCpyNtaPtr{4}:=->aCpyNta4
aCpyNtaPtr{5}:=->aCpyNta5
aCpyNtaPtr{6}:=->aCpyNta6
aCpyNtaPtr{7}:=->aCpyNta7
aCpyNtaPtr{8}:=->aCpyNta8
aCpyNtaPtr{9}:=->aCpyNta9
aCpyNtaPtr{10}:=->aCpyNta10
aCpyNtaPtr{11}:=->aCpyNta11
aCpyNtaPtr{12}:=->aCpyNta12
aCpyNtaPtr{13}:=->aCpyNtaBX  //20160622 - ABK: bonificacionesExtraAcademicas
aCpyNtaPtr{14}:=->aCpyNtaEXP
aCpyNtaPtr{15}:=->aCpyNtaP1
aCpyNtaPtr{16}:=->aCpyNtaP2
aCpyNtaPtr{17}:=->aCpyNtaP3
aCpyNtaPtr{18}:=->aCpyNtaP4
aCpyNtaPtr{19}:=->aCpyNtaP5
aCpyNtaPtr{20}:=->aCpyNtaPF
aCpyNtaPtr{21}:=->aCpyNtaEX
aCpyNtaPtr{22}:=->aCpyNtaF
aCpyNtaPtr{23}:=->aCpyNtaEXX
aCpyNtaPtr{24}:=->aCpyNtaEsfuerzo


ARRAY TEXT:C222(aNtaSubjectName;$size)
ARRAY TEXT:C222(aNtaInternalName;$size)
ARRAY TEXT:C222(aNtaSector;$size)

ARRAY TEXT:C222(aNtaObs_Periodo;$size)
ARRAY TEXT:C222(aNtaObs_Final;$size)


ARRAY REAL:C219(aRealNtaBonus;$size)
ARRAY BOOLEAN:C223(aBoolCondicional;0)