//%attributes = {}
  // AS_ListboxCalificaciones()
  //
  //
  // creado por: Alberto Bachler Klein: 18-02-16, 09:48:27
  // -----------------------------------------------------------
C_LONGINT:C283($1)

C_LONGINT:C283($i;$l_columnas;$l_filas;$l_modoRegistroAsistencia;$l_periodo)
C_POINTER:C301($y_inasistencias;$y_nil;$y_parcial01;$y_parcial02;$y_parcial03;$y_parcial04;$y_parcial05;$y_parcial06;$y_parcial07;$y_parcial08)
C_POINTER:C301($y_parcial09;$y_parcial10;$y_parcial11;$y_parcial12;$y_ParcialReal01;$y_ParcialReal02;$y_ParcialReal03;$y_ParcialReal04;$y_ParcialReal05;$y_ParcialReal06)
C_POINTER:C301($y_ParcialReal07;$y_ParcialReal08;$y_ParcialReal09;$y_ParcialReal10;$y_ParcialReal11;$y_ParcialReal12)
C_TEXT:C284($t_objectName)

ARRAY POINTER:C280($ay_parciales;0)



If (False:C215)
	C_LONGINT:C283(AS_ListboxCalificaciones ;$1)
End if 

$l_modoRegistroAsistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Asignaturas:18]Numero_del_Nivel:6;->[xxSTR_Niveles:6]AttendanceMode:3)


  //If (False)
$l_columnas:=LISTBOX Get number of columns:C831(*;"lb_calificaciones")
LISTBOX DELETE COLUMN:C830(*;"lb_calificaciones";1;$l_columnas)

$l_periodo:=$1-1
$y_inasistencias:=Choose:C955($l_periodo;->[Alumnos_ComplementoEvaluacion:209]P01_Inasistencias:18;->[Alumnos_ComplementoEvaluacion:209]P02_Inasistencias:23;->[Alumnos_ComplementoEvaluacion:209]P03_Inasistencias:28;->[Alumnos_ComplementoEvaluacion:209]P04_Inasistencias:33;->[Alumnos_ComplementoEvaluacion:209]P05_Inasistencias:38)


