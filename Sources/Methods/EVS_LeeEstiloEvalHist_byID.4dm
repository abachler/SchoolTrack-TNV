//%attributes = {}
  //EVS_LeeEstiloEvalHist_byID
C_LONGINT:C283(vl_EstiloHistoricoEnMemoria)

$idEstilo:=$1

If (vl_EstiloHistoricoEnMemoria#$idEstilo)
	EVS_initialize 
	$blob:=KRL_GetBlobFieldData (->[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3;->$idEstilo;->[xxSTR_HistoricoEstilosEval:88]xData:6)
	
	$result:=EVS_LeeEstiloEvalHistorico ($blob)
	If ($result=0)
		vl_EstiloHistoricoEnMemoria:=0
		EVS_initialize 
	Else 
		vl_EstiloHistoricoEnMemoria:=$idEstilo
	End if 
End if 