//%attributes = {}
  // xALSet_AL_AsistenciaClases()
  //
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 21/12/12, 13:11:31
  // ---------------------------------------------
C_LONGINT:C283($i;$l_errorALP;$l_numeroPeriodos;$l_tamañoArreglos;$l_año)
C_LONGINT:C283($1;$2)

  // CÓDIGO
$l_numeroPeriodos:=$1
$l_año:=$2

  //AL_RemoveArrays (xALP_ConductaAlumnos;1;12)
AL_RemoveArrays (xALP_ConductaAlumnos;1;20)


If (VLSTR_HORARIO_NOCICLOS=2) & ($l_año=<>GYEAR)
	$l_errorALP:=AL_SetArraysNam (xALP_ConductaAlumnos;1;13;"at_subjectName";"ai_horas_semana_A";"ai_horas_semana_B";"ai_HorasEfectivas";"at_AbsencesTotal";"at_AbsencesPercent";"at_AbsencesTerm1";"at_AbsencesTerm2";"at_AbsencesTerm3";"at_AbsencesTerm4";"at_AbsencesTerm5";"ab_IncideEnAsistencia";"at_OrdenAsignaturas";"al_IDAsignaturas")
Else 
	$l_errorALP:=AL_SetArraysNam (xALP_ConductaAlumnos;1;13;"at_subjectName";"ai_HorasSemanales";"ai_HorasEfectivas";"at_AbsencesTotal";"at_AbsencesPercent";"at_AbsencesTerm1";"at_AbsencesTerm2";"at_AbsencesTerm3";"at_AbsencesTerm4";"at_AbsencesTerm5";"ab_IncideEnAsistencia";"at_OrdenAsignaturas";"al_IDAsignaturas")
End if 



  //AL_SetSort (xALP_ConductaAlumnos;-1)


AL_SetColOpts (xALP_ConductaAlumnos;0;0;0;0;0;0;0)
AL_SetRowOpts (xALP_ConductaAlumnos;1;1;0;0;1)
AL_SetSortOpts (xALP_ConductaAlumnos;0;0;0;"Ordenamiento";0)
AL_SetDividers (xALP_ConductaAlumnos;"Black";"Light Gray";0;"Black";"Light Gray";0)
AL_SetStyle (xALP_ConductaAlumnos;0;"Tahoma";9;0)
AL_SetHdrStyle (xALP_ConductaAlumnos;0;"Tahoma";9;1)

  // Modificado por: Alexis Bustamante (14-06-2017)
  //agrego columnas dinamicas si esta configurado con calendario doble