APPEND TO ARRAY:C911($ay_parciales;Choose:C955($l_periodo;->[Alumnos_Calificaciones:208]P01_Eval01_Literal:46;->[Alumnos_Calificaciones:208]P02_Eval01_Literal:121;->[Alumnos_Calificaciones:208]P03_Eval01_Literal:196;->[Alumnos_Calificaciones:208]P04_Eval01_Literal:271;->[Alumnos_Calificaciones:208]P05_Eval01_Literal:346))
APPEND TO ARRAY:C911($ay_parciales;Choose:C955($l_periodo;->[Alumnos_Calificaciones:208]P01_Eval02_Literal:51;->[Alumnos_Calificaciones:208]P02_Eval02_Literal:126;->[Alumnos_Calificaciones:208]P03_Eval02_Literal:201;->[Alumnos_Calificaciones:208]P04_Eval02_Literal:276;->[Alumnos_Calificaciones:208]P05_Eval02_Literal:351))
APPEND TO ARRAY:C911($ay_parciales;Choose:C955($l_periodo;->[Alumnos_Calificaciones:208]P01_Eval03_Literal:56;->[Alumnos_Calificaciones:208]P02_Eval03_Literal:131;->[Alumnos_Calificaciones:208]P03_Eval03_Literal:206;->[Alumnos_Calificaciones:208]P04_Eval03_Literal:281;->[Alumnos_Calificaciones:208]P05_Eval03_Literal:356))
APPEND TO ARRAY:C911($ay_parciales;Choose:C955($l_periodo;->[Alumnos_Calificaciones:208]P01_Eval04_Literal:61;->[Alumnos_Calificaciones:208]P02_Eval04_Literal:136;->[Alumnos_Calificaciones:208]P03_Eval04_Literal:211;->[Alumnos_Calificaciones:208]P04_Eval04_Literal:286;->[Alumnos_Calificaciones:208]P05_Eval04_Literal:361))
APPEND TO ARRAY:C911($ay_parciales;Choose:C955($l_periodo;->[Alumnos_Calificaciones:208]P01_Eval05_Literal:66;->[Alumnos_Calificaciones:208]P02_Eval05_Literal:141;->[Alumnos_Calificaciones:208]P03_Eval05_Literal:216;->[Alumnos_Calificaciones:208]P04_Eval05_Literal:291;->[Alumnos_Calificaciones:208]P05_Eval05_Literal:366))
APPEND TO ARRAY:C911($ay_parciales;Choose:C955($l_periodo;->[Alumnos_Calificaciones:208]P01_Eval06_Literal:71;->[Alumnos_Calificaciones:208]P02_Eval06_Literal:146;->[Alumnos_Calificaciones:208]P03_Eval06_Literal:221;->[Alumnos_Calificaciones:208]P04_Eval06_Literal:296;->[Alumnos_Calificaciones:208]P05_Eval06_Literal:371))
APPEND TO ARRAY:C911($ay_parciales;Choose:C955($l_periodo;->[Alumnos_Calificaciones:208]P01_Eval07_Literal:76;->[Alumnos_Calificaciones:208]P02_Eval07_Literal:151;->[Alumnos_Calificaciones:208]P03_Eval07_Literal:226;->[Alumnos_Calificaciones:208]P04_Eval07_Literal:301;->[Alumnos_Calificaciones:208]P05_Eval07_Literal:376))
APPEND TO ARRAY:C911($ay_parciales;Choose:C955($l_periodo;->[Alumnos_Calificaciones:208]P01_Eval08_Literal:81;->[Alumnos_Calificaciones:208]P02_Eval08_Literal:156;->[Alumnos_Calificaciones:208]P03_Eval08_Literal:231;->[Alumnos_Calificaciones:208]P04_Eval08_Literal:306;->[Alumnos_Calificaciones:208]P05_Eval08_Literal:381))
APPEND TO ARRAY:C911($ay_parciales;Choose:C955($l_periodo;->[Alumnos_Calificaciones:208]P01_Eval09_Literal:86;->[Alumnos_Calificaciones:208]P02_Eval09_Literal:161;->[Alumnos_Calificaciones:208]P03_Eval09_Literal:236;->[Alumnos_Calificaciones:208]P04_Eval09_Literal:311;->[Alumnos_Calificaciones:208]P05_Eval09_Literal:386))
APPEND TO ARRAY:C911($ay_parciales;Choose:C955($l_periodo;->[Alumnos_Calificaciones:208]P01_Eval10_Literal:91;->[Alumnos_Calificaciones:208]P02_Eval10_Literal:166;->[Alumnos_Calificaciones:208]P03_Eval10_Literal:241;->[Alumnos_Calificaciones:208]P04_Eval10_Literal:316;->[Alumnos_Calificaciones:208]P05_Eval10_Literal:391))
APPEND TO ARRAY:C911($ay_parciales;Choose:C955($l_periodo;->[Alumnos_Calificaciones:208]P01_Eval11_Literal:96;->[Alumnos_Calificaciones:208]P02_Eval11_Literal:171;->[Alumnos_Calificaciones:208]P03_Eval11_Literal:246;->[Alumnos_Calificaciones:208]P04_Eval11_Literal:321;->[Alumnos_Calificaciones:208]P05_Eval11_Literal:396))
APPEND TO ARRAY:C911($ay_parciales;Choose:C955($l_periodo;->[Alumnos_Calificaciones:208]P01_Eval12_Literal:101;->[Alumnos_Calificaciones:208]P02_Eval12_Literal:176;->[Alumnos_Calificaciones:208]P03_Eval12_Literal:251;->[Alumnos_Calificaciones:208]P04_Eval12_Literal:326;->[Alumnos_Calificaciones:208]P05_Eval12_Literal:401))

