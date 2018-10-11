//%attributes = {}
  //CAL_SetCalendarObjects

If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Procédure : CAL_SetCalendarObjects
	
	
	  //Autor: Alberto Bachler
	  //Creada el 23/5/96 a 06:22 pm
	  //============================== DESCRIPCION ==============================
	  //Package:
	  //Descripción:
	  //Sintaxis:
	  //============================== MODIFICACIONES ==============================
	  //Modificado por: Alberto Bachler (16-09-2004)
	  //Autor:
	  //Descripción: Para poner colores al calendario.
End if 

C_LONGINT:C283($j;$k)
C_LONGINT:C283(vi_Day1;vi_Day2;vi_Day3;vi_Day4;vi_Day5;vi_Day6;vi_Day7;vi_Day8;vi_Day9;vi_Day10)
C_LONGINT:C283(vi_Day11;vi_Day12;vi_Day13;vi_Day14;vi_Day15;vi_Day16;vi_Day17;vi_Day18;vi_Day19;vi_Day20)
C_LONGINT:C283(vi_Day21;vi_Day22;vi_Day23;vi_Day24;vi_Day25;vi_Day26;vi_Day27;vi_Day28;vi_Day29;vi_Day30)
C_LONGINT:C283(vi_Day31;vi_Day32;vi_Day33;vi_Day34;vi_Day35;vi_Day36;vi_Day37)
ARRAY POINTER:C280(aySTR_Calendario_DayPointers;37)
For ($i;1;37)
	aySTR_Calendario_DayPointers{$i}:=Get pointer:C304("vi_Day"+String:C10($i))
	aySTR_Calendario_DayPointers{$i}->:=0
End for 
  //$Fech_Act:=Day of(Current date)
$j:=1
$K:=1

For ($i;1;37)
	If ($j=8)
		$K:=$k+1
		$j:=1
	End if 
	aySTR_Calendario_DayPointers{$i}->:=ai2DSTR_CalendarMatrix{$k}{$j}
	Case of 
		: (at2DSTR_MatrizFeriados{$k}{$j}="²")
			OBJECT SET COLOR:C271(aySTR_Calendario_DayPointers{$i}->;-3)
		: (at2DSTR_MatrizFeriados{$k}{$j}="*")
			OBJECT SET COLOR:C271(aySTR_Calendario_DayPointers{$i}->;-5)
		Else 
			OBJECT SET COLOR:C271(aySTR_Calendario_DayPointers{$i}->;-15)
	End case 
	$j:=$j+1
End for 