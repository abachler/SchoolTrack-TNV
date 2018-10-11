//%attributes = {}
  // MÉTODO: CAE_InicializacionAsignaturas
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 28/02/12, 16:46:54
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // CAE_InicializacionAsignaturas()
  // ----------------------------------------------------
C_LONGINT:C283($l_numeroRegistros;$l_recNumSintesisAnual;$i)
C_TEXT:C284($t_llaveRegistroSintesisAnual)

ARRAY LONGINT:C221($al_recNumAsignaturas;0)
  // CODIGO PRINCIPAL
EVS_LoadStyles 

C_LONGINT:C283($1;$l_nivel)  //MONO 184433
If (Count parameters:C259=1)
	$l_nivel:=$1  //MONO 184433
	QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6=$l_nivel)  //MONO 184433
	bInitPonderaciones:=0  //MONO 184433
	r1InitPropEvaluacion:=0  //MONO 184433
	bInicializarConsolidaciones:=0  //MONO 184433
Else 
	ALL RECORDS:C47([Asignaturas:18])  //MONO 184433
End if 

ARRAY LONGINT:C221($al_recNumAsignaturas;0)
LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$al_recNumAsignaturas;"")
$l_numeroRegistros:=Size of array:C274($al_recNumAsignaturas)
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Inicializando asignaturas para el año escolar ")+String:C10(<>gYear))
For ($i;1;$l_numeroRegistros)
	READ WRITE:C146([Asignaturas:18])
	GOTO RECORD:C242([Asignaturas:18];$al_recNumAsignaturas{$i})
	$l_oldIdAsig:=[Asignaturas:18]Numero:1  //MONO 184433
	[Asignaturas:18]Numero:1:=SQ_SeqNumber (->[Asignaturas:18]Numero:1)  //MONO 184433
	[Asignaturas:18]Ultimo_archivo:72:=<>gYear
	[Asignaturas:18]Nota_final:18:=0
	[Asignaturas:18]Examen:19:=0
	[Asignaturas:18]Promedio_final:20:=0
	[Asignaturas:18]Promedio_P1:23:=0
	[Asignaturas:18]Promedio_P2:22:=0
	[Asignaturas:18]Promedio_P3:21:=0
	[Asignaturas:18]Promedio_P4:59:=0
	[Asignaturas:18]PromedioFinal_texto:53:=""
	[Asignaturas:18]PromedioFinalOficial_texto:67:=""
	[Asignaturas:18]Max_EX:87:=0
	[Asignaturas:18]Max_Final:88:=0
	[Asignaturas:18]Max_P1:82:=0
	[Asignaturas:18]Max_P2:83:=0
	[Asignaturas:18]Max_P3:84:=0
	[Asignaturas:18]Max_P4:85:=0
	[Asignaturas:18]Max_PF:86:=0
	[Asignaturas:18]Min_EX:80:=0
	[Asignaturas:18]Min_Final:81:=0
	[Asignaturas:18]Min_P1:75:=0
	[Asignaturas:18]Min_P2:76:=0
	[Asignaturas:18]Min_P3:77:=0
	[Asignaturas:18]Min_P4:78:=0
	[Asignaturas:18]Min_PF:79:=0
	[Asignaturas:18]UltimoIngresoDeNotas:32:=0
	[Asignaturas:18]Horas_de_clases_efectivas:52:=0
	[Asignaturas:18]Numero_de_alumnos:49:=0
	[Asignaturas:18]LastNumber:54:=0
	[Asignaturas:18]PorcentajeAprobados:103:=100
	
	If (bInitPonderaciones=1)
		[Asignaturas:18]Consolidacion_TipoPonderacion:50:=0
	End if 
	If (r1InitPropEvaluacion=1)
		[Asignaturas:18]Consolidacion_Metodo:55:=0
		[Asignaturas:18]Consolidacion_PorPeriodo:58:=False:C215
		[Asignaturas:18]Consolidacion_TipoPonderacion:50:=0
	End if 
	If ((bInicializarConsolidaciones=1) | (r1InitPropEvaluacion=1))
		[Asignaturas:18]Consolidacion_Madre_Id:7:=0
		[Asignaturas:18]Consolidacion_Madre_nombre:8:=""
		[Asignaturas:18]Consolidacion_EsConsolidante:35:=False:C215
		[Asignaturas:18]Consolidacion_ConSubasignaturas:31:=False:C215
		AScsd_EliminaReferencias ($l_oldIdAsig)  //MONO 184433
	End if 
	SAVE RECORD:C53([Asignaturas:18])
	
	CAE_InitPropEvaluacion ([Asignaturas:18]Numero:1)  //ASM Ticket 208184
	
	$l_newIdAsig:=[Asignaturas:18]Numero:1  //MONO 184433
	$t_llaveRegistroSintesisAnual:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10([Asignaturas:18]Numero:1)
	$l_recNumSintesisAnual:=KRL_FindAndLoadRecordByIndex (->[Asignaturas_SintesisAnual:202]LLavePrimaria:5;->$t_llaveRegistroSintesisAnual)
	If ($l_recNumSintesisAnual<0)
		CREATE RECORD:C68([Asignaturas_SintesisAnual:202])
		[Asignaturas_SintesisAnual:202]ID_Institucion:1:=<>gInstitucion
		[Asignaturas_SintesisAnual:202]Año:3:=<>gYear
		[Asignaturas_SintesisAnual:202]ID_Asignatura:2:=[Asignaturas:18]Numero:1
		[Asignaturas_SintesisAnual:202]PorcentajeAprobados:120:=100
		[Asignaturas_SintesisAnual:202]PorcentajeInasistencia:9:=""
		SAVE RECORD:C53([Asignaturas_SintesisAnual:202])
	End if 
	
	  //********************** MONO 184433 *************************//
	
	  //20180606 ASM Ticket 208593 cambio el id de la madre en las asignaturas
	READ WRITE:C146([Asignaturas:18])
	QUERY:C277([Asignaturas:18];[Asignaturas:18]Consolidacion_Madre_Id:7=$l_oldIdAsig)
	APPLY TO SELECTION:C70([Asignaturas:18];[Asignaturas:18]Consolidacion_Madre_Id:7:=$l_newIdAsig)
	
	
	ARRAY LONGINT:C221($al_idAsigConsolida;0)
	READ WRITE:C146([Asignaturas_Consolidantes:231])
	QUERY:C277([Asignaturas_Consolidantes:231];[Asignaturas_Consolidantes:231]ID_AsignaturaMadre:1=$l_oldIdAsig)
	APPLY TO SELECTION:C70([Asignaturas_Consolidantes:231];[Asignaturas_Consolidantes:231]ID_AsignaturaMadre:1:=$l_newIdAsig)
	QUERY:C277([Asignaturas_Consolidantes:231];[Asignaturas_Consolidantes:231]ID_ParentRecord:5=$l_oldIdAsig)
	APPLY TO SELECTION:C70([Asignaturas_Consolidantes:231];[Asignaturas_Consolidantes:231]ID_ParentRecord:5:=$l_newIdAsig)
	SELECTION TO ARRAY:C260([Asignaturas_Consolidantes:231]ID_AsignaturaMadre:1;$al_idAsigConsolida)
	UNLOAD RECORD:C212([Asignaturas_Consolidantes:231])
	READ ONLY:C145([Asignaturas_Consolidantes:231])
	
	C_OBJECT:C1216($o_temporal)  //20180606 ASM Ticket 208593
	ARRAY LONGINT:C221($alAS_EvalPropSourceID;0)
	For ($i_asig;1;Size of array:C274($al_idAsigConsolida))
		READ WRITE:C146([Asignaturas:18])
		QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=$al_idAsigConsolida{$i_asig})
		If ([Asignaturas:18]Consolidacion_PorPeriodo:58)
			PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
			For ($i_periodo;1;Size of array:C274(aiSTR_Periodos_Numero))
				$t_nodo:="P"+String:C10($i_periodo)
				  //20180606 ASM Ticket 208593
				$o_temporal:=OB Get:C1224([Asignaturas:18]Configuracion:63;$t_nodo)
				OB GET ARRAY:C1229($o_temporal;"SourceID";$alAS_EvalPropSourceID)
				$l_pos:=Find in array:C230($alAS_EvalPropSourceID;$l_oldIdAsig)
				If ($l_pos>0)
					$alAS_EvalPropSourceID{$l_pos}:=$l_newIdAsig
					  //20180606 ASM Ticket 208593
					OB SET ARRAY:C1227($o_temporal;"SourceID";$alAS_EvalPropSourceID)
					OB SET:C1220([Asignaturas:18]Configuracion:63;$t_nodo;$o_temporal)
				End if 
			End for 
		Else 
			$t_nodo:="Anual"
			  //20180606 ASM Ticket 208593
			$o_temporal:=OB Get:C1224([Asignaturas:18]Configuracion:63;$t_nodo)
			OB GET ARRAY:C1229($o_temporal;"SourceID";$alAS_EvalPropSourceID)
			$l_pos:=Find in array:C230($alAS_EvalPropSourceID;$l_oldIdAsig)
			If ($l_pos>0)
				$alAS_EvalPropSourceID{$l_pos}:=$l_newIdAsig
				  //20180606 ASM Ticket 208593
				OB SET ARRAY:C1227($o_temporal;"SourceID";$alAS_EvalPropSourceID)
				OB SET:C1220([Asignaturas:18]Configuracion:63;$t_nodo;$o_temporal)
			End if 
		End if 
		SAVE RECORD:C53([Asignaturas:18])
		UNLOAD RECORD:C212([Asignaturas:18])
		READ ONLY:C145([Asignaturas:18])
	End for 
	  //********************** MONO 184433 *************************//
	
	UNLOAD RECORD:C212([Asignaturas:18])
	READ ONLY:C145([Asignaturas:18])
	
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/$l_numeroRegistros)
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)

UNLOAD RECORD:C212([Asignaturas_SintesisAnual:202])
READ ONLY:C145([Asignaturas_SintesisAnual:202])