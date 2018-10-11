//%attributes = {}
  //SRcu_InitiVariablesReport

If (Count parameters:C259=1)
	$size:=$1
Else 
	$size:=0
End if 

ARRAY LONGINT:C221(al_CuNosCursos;$size)
ARRAY INTEGER:C220(al_AlNosOrden;$size)
ARRAY LONGINT:C221(al_AlNosRN;$size)
ARRAY TEXT:C222(at_AlApellidosNombres;$size)
ARRAY TEXT:C222(at_AlSexo;$size)
_O_C_INTEGER:C282(vi_Mes)
  //vi_Mes:=3`por ahora

_O_ARRAY STRING:C218(5;as_Dia1;$size)
_O_ARRAY STRING:C218(5;as_Dia2;$size)
_O_ARRAY STRING:C218(5;as_Dia3;$size)
_O_ARRAY STRING:C218(5;as_Dia4;$size)
_O_ARRAY STRING:C218(5;as_Dia5;$size)
_O_ARRAY STRING:C218(5;as_Dia6;$size)
_O_ARRAY STRING:C218(5;as_Dia7;$size)
_O_ARRAY STRING:C218(5;as_Dia8;$size)
_O_ARRAY STRING:C218(5;as_Dia9;$size)
_O_ARRAY STRING:C218(5;as_Dia10;$size)
_O_ARRAY STRING:C218(5;as_Dia11;$size)
_O_ARRAY STRING:C218(5;as_Dia12;$size)
_O_ARRAY STRING:C218(5;as_Dia13;$size)
_O_ARRAY STRING:C218(5;as_Dia14;$size)
_O_ARRAY STRING:C218(5;as_Dia15;$size)
_O_ARRAY STRING:C218(5;as_Dia16;$size)
_O_ARRAY STRING:C218(5;as_Dia17;$size)
_O_ARRAY STRING:C218(5;as_Dia18;$size)
_O_ARRAY STRING:C218(5;as_Dia19;$size)
_O_ARRAY STRING:C218(5;as_Dia20;$size)
_O_ARRAY STRING:C218(5;as_Dia21;$size)
_O_ARRAY STRING:C218(5;as_Dia22;$size)
_O_ARRAY STRING:C218(5;as_Dia23;$size)
_O_ARRAY STRING:C218(5;as_Dia24;$size)
_O_ARRAY STRING:C218(5;as_Dia25;$size)
_O_ARRAY STRING:C218(5;as_Dia26;$size)
_O_ARRAY STRING:C218(5;as_Dia27;$size)
_O_ARRAY STRING:C218(5;as_Dia28;$size)
_O_ARRAY STRING:C218(5;as_Dia29;$size)
_O_ARRAY STRING:C218(5;as_Dia30;$size)
_O_ARRAY STRING:C218(5;as_Dia31;$size)


_O_ARRAY STRING:C218(5;as_Dia32;$size)
_O_ARRAY STRING:C218(5;as_Dia33;$size)
_O_ARRAY STRING:C218(5;as_Dia34;$size)
_O_ARRAY STRING:C218(5;as_Dia35;$size)
_O_ARRAY STRING:C218(5;as_Dia36;$size)
_O_ARRAY STRING:C218(5;as_Dia37;$size)
_O_ARRAY STRING:C218(5;as_Dia38;$size)
_O_ARRAY STRING:C218(5;as_Dia39;$size)
_O_ARRAY STRING:C218(5;as_Dia40;$size)
_O_ARRAY STRING:C218(5;as_Dia41;$size)
_O_ARRAY STRING:C218(5;as_Dia42;$size)
_O_ARRAY STRING:C218(5;as_Dia43;$size)
_O_ARRAY STRING:C218(5;as_Dia44;$size)
_O_ARRAY STRING:C218(5;as_Dia45;$size)
_O_ARRAY STRING:C218(5;as_Dia46;$size)
_O_ARRAY STRING:C218(5;as_Dia47;$size)
_O_ARRAY STRING:C218(5;as_Dia48;$size)
_O_ARRAY STRING:C218(5;as_Dia49;$size)
_O_ARRAY STRING:C218(5;as_Dia50;$size)

_O_ARRAY STRING:C218(5;as_Dia51;$size)
_O_ARRAY STRING:C218(5;as_Dia52;$size)
_O_ARRAY STRING:C218(5;as_Dia53;$size)
_O_ARRAY STRING:C218(5;as_Dia54;$size)
_O_ARRAY STRING:C218(5;as_Dia55;$size)
_O_ARRAY STRING:C218(5;as_Dia56;$size)
_O_ARRAY STRING:C218(5;as_Dia57;$size)
_O_ARRAY STRING:C218(5;as_Dia58;$size)
_O_ARRAY STRING:C218(5;as_Dia59;$size)
_O_ARRAY STRING:C218(5;as_Dia60;$size)
_O_ARRAY STRING:C218(5;as_Dia61;$size)
_O_ARRAY STRING:C218(5;as_Dia62;$size)
_O_ARRAY STRING:C218(5;as_Dia63;$size)
_O_ARRAY STRING:C218(5;as_Dia64;$size)
_O_ARRAY STRING:C218(5;as_Dia65;$size)
_O_ARRAY STRING:C218(5;as_Dia66;$size)
_O_ARRAY STRING:C218(5;as_Dia67;$size)
_O_ARRAY STRING:C218(5;as_Dia68;$size)
_O_ARRAY STRING:C218(5;as_Dia69;$size)
_O_ARRAY STRING:C218(5;as_Dia70;$size)



_O_ARRAY STRING:C218(5;as_AlAsistenciaM;$size)
_O_ARRAY STRING:C218(5;as_AlAsistenciaF;$size)
_O_ARRAY STRING:C218(5;as_AlInasistenciaM;$size)
_O_ARRAY STRING:C218(5;as_AlInasistenciaF;$size)
_O_ARRAY STRING:C218(5;as_AlLates;$size)

ARRAY DATE:C224(ad_alFechasInas;0)
ARRAY INTEGER:C220(ai_Days;0)
ARRAY DATE:C224(ad_alFechasAtrasos;0)
ARRAY INTEGER:C220(ai_DaysAtrasos;0)
ARRAY INTEGER:C220(ai_minutosAtrasosM;0)
ARRAY INTEGER:C220(ai_minutosAtrasosT;0)
ARRAY TEXT:C222(at_Jornada;0)
ARRAY LONGINT:C221(al_noAtrasosT;0)
ARRAY LONGINT:C221(al_noAtrasosM;0)

ARRAY TEXT:C222(at_DiasTrabajados;0)

vPeriodo:=0

C_TEXT:C284(vt_MesInforme;vt_AgnoInforme;vt_TotalDiasHabiles)
vt_MesInforme:=""
vt_AgnoInforme:=""
vt_TotalDiasHabiles:=""