Case of 
	: ($l_numeroPeriodos=5)
		If (VLSTR_HORARIO_NOCICLOS=2) & ($l_año=<>GYEAR)
			AL_SetHeaders (xALP_ConductaAlumnos;1;10;__ ("Asignaturas");__ ("Horas semana A");__ ("Horas semana B");__ ("Horas efectuadas");__ ("Inasistencias\r(justif.)");__ ("% de asistencia");atSTR_Periodos_Nombre{1}+__ ("\r(justif.)");atSTR_Periodos_Nombre{2}+__ ("\r(justif.)");atSTR_Periodos_Nombre{3}+__ ("\r(justif.)");atSTR_Periodos_Nombre{4}+__ ("\r(justif.)");atSTR_Periodos_Nombre{5}+__ ("\r(justif.)"))
			AL_SetWidths (xALP_ConductaAlumnos;1;10;156;56;56;56;70;70;80;80;70;70;70;70)
			AL_SetColOpts (xALP_ConductaAlumnos;0;0;0;3;0;0;0)
		Else 
			AL_SetHeaders (xALP_ConductaAlumnos;1;10;__ ("Asignaturas");__ ("Horas semanales");__ ("Horas efectuadas");__ ("Inasistencias\r(justif.)");__ ("% de asistencia");atSTR_Periodos_Nombre{1}+__ ("\r(justif.)");atSTR_Periodos_Nombre{2}+__ ("\r(justif.)");atSTR_Periodos_Nombre{3}+__ ("\r(justif.)");atSTR_Periodos_Nombre{4}+__ ("\r(justif.)");atSTR_Periodos_Nombre{5}+__ ("\r(justif.)"))
			AL_SetWidths (xALP_ConductaAlumnos;1;10;156;56;56;70;70;80;80;70;70;70;70)
			AL_SetColOpts (xALP_ConductaAlumnos;0;0;0;3;0;0;0)
		End if 
		
	: ($l_numeroPeriodos=4)
		
		If (VLSTR_HORARIO_NOCICLOS=2) & ($l_año=<>GYEAR)
			AL_SetHeaders (xALP_ConductaAlumnos;1;9;__ ("Asignaturas");__ ("Horas semana A");__ ("Horas semana B");__ ("Horas efectuadas");__ ("Inasistencias\r(justif.)");__ ("% de asistencia");atSTR_Periodos_Nombre{1}+__ ("\r(justif.)");atSTR_Periodos_Nombre{2}+__ ("\r(justif.)");atSTR_Periodos_Nombre{3}+__ ("\r(justif.)");atSTR_Periodos_Nombre{4}+__ ("\r(justif.)"))
			AL_SetWidths (xALP_ConductaAlumnos;1;9;170;80;80;80;80;80;80;70;70;70;70)
			AL_SetColOpts (xALP_ConductaAlumnos;0;0;0;4;0;0;0)
		Else 
			AL_SetHeaders (xALP_ConductaAlumnos;1;9;__ ("Asignaturas");__ ("Horas semanales");__ ("Horas efectuadas");__ ("Inasistencias\r(justif.)");__ ("% de asistencia");atSTR_Periodos_Nombre{1}+__ ("\r(justif.)");atSTR_Periodos_Nombre{2}+__ ("\r(justif.)");atSTR_Periodos_Nombre{3}+__ ("\r(justif.)");atSTR_Periodos_Nombre{4}+__ ("\r(justif.)"))
			AL_SetWidths (xALP_ConductaAlumnos;1;9;170;80;80;80;80;80;70;70;70;70)
			AL_SetColOpts (xALP_ConductaAlumnos;0;0;0;4;0;0;0)
		End if 
		
	: ($l_numeroPeriodos=3)
		If (VLSTR_HORARIO_NOCICLOS=2) & ($l_año=<>GYEAR)
			AL_SetHeaders (xALP_ConductaAlumnos;1;8;__ ("Asignaturas");__ ("Horas semana A");__ ("Horas semana B");__ ("Horas efectuadas");__ ("Inasistencias\r(justif.)");__ ("% de asistencia");atSTR_Periodos_Nombre{1}+__ ("\r(justif.)");atSTR_Periodos_Nombre{2}+__ ("\r(justif.)");atSTR_Periodos_Nombre{3}+__ ("\r(justif.)"))
			AL_SetWidths (xALP_ConductaAlumnos;1;8;220;80;80;80;80;80;80;80;80;80)
			AL_SetColOpts (xALP_ConductaAlumnos;0;0;0;5;0;0;0)
		Else 
			AL_SetHeaders (xALP_ConductaAlumnos;1;8;__ ("Asignaturas");__ ("Horas semanales");__ ("Horas efectuadas");__ ("Inasistencias\r(justif.)");__ ("% de asistencia");atSTR_Periodos_Nombre{1}+__ ("\r(justif.)");atSTR_Periodos_Nombre{2}+__ ("\r(justif.)");atSTR_Periodos_Nombre{3}+__ ("\r(justif.)"))
			AL_SetWidths (xALP_ConductaAlumnos;1;8;220;80;80;80;80;80;80;80;80)
			AL_SetColOpts (xALP_ConductaAlumnos;0;0;0;5;0;0;0)
		End if 
		
	: ($l_numeroPeriodos=2)
		If (VLSTR_HORARIO_NOCICLOS=2) & ($l_año=<>GYEAR)
			AL_SetHeaders (xALP_ConductaAlumnos;1;7;__ ("Asignaturas");__ ("Horas semana A");__ ("Horas semana B");__ ("Horas efectuadas");__ ("Inasistencias\r(justif.)");__ ("% de Asistencia");atSTR_Periodos_Nombre{1}+__ ("\r(justif.)");atSTR_Periodos_Nombre{2}+__ ("\r(justif.)"))
			AL_SetWidths (xALP_ConductaAlumnos;1;7;300;80;80;80;80;80;80;80)
			AL_SetColOpts (xALP_ConductaAlumnos;0;0;0;6;0;0;0)
		Else 
			AL_SetHeaders (xALP_ConductaAlumnos;1;7;__ ("Asignaturas");__ ("Horas semanales");__ ("Horas efectuadas");__ ("Inasistencias\r(justif.)");__ ("% de Asistencia");atSTR_Periodos_Nombre{1}+__ ("\r(justif.)");atSTR_Periodos_Nombre{2}+__ ("\r(justif.)"))
			AL_SetWidths (xALP_ConductaAlumnos;1;7;300;80;80;80;80;80;80)
			AL_SetColOpts (xALP_ConductaAlumnos;0;0;0;6;0;0;0)
		End if 
	: ($l_numeroPeriodos=1)
		If (VLSTR_HORARIO_NOCICLOS=2) & ($l_año=<>GYEAR)
			AL_SetHeaders (xALP_ConductaAlumnos;1;6;__ ("Asignaturas");__ ("Horas semana A");__ ("Horas semana B");__ ("Horas efectuadas");__ ("Inasistencias\r(justif.)");__ ("% de Asistencia");atSTR_Periodos_Nombre{1}+"\r"+"(justif.)")
			AL_SetWidths (xALP_ConductaAlumnos;1;6;272;80;80;80;80;80;80)
			AL_SetColOpts (xALP_ConductaAlumnos;0;0;0;7;0;0;0)
		Else 
			AL_SetHeaders (xALP_ConductaAlumnos;1;6;__ ("Asignaturas");__ ("Horas semanales");__ ("Horas efectuadas");__ ("Inasistencias\r(justif.)");__ ("% de Asistencia");atSTR_Periodos_Nombre{1}+"\r"+"(justif.)")
			AL_SetWidths (xALP_ConductaAlumnos;1;6;272;80;80;80;80;80)
			AL_SetColOpts (xALP_ConductaAlumnos;0;0;0;7;0;0;0)
		End if 
