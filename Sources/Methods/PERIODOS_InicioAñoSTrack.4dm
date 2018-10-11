//%attributes = {}
  //PERIODOS_InicioAñoSTrack


C_DATE:C307($0;$inicioAño)
$inicioAño:=!32000-12-31!


If (Count parameters:C259=1)
	$year:=$1
Else 
	$year:=<>gYear
End if 

If ($year=<>gYear)
	
	PERIODOS_Init 
	QUERY WITH ARRAY:C644([xxSTR_Niveles:6]NoNivel:5;<>al_NumeroNivelesActivos)
	KRL_RelateSelection (->[xxSTR_Periodos:100]ID:1;->[xxSTR_Niveles:6]ID_ConfiguracionPeriodos:44;"")
	
	SELECTION TO ARRAY:C260([xxSTR_Periodos:100];$aRecNums)
	For ($i;1;Size of array:C274($aRecNums))
		GOTO RECORD:C242([xxSTR_Periodos:100];$aRecNums{$i})
		PERIODOS_LoadData (0;[xxSTR_Periodos:100]ID:1)
		If (Size of array:C274(adSTR_Periodos_Desde)>0)
			If ((adSTR_Periodos_Desde{1}<$inicioAño) & (adSTR_Periodos_Desde{1}>!00-00-00!))
				$inicioAño:=adSTR_Periodos_Desde{1}
			End if 
		End if 
	End for 
	$0:=$inicioAño
	
	
Else 
	
	$year:=$1
	QUERY:C277([xxSTR_HistoricoNiveles:191];[xxSTR_HistoricoNiveles:191]Año:2=$year;*)
	QUERY:C277([xxSTR_HistoricoNiveles:191]; & [xxSTR_HistoricoNiveles:191]InicioAgnoEscolar:17>!00-00-00!)
	ORDER BY:C49([xxSTR_HistoricoNiveles:191]InicioAgnoEscolar:17;>)
	$0:=[xxSTR_HistoricoNiveles:191]InicioAgnoEscolar:17
	
	
End if 


