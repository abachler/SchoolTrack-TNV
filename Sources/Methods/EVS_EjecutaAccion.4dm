//%attributes = {}
  // EVS_EjecutaAccion()
  // Por: Alberto Bachler K.: 29-12-14, 12:11:06
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

$t_accion:=$1


Case of 
	: ($t_accion="nuevo")
		ssymbolMinimum:=""
		CREATE RECORD:C68([xxSTR_EstilosEvaluacion:44])
		[xxSTR_EstilosEvaluacion:44]ID:1:=SQ_SeqNumber (->[xxSTR_EstilosEvaluacion:44]ID:1)
		[xxSTR_EstilosEvaluacion:44]Name:2:=__ ("Estilo de evaluación #")+String:C10([xxSTR_EstilosEvaluacion:44]ID:1)
		[xxSTR_EstilosEvaluacion:44]creadoPor:11:=<>tUSR_CurrentUserName
		[xxSTR_EstilosEvaluacion:44]modificadoPor:12:=<>tUSR_CurrentUserName
		SAVE RECORD:C53([xxSTR_EstilosEvaluacion:44])
		$l_idEstilo:=[xxSTR_EstilosEvaluacion:44]ID:1
		
		
		EVS_initialize 
		iEvaluationMode:=1
		iViewMode:=1
		iPrintMode:=1
		iPrintActa:=1
		Case of 
			: (<>gCountryCode="cl")
				rGradesFrom:=1
				rGradesTo:=7
				rGradesMinimum:=4
				rGradesInterval:=0.1
				iGradesDec:=1
				iGradesDecPP:=1
				iGradesDecPF:=1
				iGradesDecNF:=1
				iGradesDecNO:=1
			: (<>gCountryCode="mx")
				rGradesFrom:=0
				rGradesTo:=10
				rGradesMinimum:=4
				rGradesInterval:=0.01
				iGradesDec:=2
				iGradesDecPP:=2
				iGradesDecPF:=2
				iGradesDecNF:=2
				iGradesDecNO:=2
			: (<>gCountryCode="ar")
				rGradesFrom:=1
				rGradesTo:=10
				rGradesMinimum:=6
				rGradesInterval:=0.1
				iGradesDec:=1
				iGradesDecPP:=1
				iGradesDecPF:=1
				iGradesDecNF:=1
				iGradesDecNO:=1
			: (<>gCountryCode="uy")
				rGradesFrom:=1
				rGradesTo:=12
				rGradesMinimum:=6
				rGradesInterval:=0.1
				iGradesDec:=1
				iGradesDecPP:=1
				iGradesDecPF:=1
				iGradesDecNF:=1
				iGradesDecNO:=1
			Else 
				rGradesFrom:=1
				rGradesTo:=10
				rGradesMinimum:=5
				rGradesInterval:=0.1
				iGradesDec:=1
				iGradesDecPP:=1
				iGradesDecPF:=1
				iGradesDecNF:=1
				iGradesDecNO:=1
		End case 
		iPointsDec:=0
		iPointsDecPP:=0
		iPointsDecPF:=0
		iPointsDecNF:=0
		iPointsDecNO:=0
		
		rPctMinimum:=Round:C94(rGradesMinimum/rGradesTo;11)*100
		rPointsFrom:=1
		rPointsTo:=100
		rPointsMinimum:=50
		rPointsInterval:=1
		iResults:=1
		viEVS_equMode:=1
		iconversionTable:=0
		
		AT_Initialize (->aSymbol;->aSymbDesc;->aSymbGradeFrom;->aSymbGradeTo;->aSymbGradesEqu;->aSymbPointsFrom;->aSymbPointsTo;->aSymbPointsEqu)
		APPEND TO ARRAY:C911(aSymbol;__ ("NL"))
		APPEND TO ARRAY:C911(aSymbDesc;__ ("No logrado"))
		APPEND TO ARRAY:C911(aSymbGradeFrom;rGradesFrom)
		APPEND TO ARRAY:C911(aSymbGradeTo;rGradesMinimum-rGradesInterval)
		APPEND TO ARRAY:C911(aSymbGradesEqu;rGradesMinimum-rGradesInterval)
		APPEND TO ARRAY:C911(aSymbPointsFrom;rPointsFrom)
		APPEND TO ARRAY:C911(aSymbPointsTo;rPointsMinimum-rGradesInterval)
		APPEND TO ARRAY:C911(aSymbPointsEqu;rPointsMinimum-rGradesInterval)
		APPEND TO ARRAY:C911(aSymbPctFrom;1)
		APPEND TO ARRAY:C911(aSymbPctTo;49)
		APPEND TO ARRAY:C911(aSymbPctEqu;49)
		
		
		APPEND TO ARRAY:C911(aSymbol;__ ("L"))
		APPEND TO ARRAY:C911(aSymbDesc;__ ("Logrado"))
		APPEND TO ARRAY:C911(aSymbGradeFrom;rGradesMinimum)
		APPEND TO ARRAY:C911(aSymbGradeTo;rGradesTo)
		APPEND TO ARRAY:C911(aSymbGradesEqu;rGradesTo)
		APPEND TO ARRAY:C911(aSymbPointsFrom;rPointsMinimum)
		APPEND TO ARRAY:C911(aSymbPointsTo;rPointsTo)
		APPEND TO ARRAY:C911(aSymbPointsEqu;rPointsTo)
		APPEND TO ARRAY:C911(aSymbPctFrom;50)
		APPEND TO ARRAY:C911(aSymbPctTo;50)
		APPEND TO ARRAY:C911(aSymbPctEqu;100)
		
		EVS_WriteStyleData 
		
		
		EVS_LoadStyles 
		
		
		
		
		$l_fila:=Find in array:C230(aEvStyleId;$l_idEstilo)
		LISTBOX SELECT ROW:C912(*;"lbEstilos";$l_fila)
		EVS_CargaEstiloEvaluacion ($l_idEstilo)
		vl_LastEvStyleRecNum:=Record number:C243([xxSTR_EstilosEvaluacion:44])
		
		
	: ($t_accion="duplicar")
		C_LONGINT:C283($l_fila;$l_idEstilo)
		C_TEXT:C284($t_nombreEstilo)
		
		READ WRITE:C146([xxSTR_EstilosEvaluacion:44])
		GOTO RECORD:C242([xxSTR_EstilosEvaluacion:44];aEvStyleRecNo{aEvStyleRecNo})
		EVS_WriteStyleData 
		GOTO RECORD:C242([xxSTR_EstilosEvaluacion:44];aEvStyleRecNo{aEvStyleRecNo})
		
		If (Position:C15(" [#";[xxSTR_EstilosEvaluacion:44]Name:2)>0)
			$t_nombreEstilo:=Substring:C12([xxSTR_EstilosEvaluacion:44]Name:2;1;Position:C15(" [#";[xxSTR_EstilosEvaluacion:44]Name:2)-1)
		Else 
			$t_nombreEstilo:=[xxSTR_EstilosEvaluacion:44]Name:2
		End if 
		
		DUPLICATE RECORD:C225([xxSTR_EstilosEvaluacion:44])
		[xxSTR_EstilosEvaluacion:44]Auto_UUID:23:=Generate UUID:C1066
		[xxSTR_EstilosEvaluacion:44]ID:1:=SQ_SeqNumber (->[xxSTR_EstilosEvaluacion:44]ID:1)
		[xxSTR_EstilosEvaluacion:44]Name:2:=$t_nombreEstilo+" [#"+String:C10([xxSTR_EstilosEvaluacion:44]ID:1)+"]"
		[xxSTR_EstilosEvaluacion:44]Created_By:6:=<>lUSR_CurrentUserID
		[xxSTR_EstilosEvaluacion:44]secs_creation:5:=SYS_DateTime2Secs (Current date:C33(*);Current time:C178(*);1)
		[xxSTR_EstilosEvaluacion:44]secs_modification:8:=[xxSTR_EstilosEvaluacion:44]secs_creation:5
		[xxSTR_EstilosEvaluacion:44]Modified_By:9:=[xxSTR_EstilosEvaluacion:44]Created_By:6
		SAVE RECORD:C53([xxSTR_EstilosEvaluacion:44])
		$l_idEstilo:=[xxSTR_EstilosEvaluacion:44]ID:1
		EVS_WriteStyleData 
		UNLOAD RECORD:C212([xxSTR_EstilosEvaluacion:44])
		
		EVS_LoadStyles 
		$l_fila:=Find in array:C230(aEvStyleId;$l_idEstilo)
		LISTBOX SELECT ROW:C912(*;"lbEstilos";$l_fila)
		EVS_CargaEstiloEvaluacion ($l_idEstilo)
		vl_LastEvStyleRecNum:=Record number:C243([xxSTR_EstilosEvaluacion:44])
		
		
	: ($t_accion="eliminar")
		KRL_GotoRecord (->[xxSTR_EstilosEvaluacion:44];aEvStyleRecNo{aEvStyleRecNo};True:C214)
		QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_de_EstiloEvaluacion:39=[xxSTR_EstilosEvaluacion:44]ID:1)
		If (Records in selection:C76([Asignaturas:18])>0)
			$r:=CD_Dlog (0;__ ("Este estilo es utilizado en algunas asignaturas. No es posible eliminarlo."))
		Else 
			DELETE RECORD:C58([xxSTR_EstilosEvaluacion:44])
			READ ONLY:C145([xxSTR_EstilosEvaluacion:44])
			ALL RECORDS:C47([xxSTR_EstilosEvaluacion:44])
			EVS_LoadStyles 
			LISTBOX SELECT ROW:C912(*;"lbEstilos";1)
			aEvStyleRecNo:=1
			KRL_GotoRecord (->[xxSTR_EstilosEvaluacion:44];aEvStyleRecNo{aEvStyleRecNo})
			EVS_CargaEstiloEvaluacion ([xxSTR_EstilosEvaluacion:44]ID:1)
			vl_LastEvStyleRecNum:=Record number:C243([xxSTR_EstilosEvaluacion:44])
			
		End if 
		
	: ($t_accion="restaurar")
		$l_idEstilo:=aEvStyleId{aEvStyleId}
		UNLOAD RECORD:C212([xxSTR_EstilosEvaluacion:44])
		READ ONLY:C145([xxSTR_EstilosEvaluacion:44])
		
		IN_LoadEvaluationStyles 
		
		EVS_LoadStyles 
		READ WRITE:C146([xxSTR_EstilosEvaluacion:44])
		QUERY:C277([xxSTR_EstilosEvaluacion:44];[xxSTR_EstilosEvaluacion:44]ID:1=$l_idEstilo)
		EVS_CargaEstiloEvaluacion ($l_idEstilo)
		OBJECT SET VISIBLE:C603(*;"DescEsfuerzo";(cb_EvaluaEsfuerzo=1))
		vl_LastEvStyleRecNum:=Record number:C243([xxSTR_EstilosEvaluacion:44])
		
		
	: ($t_accion="rasgos")
		READ WRITE:C146([xxSTR_Constants:1])
		LOAD RECORD:C52([xxSTR_Constants:1])
		WDW_OpenFormWindow (->[xxSTR_EstilosEvaluacion:44];"EvaluacionValorica";-1;8;__ ("Rasgos de Personalidad");"wdwclosedlog")
		DIALOG:C40([xxSTR_EstilosEvaluacion:44];"EvaluacionValorica")
		CLOSE WINDOW:C154
		KRL_ReloadAsReadOnly (->[xxSTR_Constants:1])
		
		
	: ($t_accion="actividades")
		WDW_OpenFormWindow (->[xxSTR_EstilosEvaluacion:44];"EvaluacionActividades";-1;8;__ ("Descriptores para actividades extraprogramáticas");"wdwCloseDlog")
		DIALOG:C40([xxSTR_EstilosEvaluacion:44];"EvaluacionActividades")
		CLOSE WINDOW:C154
		
		
	: ($t_accion="imprimir")
		FORM SET OUTPUT:C54([xxSTR_EstilosEvaluacion:44];"PrintDetail")
		
		vs_refMode:=aEvStoreMode{aEvStoreMode}
		vs_EvMode:=aEvMode{aEvMode}
		vs_printMode:=aEvPrintMode{aEvPrintMode}
		vs_viewMode:=aEvViewMode{aEvViewMode}
		vs_actasMode:=aEvActas{aEvActas}
		
		C_DATE:C307(vd_fecha)
		vd_fecha:=Current date:C33
		
		Case of 
			: (r1=1)
				Case of 
					: ((vi_gTrPAvg=1) & (vi_gTrFAvg=1))
						vs_metodo:="Promedios periódicos y promedio final troncados."
					: ((vi_gTrPAvg=1) & (vi_gTrFAvg=0))
						vs_metodo:="Promedios periódicos troncados y promedio final aproximado."
					: ((vi_gTrPAvg=0) & (vi_gTrFAvg=1))
						vs_metodo:="Promedios periódicos aproximados y promedio final troncado."
					: ((vi_gTrPAvg=0) & (vi_gTrFAvg=0))
						vs_metodo:="Promedios periódicos y promedio final aproximados."
				End case 
			: (r2=1)
				vs_metodo:="Suma de calificaciones."
			: (r3=1)
				vs_metodo:="Resultado final no calculado (ingresable)."
		End case 
		
		
		PRINT RECORD:C71([xxSTR_EstilosEvaluacion:44])
End case 

