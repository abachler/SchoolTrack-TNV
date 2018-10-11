//%attributes = {}
  //CFG_BBL_Generales

C_LONGINT:C283($OTref_Periodos;$OTref_Horario;$OTref_Calendario)
C_BLOB:C604($blob)
C_TEXT:C284($message;$parameters;$1;$2)
C_LONGINT:C283($j;$k)
C_LONGINT:C283(vi_Day1;vi_Day2;vi_Day3;vi_Day4;vi_Day5;vi_Day6;vi_Day7;vi_Day8;vi_Day9;vi_Day10)
C_LONGINT:C283(vi_Day11;vi_Day12;vi_Day13;vi_Day14;vi_Day15;vi_Day16;vi_Day17;vi_Day18;vi_Day19;vi_Day20)
C_LONGINT:C283(vi_Day21;vi_Day22;vi_Day23;vi_Day24;vi_Day25;vi_Day26;vi_Day27;vi_Day28;vi_Day29;vi_Day30)
C_LONGINT:C283(vi_Day31;vi_Day32;vi_Day33;vi_Day34;vi_Day35;vi_Day36;vi_Day37)
C_LONGINT:C283(vlSTR_Horario_NoCiclos;vlSTR_Horario_DiasCiclo;vlSTR_Horario_DiaInicioCiclo;vlSTR_Horario_SabadoLabor;vlSTR_Horario_TipoCiclos)
C_LONGINT:C283(vlSTR_Horario_DiaInicio)

READ WRITE:C146([xxBBL_Preferencias:65])
ALL RECORDS:C47([xxBBL_Preferencias:65])
If (Records in table:C83([xxBBL_Preferencias:65])=0)
	CREATE RECORD:C68([xxBBL_Preferencias:65])
	SAVE RECORD:C53([xxBBL_Preferencias:65])
End if 
FIRST RECORD:C50([xxBBL_Preferencias:65])
CFG_OpenConfigPanel (->[xxBBL_Preferencias:65];"CFG_Generales";1)
$pID:=Execute on server:C373("BBL_LeeConfiguracion";Pila_256K;"Lectura preferencias MT")
KRL_ExecuteOnConnectedClients ("BBL_LeeConfiguracion")
BBL_LeeConfiguracion 