$y_ParcialReal01:=Choose:C955($l_periodo;->[Alumnos_Calificaciones:208]P01_Eval01_Real:42;->[Alumnos_Calificaciones:208]P02_Eval01_Real:117;->[Alumnos_Calificaciones:208]P03_Eval01_Real:192;->[Alumnos_Calificaciones:208]P04_Eval01_Real:267;->[Alumnos_Calificaciones:208]P05_Eval01_Real:342)
$y_ParcialReal02:=Choose:C955($l_periodo;->[Alumnos_Calificaciones:208]P01_Eval02_Real:47;->[Alumnos_Calificaciones:208]P02_Eval02_Real:122;->[Alumnos_Calificaciones:208]P03_Eval02_Real:197;->[Alumnos_Calificaciones:208]P04_Eval02_Real:272;->[Alumnos_Calificaciones:208]P05_Eval02_Real:347)
$y_ParcialReal03:=Choose:C955($l_periodo;->[Alumnos_Calificaciones:208]P01_Eval03_Real:52;->[Alumnos_Calificaciones:208]P02_Eval03_Real:127;->[Alumnos_Calificaciones:208]P03_Eval03_Real:202;->[Alumnos_Calificaciones:208]P04_Eval03_Real:277;->[Alumnos_Calificaciones:208]P05_Eval03_Real:352)
$y_ParcialReal04:=Choose:C955($l_periodo;->[Alumnos_Calificaciones:208]P01_Eval04_Real:57;->[Alumnos_Calificaciones:208]P02_Eval04_Real:132;->[Alumnos_Calificaciones:208]P03_Eval04_Real:207;->[Alumnos_Calificaciones:208]P04_Eval04_Real:282;->[Alumnos_Calificaciones:208]P05_Eval04_Real:357)
$y_ParcialReal05:=Choose:C955($l_periodo;->[Alumnos_Calificaciones:208]P01_Eval05_Real:62;->[Alumnos_Calificaciones:208]P02_Eval05_Real:137;->[Alumnos_Calificaciones:208]P03_Eval05_Real:212;->[Alumnos_Calificaciones:208]P04_Eval05_Real:287;->[Alumnos_Calificaciones:208]P05_Eval05_Real:362)
$y_ParcialReal06:=Choose:C955($l_periodo;->[Alumnos_Calificaciones:208]P01_Eval06_Real:67;->[Alumnos_Calificaciones:208]P02_Eval06_Real:142;->[Alumnos_Calificaciones:208]P03_Eval06_Real:217;->[Alumnos_Calificaciones:208]P04_Eval06_Real:292;->[Alumnos_Calificaciones:208]P05_Eval06_Real:367)
$y_ParcialReal07:=Choose:C955($l_periodo;->[Alumnos_Calificaciones:208]P01_Eval07_Real:72;->[Alumnos_Calificaciones:208]P02_Eval07_Real:147;->[Alumnos_Calificaciones:208]P03_Eval07_Real:222;->[Alumnos_Calificaciones:208]P04_Eval07_Real:297;->[Alumnos_Calificaciones:208]P05_Eval07_Real:372)
$y_ParcialReal08:=Choose:C955($l_periodo;->[Alumnos_Calificaciones:208]P01_Eval08_Real:77;->[Alumnos_Calificaciones:208]P02_Eval08_Real:152;->[Alumnos_Calificaciones:208]P03_Eval08_Real:227;->[Alumnos_Calificaciones:208]P04_Eval08_Real:302;->[Alumnos_Calificaciones:208]P05_Eval08_Real:377)
$y_ParcialReal09:=Choose:C955($l_periodo;->[Alumnos_Calificaciones:208]P01_Eval09_Real:82;->[Alumnos_Calificaciones:208]P02_Eval09_Real:157;->[Alumnos_Calificaciones:208]P03_Eval09_Real:232;->[Alumnos_Calificaciones:208]P04_Eval09_Real:307;->[Alumnos_Calificaciones:208]P05_Eval09_Real:382)
$y_ParcialReal10:=Choose:C955($l_periodo;->[Alumnos_Calificaciones:208]P01_Eval10_Real:87;->[Alumnos_Calificaciones:208]P02_Eval10_Real:162;->[Alumnos_Calificaciones:208]P03_Eval10_Real:237;->[Alumnos_Calificaciones:208]P04_Eval10_Real:312;->[Alumnos_Calificaciones:208]P05_Eval10_Real:387)
$y_ParcialReal11:=Choose:C955($l_periodo;->[Alumnos_Calificaciones:208]P01_Eval11_Real:92;->[Alumnos_Calificaciones:208]P02_Eval11_Real:167;->[Alumnos_Calificaciones:208]P03_Eval11_Real:242;->[Alumnos_Calificaciones:208]P04_Eval11_Real:317;->[Alumnos_Calificaciones:208]P05_Eval11_Real:392)
$y_ParcialReal12:=Choose:C955($l_periodo;->[Alumnos_Calificaciones:208]P01_Eval12_Real:97;->[Alumnos_Calificaciones:208]P02_Eval12_Real:172;->[Alumnos_Calificaciones:208]P03_Eval12_Real:247;->[Alumnos_Calificaciones:208]P04_Eval12_Real:322;->[Alumnos_Calificaciones:208]P05_Eval12_Real:397)


