//%attributes = {}
  // MÉTODO: PERIODOS_Init
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 07/03/12, 17:15:16
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // PERIODOS_Init()
  // ----------------------------------------------------




  // CODIGO PRINCIPAL
C_BOOLEAN:C305(vb_periodosInicializados)
C_LONGINT:C283(vlSTR_Periodos_CurrentRef)
C_LONGINT:C283(vi_Day1;vi_Day2;vi_Day3;vi_Day4;vi_Day5;vi_Day6;vi_Day7;vi_Day8;vi_Day9;vi_Day10)
C_LONGINT:C283(vi_Day11;vi_Day12;vi_Day13;vi_Day14;vi_Day15;vi_Day16;vi_Day17;vi_Day18;vi_Day19;vi_Day20)
C_LONGINT:C283(vi_Day21;vi_Day22;vi_Day23;vi_Day24;vi_Day25;vi_Day26;vi_Day27;vi_Day28;vi_Day29;vi_Day30)
C_LONGINT:C283(vi_Day31;vi_Day32;vi_Day33;vi_Day34;vi_Day35;vi_Day36;vi_Day37)
C_LONGINT:C283(vlSTR_Horario_NoCiclos;vlSTR_Horario_DiasCiclo;vlSTR_Horario_DiaInicioCiclo;vlSTR_Horario_SabadoLabor;vlSTR_Horario_TipoCiclos;vlSTR_Periodos_CurrentRef)
C_LONGINT:C283(vlSTR_Horario_DiaInicio)
C_LONGINT:C283(viSTR_PeriodoActual_Numero)

ARRAY INTEGER:C220(aiSTR_Periodos_Numero;0)
ARRAY TEXT:C222(atSTR_Periodos_Nombre;0)
ARRAY DATE:C224(adSTR_Periodos_Desde;0)
ARRAY DATE:C224(adSTR_Periodos_Hasta;0)
ARRAY DATE:C224(adSTR_Periodos_Cierre;0)
ARRAY INTEGER:C220(aiSTR_Periodos_Dias;0)

ARRAY DATE:C224(adSTR_Calendario_Feriados;0)

ARRAY INTEGER:C220(aiSTR_Horario_HoraNo;0)
ARRAY LONGINT:C221(alSTR_Horario_Desde;0)
ARRAY LONGINT:C221(alSTR_Horario_Hasta;0)
ARRAY LONGINT:C221(alSTR_Horario_Duracion;0)
ARRAY LONGINT:C221(alSTR_Horario_RefTipoHora;0)
ARRAY DATE:C224(adSTR_Periodos_InicioCiclos;0)


COPY ARRAY:C226(<>atSTR_Horario_TipoCiclos;atSTR_Horario_TipoCiclos)
COPY ARRAY:C226(<>atXS_DayNames;atSTR_Horario_Dias)


vlSTR_Horario_TipoCiclos:=1
vlSTR_Horario_NoCiclos:=1
vlSTR_Horario_DiasCiclo:=5
vlSTR_Horario_SabadoLabor:=0
vlSTR_Horario_DiaInicioCiclo:=2  //Lunes, inicio por defecto de los períodos. En versiones posteriores podría ser configurable
vlSTR_Periodos_CurrentRef:=0

atSTR_Horario_Dias:=vlSTR_Horario_DiaInicioCiclo
atSTR_Horario_TipoCiclos:=vlSTR_Horario_TipoCiclos


vb_periodosInicializados:=True:C214