End case 

  //AL_SetWidths (areaCdta;1;3;60;120;335)
AL_SetFormat (xALP_ConductaAlumnos;1;"";0;2)
AL_SetFormat (xALP_ConductaAlumnos;2;"####";2;2)
AL_SetFormat (xALP_ConductaAlumnos;3;"####";2;2)
AL_SetFormat (xALP_ConductaAlumnos;4;"";2;2)
  // Modificado por: Saúl Ponce (19-05-2017) Ticket 181896, en ST v12 formato incorrecto, el array ya viene con 1 decimal y con signo "%"
  //AL_SetFormat (xALP_ConductaAlumnos;5;"##0"+<>tXS_RS_DecimalSeparator+"0%";2;2)
AL_SetFormat (xALP_ConductaAlumnos;6;"";2;2)
AL_SetFormat (xALP_ConductaAlumnos;7;"";2;2)
AL_SetFormat (xALP_ConductaAlumnos;8;"";2;2)
AL_SetFormat (xALP_ConductaAlumnos;9;"";2;2)
AL_SetEnterable (xALP_ConductaAlumnos;1;0)
AL_SetEnterable (xALP_ConductaAlumnos;2;0)
AL_SetEnterable (xALP_ConductaAlumnos;3;0)
AL_SetEnterable (xALP_ConductaAlumnos;4;0)
AL_SetEnterable (xALP_ConductaAlumnos;5;0)
AL_SetEnterable (xALP_ConductaAlumnos;6;0)
AL_SetEnterable (xALP_ConductaAlumnos;7;0)
AL_SetEnterable (xALP_ConductaAlumnos;8;0)
AL_SetEnterable (xALP_ConductaAlumnos;9;0)
AL_SetEnterable (xALP_ConductaAlumnos;10;0)
AL_SetEnterable (xALP_ConductaAlumnos;11;0)

AL_SetHeight (xALP_ConductaAlumnos;2;2;1;3;0;0)
AL_UpdateArrays (xALP_ConductaAlumnos;-2)
AL_SetLine (xALP_ConductaAlumnos;0)

AL_SetSort (xALP_ConductaAlumnos;12;1)
AL_SetScroll (xALP_ConductaAlumnos;0;-3)

$l_tamañoArreglos:=Size of array:C274(at_subjectName)
For ($i;1;$l_tamañoArreglos)
	If (Not:C34(ab_IncideEnAsistencia{$i}))
		AL_SetRowStyle (xALP_ConductaAlumnos;$i;2;"Tahoma")
	Else 
		AL_SetRowStyle (xALP_ConductaAlumnos;$i;0;"Tahoma")
	End if 
	AL_SetRowColor (xALP_ConductaAlumnos;$i;"Black")
End for 

ALP_SetDefaultAppareance (xALP_ConductaAlumnos;0;2;4;2;4;1;4)
AL_SetInterface (xALP_ConductaAlumnos;AL Force OSX Interface;1;1;0;60;1)


AL_SetMiscOpts (xALP_ConductaAlumnos;0;0;"'";1;1)

  // Modificado por: Alexis Bustamante (14-06-2017)
If (VLSTR_HORARIO_NOCICLOS=2) & ($l_año=<>GYEAR)
	AL_SetFooters (xALP_ConductaAlumnos;1;9;"Totales";String:C10(vlSTR_AL_HorasSemanaA;"####");String:C10(vlSTR_AL_HorasSemanaB;"####");String:C10(vlSTR_AL_HorasEfectuadas;"####");vtSTR_AL_Ausencias;String:C10(vr_PorcentajeAsistencia;"##0"+<>tXS_RS_DecimalSeparator+"0%");vtSTR_AL_AusenciasP1;vtSTR_AL_AusenciasP2;vtSTR_AL_AusenciasP3;vtSTR_AL_AusenciasP4;vtSTR_AL_AusenciasP5)
Else 
	AL_SetFooters (xALP_ConductaAlumnos;1;9;"Totales";String:C10(vlSTR_AL_HorasSemanales;"####");String:C10(vlSTR_AL_HorasEfectuadas;"####");vtSTR_AL_Ausencias;String:C10(vr_PorcentajeAsistencia;"##0"+<>tXS_RS_DecimalSeparator+"0%");vtSTR_AL_AusenciasP1;vtSTR_AL_AusenciasP2;vtSTR_AL_AusenciasP3;vtSTR_AL_AusenciasP4;vtSTR_AL_AusenciasP5)
End if 


AL_SetFtrStyle (xALP_ConductaAlumnos;0;"Tahoma";9;1)
AL_SetLine (xALP_ConductaAlumnos;0)