AT_Inc (0)
$t_objectName:=LB_SetDynamicFieldColumn ("lb_calificaciones";AT_Inc ;"";"";->[Alumnos_Calificaciones:208]NoDeLista:10;"#";20;"00")
$t_objectName:=LB_SetDynamicFieldColumn ("lb_calificaciones";AT_Inc ;"";"";->[Alumnos:2]apellidos_y_nombres:40;"Alumno";200)
$t_objectName:=LB_SetDynamicFieldColumn ("lb_calificaciones";AT_Inc ;"";"";->[Alumnos:2]curso:20;"Curso";Choose:C955([Asignaturas:18]Seleccion:17 | [Asignaturas:18]Electiva:11;0;60))
$t_objectName:=LB_SetDynamicFieldColumn ("lb_calificaciones";AT_Inc ;"";"";$y_inasistencias;"Inasistencias";Choose:C955($l_modoRegistroAsistencia=4;30;0);"";Align right:K42:4)
$t_objectName:=LB_SetDynamicFieldColumn ("lb_calificaciones";AT_Inc ;"";"";->[Alumnos_Calificaciones:208]P01_Final_Literal:116;"P1";Choose:C955(viSTR_Periodos_NumeroPeriodos>=1;30;0);"";Align center:K42:3)
$t_objectName:=LB_SetDynamicFieldColumn ("lb_calificaciones";AT_Inc ;"";"";->[Alumnos_Calificaciones:208]P02_Final_Literal:191;"P2";Choose:C955(viSTR_Periodos_NumeroPeriodos>=2;30;0);"";Align center:K42:3)
$t_objectName:=LB_SetDynamicFieldColumn ("lb_calificaciones";AT_Inc ;"";"";->[Alumnos_Calificaciones:208]P03_Final_Literal:266;"P3";Choose:C955(viSTR_Periodos_NumeroPeriodos>=3;30;0);"";Align center:K42:3)
$t_objectName:=LB_SetDynamicFieldColumn ("lb_calificaciones";AT_Inc ;"";"";->[Alumnos_Calificaciones:208]P04_Final_Literal:341;"P4";Choose:C955(viSTR_Periodos_NumeroPeriodos>=4;30;0);"";Align center:K42:3)
$t_objectName:=LB_SetDynamicFieldColumn ("lb_calificaciones";AT_Inc ;"";"";->[Alumnos_Calificaciones:208]P05_Final_Literal:416;"P5";Choose:C955(viSTR_Periodos_NumeroPeriodos>=5;30;0);"";Align center:K42:3)
$t_objectName:=LB_SetDynamicFieldColumn ("lb_calificaciones";AT_Inc ;"";"";->[Alumnos_Calificaciones:208]Anual_Literal:15;"PA";30*vi_UsarExamenes;"";Align right:K42:4)
$t_objectName:=LB_SetDynamicFieldColumn ("lb_calificaciones";AT_Inc ;"";"";->[Alumnos_Calificaciones:208]ExamenAnual_Literal:20;"EX";30*vi_UsarExamenes;"";Align right:K42:4)
$t_objectName:=LB_SetDynamicFieldColumn ("lb_calificaciones";AT_Inc ;"";"";->[Alumnos_Calificaciones:208]ExamenExtra_Literal:25;"EXX";30*vi_UsarExamenExtra;"";Align right:K42:4)
$t_objectName:=LB_SetDynamicFieldColumn ("lb_calificaciones";AT_Inc ;"";"";->[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30;"NF";(30*Num:C11(vi_UsarExamenes=0));"";Align right:K42:4)
$t_objectName:=LB_SetDynamicFieldColumn ("lb_calificaciones";AT_Inc ;"";"";->[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36;"NO";30*Num:C11(vb_NotaOficialVisible);"";Align right:K42:4)

For ($i;1;12)
	$t_objectName:=LB_SetDynamicFieldColumn ("lb_calificaciones";AT_Inc ;"";"";$ay_parciales{$i};String:C10($i);30;"00")
End for 

$l_filas:=LISTBOX Get number of rows:C915(*;"lb_calificaciones")

  //End if