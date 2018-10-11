//%attributes = {}
  //EVS_EstiloHistoricoPorDefecto

  //Retorna el estilo de evaluación por defecto correspondiente a cada país y lo devuelve como resultado

  //Si el estilo de evaluación histórico para el año pasado en argumento ($1) no existe es copiado desde la configuración del año corriente


C_LONGINT:C283($1;$year;$0;$evStyle)

$year:=$1

Case of 
	: (<>vtXS_CountryCode="cl")
		$evStyle:=-5
End case 

If ($evStyle#0)
	KRL_FindAndLoadRecordByIndex (->[xxSTR_EstilosEvaluacion:44]ID:1;->$evStyle)
	
	QUERY:C277([xxSTR_HistoricoEstilosEval:88];[xxSTR_HistoricoEstilosEval:88]ID_EstiloOriginal:4=[xxSTR_EstilosEvaluacion:44]ID:1;*)
	QUERY:C277([xxSTR_HistoricoEstilosEval:88]; & ;[xxSTR_HistoricoEstilosEval:88]Año:2=$year)
	If (Records in selection:C76([xxSTR_HistoricoEstilosEval:88])=0)
		CREATE RECORD:C68([xxSTR_HistoricoEstilosEval:88])
		[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3:=SQ_SeqNumber (->[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3)
		[xxSTR_HistoricoEstilosEval:88]ID_EstiloOriginal:4:=[xxSTR_EstilosEvaluacion:44]ID:1
		[xxSTR_HistoricoEstilosEval:88]Año:2:=$year
		[xxSTR_HistoricoEstilosEval:88]NombreEstilo:5:=[xxSTR_EstilosEvaluacion:44]Name:2
		[xxSTR_HistoricoEstilosEval:88]xData:6:=[xxSTR_EstilosEvaluacion:44]OT_Data:7
		SAVE RECORD:C53([xxSTR_HistoricoEstilosEval:88])
	End if 
	$0:=[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3
	UNLOAD RECORD:C212([xxSTR_HistoricoEstilosEval:88])
Else 
	$0:=0
End if 

