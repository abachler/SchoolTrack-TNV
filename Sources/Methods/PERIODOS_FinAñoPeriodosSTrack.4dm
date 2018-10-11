//%attributes = {}
  //PERIODOS_FinAñoPeriodosSTrack


C_DATE:C307($0;$endYear)

If (Count parameters:C259=1)
	$year:=$1
Else 
	$year:=<>gYear
End if 

If ($year=<>gYear)
	  //20151229 ASM Ticket  153040
	  //If (Records in selection([xxSTR_Periodos])>0)
	$l_RecNumPeriodo:=Record number:C243([xxSTR_Periodos:100])
	  //End if 
	
	PERIODOS_Init 
	QUERY WITH ARRAY:C644([xxSTR_Niveles:6]NoNivel:5;<>al_NumeroNivelesActivos)
	KRL_RelateSelection (->[xxSTR_Periodos:100]ID:1;->[xxSTR_Niveles:6]ID_ConfiguracionPeriodos:44;"")
	
	SELECTION TO ARRAY:C260([xxSTR_Periodos:100];$aRecNums)
	For ($i;1;Size of array:C274($aRecNums))
		GOTO RECORD:C242([xxSTR_Periodos:100];$aRecNums{$i})
		PERIODOS_LoadData (0;[xxSTR_Periodos:100]ID:1)
		If (Size of array:C274(adSTR_Periodos_Desde)>0)
			If (adSTR_Periodos_Hasta{Size of array:C274(adSTR_Periodos_Hasta)}>$endYear)
				$endYear:=adSTR_Periodos_Hasta{Size of array:C274(adSTR_Periodos_Hasta)}
			End if 
		End if 
	End for 
	$0:=$endYear
	
	  //If ($l_RecNumPeriodo#-1)
	  //GOTO RECORD([xxSTR_Periodos];$l_RecNumPeriodo)
	  //End if 
	If (($l_RecNumPeriodo#Record number:C243([xxSTR_Periodos:100])) & ($l_RecNumPeriodo>=0))  //MONO ticket 195257
		GOTO RECORD:C242([xxSTR_Periodos:100];$l_RecNumPeriodo)
		PERIODOS_LoadData (0;[xxSTR_Periodos:100]ID:1)
	End if 
	
Else 
	
	$year:=$1
	QUERY:C277([xxSTR_HistoricoNiveles:191];[xxSTR_HistoricoNiveles:191]Año:2=$year;*)
	QUERY:C277([xxSTR_HistoricoNiveles:191]; & [xxSTR_HistoricoNiveles:191]TerminoAgnoEscolar:18>!00-00-00!)
	ORDER BY:C49([xxSTR_HistoricoNiveles:191]TerminoAgnoEscolar:18;<)
	$0:=[xxSTR_HistoricoNiveles:191]TerminoAgnoEscolar:18
	
	
End if 