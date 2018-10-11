//%attributes = {}
  // MÉTODO: UD_v20110729_EstilosHistoricos
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 01/08/11, 10:28:24
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // UD_v20110729_EstilosHistoricos()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES



  // CODIGO PRINCIPAL
ALL RECORDS:C47([xxSTR_HistoricoEstilosEval:88])

QUERY:C277([xxSTR_HistoricoEstilosEval:88];[xxSTR_HistoricoEstilosEval:88]Año:2=2008)
DISTINCT VALUES:C339([xxSTR_HistoricoEstilosEval:88]Año:2;$al_Years)

ARRAY LONGINT:C221($al_IDActual;0)
ARRAY LONGINT:C221($al_IDReplacement;0)

For ($i;1;Size of array:C274($al_Years))
	QUERY:C277([xxSTR_HistoricoEstilosEval:88];[xxSTR_HistoricoEstilosEval:88]Año:2=$al_Years{$i})
	SELECTION TO ARRAY:C260([xxSTR_HistoricoEstilosEval:88]ID_EstiloOriginal:4;$al_IDEstiloOriginal;[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3;$al_IdRegistroHistorico)
	SORT ARRAY:C229($al_IDEstiloOriginal;$al_IdRegistroHistorico;>)
	For ($ii;Size of array:C274($al_IDEstiloOriginal);1;-1)
		If ($al_IDEstiloOriginal{$ii}=$al_IDEstiloOriginal{$ii-1})
			$l_idTokeep:=$al_IdRegistroHistorico{$ii}
			
			  //20111004 RCH Se cambia if porque podia dar error de indices dentro del while
			  //While ($al_IDEstiloOriginal{$ii}=$al_IDEstiloOriginal{$ii-1})
			$vb_continuar:=False:C215
			If ($ii>1)
				If ($al_IDEstiloOriginal{$ii}=$al_IDEstiloOriginal{$ii-1})
					$vb_continuar:=True:C214
				End if 
			End if 
			While ($vb_continuar)
				$id:=$al_IdRegistroHistorico{$ii}
				KRL_FindAndLoadRecordByIndex (->[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3;->$id;True:C214)
				DELETE RECORD:C58([xxSTR_HistoricoEstilosEval:88])
				APPEND TO ARRAY:C911($al_IDActual;$al_IdRegistroHistorico{$ii-1})
				APPEND TO ARRAY:C911($al_IDReplacement;$l_idTokeep)
				$ii:=$ii-1
				$vb_continuar:=False:C215
				If ($ii>1)
					If ($al_IDEstiloOriginal{$ii}=$al_IDEstiloOriginal{$ii-1})
						$vb_continuar:=True:C214
					End if 
				End if 
			End while 
			
		End if 
	End for 
End for 


For ($i;1;Size of array:C274($al_IDActual))
	READ WRITE:C146([Asignaturas_Historico:84])
	QUERY:C277([Asignaturas_Historico:84];[Asignaturas_Historico:84]ID_EstiloEvalAsignatura:25;=;$al_IDActual{$i})
	APPLY TO SELECTION:C70([Asignaturas_Historico:84];[Asignaturas_Historico:84]ID_EstiloEvalAsignatura:25:=$al_IDReplacement{$i})
	
	READ WRITE:C146([xxSTR_HistoricoNiveles:191])
	QUERY:C277([xxSTR_HistoricoNiveles:191];[xxSTR_HistoricoNiveles:191]ID_EstiloEvaluacionInterno:8;=;$al_IDActual{$i})
	APPLY TO SELECTION:C70([xxSTR_HistoricoNiveles:191];[xxSTR_HistoricoNiveles:191]ID_EstiloEvaluacionInterno:8:=$al_IDReplacement{$i})
	
	READ WRITE:C146([xxSTR_HistoricoNiveles:191])
	QUERY:C277([xxSTR_HistoricoNiveles:191];[xxSTR_HistoricoNiveles:191]Id_EstiloEvaluacionOficial:9;=;$al_IDActual{$i})
	APPLY TO SELECTION:C70([xxSTR_HistoricoNiveles:191];[xxSTR_HistoricoNiveles:191]Id_EstiloEvaluacionOficial:9:=$al_IDReplacement{$i})
	
End for 



QUERY:C277([Asignaturas_Historico:84];[Asignaturas_Historico:84]ID_EstiloEvalAsignatura:25#0)
DISTINCT VALUES:C339([Asignaturas_Historico:84]ID_EstiloEvalAsignatura:25;$aIds)
For ($i;1;Size of array:C274($aIds))
	QUERY:C277([xxSTR_HistoricoEstilosEval:88];[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3;=;$aIds{$i})
	If (Records in selection:C76([xxSTR_HistoricoEstilosEval:88])=0)
		QUERY:C277([Asignaturas_Historico:84];[Asignaturas_Historico:84]ID_EstiloEvalAsignatura:25=$aIds{$i})
		APPLY TO SELECTION:C70([Asignaturas_Historico:84];[Asignaturas_Historico:84]ID_EstiloEvalAsignatura:25:=0)
	End if 
End for 


QUERY:C277([xxSTR_HistoricoNiveles:191];[xxSTR_HistoricoNiveles:191]ID_EstiloEvaluacionInterno:8#0)
DISTINCT VALUES:C339([xxSTR_HistoricoNiveles:191]ID_EstiloEvaluacionInterno:8;$aIds)
CREATE EMPTY SET:C140([xxSTR_HistoricoNiveles:191];"huachos")
For ($i;1;Size of array:C274($aIds))
	QUERY:C277([xxSTR_HistoricoEstilosEval:88];[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3;=;$aIds{$i})
	If (Records in selection:C76([xxSTR_HistoricoEstilosEval:88])=0)
		QUERY:C277([xxSTR_HistoricoNiveles:191];[xxSTR_HistoricoNiveles:191]ID_EstiloEvaluacionInterno:8=$aIds{$i})
		APPLY TO SELECTION:C70([xxSTR_HistoricoNiveles:191];[xxSTR_HistoricoNiveles:191]ID_EstiloEvaluacionInterno:8:=0)
	End if 
End for 



QUERY:C277([xxSTR_HistoricoNiveles:191];[xxSTR_HistoricoNiveles:191]Id_EstiloEvaluacionOficial:9#0)
DISTINCT VALUES:C339([xxSTR_HistoricoNiveles:191]Id_EstiloEvaluacionOficial:9;$aIds)
For ($i;1;Size of array:C274($aIds))
	QUERY:C277([xxSTR_HistoricoEstilosEval:88];[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3;=;$aIds{$i})
	If (Records in selection:C76([xxSTR_HistoricoEstilosEval:88])=0)
		QUERY:C277([xxSTR_HistoricoNiveles:191];[xxSTR_HistoricoNiveles:191]Id_EstiloEvaluacionOficial:9=$aIds{$i})
		READ WRITE:C146([xxSTR_HistoricoNiveles:191])
		APPLY TO SELECTION:C70([xxSTR_HistoricoNiveles:191];[xxSTR_HistoricoNiveles:191]Id_EstiloEvaluacionOficial:9:=0)
	End if 
End for 


If (<>vtXS_CountryCode="cl")
	  //asignación de ID estilo histórico interno por defecto
	QUERY:C277([xxSTR_HistoricoNiveles:191];[xxSTR_HistoricoNiveles:191]Id_EstiloEvaluacionOficial:9=0)
	ARRAY LONGINT:C221($aRecNums;0)
	LONGINT ARRAY FROM SELECTION:C647([xxSTR_HistoricoNiveles:191];$aRecNums;"")
	For ($i;1;Size of array:C274($aRecNums))
		READ WRITE:C146([xxSTR_HistoricoNiveles:191])
		GOTO RECORD:C242([xxSTR_HistoricoNiveles:191];$aRecNums{$i})
		QUERY:C277([xxSTR_HistoricoEstilosEval:88];[xxSTR_HistoricoEstilosEval:88]Año:2=[xxSTR_HistoricoNiveles:191]Año:2;*)
		QUERY:C277([xxSTR_HistoricoEstilosEval:88]; & ;[xxSTR_HistoricoEstilosEval:88]ID_EstiloOriginal:4=-5)
		[xxSTR_HistoricoNiveles:191]Id_EstiloEvaluacionOficial:9:=[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3
		SAVE RECORD:C53([xxSTR_HistoricoNiveles:191])
	End for 
	KRL_UnloadReadOnly (->[xxSTR_HistoricoNiveles:191])
	
	
	  //asignación de ID estilo histórico interno por defecto
	QUERY:C277([xxSTR_HistoricoNiveles:191];[xxSTR_HistoricoNiveles:191]ID_EstiloEvaluacionInterno:8=0)
	ARRAY LONGINT:C221($aRecNums;0)
	LONGINT ARRAY FROM SELECTION:C647([xxSTR_HistoricoNiveles:191];$aRecNums;"")
	For ($i;1;Size of array:C274($aRecNums))
		READ WRITE:C146([xxSTR_HistoricoNiveles:191])
		GOTO RECORD:C242([xxSTR_HistoricoNiveles:191];$aRecNums{$i})
		QUERY:C277([xxSTR_HistoricoEstilosEval:88];[xxSTR_HistoricoEstilosEval:88]Año:2=[xxSTR_HistoricoNiveles:191]Año:2;*)
		QUERY:C277([xxSTR_HistoricoEstilosEval:88]; & ;[xxSTR_HistoricoEstilosEval:88]ID_EstiloOriginal:4=-5)
		[xxSTR_HistoricoNiveles:191]ID_EstiloEvaluacionInterno:8:=[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3
		SAVE RECORD:C53([xxSTR_HistoricoNiveles:191])
	End for 
	KRL_UnloadReadOnly (->[xxSTR_HistoricoNiveles:191])
	
	
	  //asignación de estilos a asignaturas históricas en que no está definido
	  // solo para Chile, en otros países no tenemos la misma certeza
	If (<>vtXS_CountryCode="cl")
		QUERY:C277([Asignaturas_Historico:84];[Asignaturas_Historico:84]ID_EstiloEvalAsignatura:25=0)
		ARRAY LONGINT:C221($aRecNums;0)
		LONGINT ARRAY FROM SELECTION:C647([Asignaturas_Historico:84];$aRecNums;"")
		
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Verificando estilos de evaluación en históricos de asignaturas...")
		For ($i;1;Size of array:C274($aRecNums))
			READ WRITE:C146([Asignaturas_Historico:84])
			GOTO RECORD:C242([Asignaturas_Historico:84];$aRecNums{$i})
			$estiloActual:=KRL_GetNumericFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_Historico:84]ID_AsignaturaOriginal:30;->[Asignaturas:18]Numero_de_EstiloEvaluacion:39)
			QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_HistoricoAsignatura:493;=;[Asignaturas_Historico:84]ID_RegistroHistorico:1)
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30;$at_EvFinal_Literal;[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;$ar_EvFinal_Real)
			SORT ARRAY:C229($at_EvFinal_Literal;$ar_EvFinal_Real;>)
			For ($ii;Size of array:C274($at_EvFinal_Literal);1;-1)
				If (Num:C11($ar_EvFinal_Real{$ii})<0)
					DELETE FROM ARRAY:C228($at_EvFinal_Literal;$ii)
					DELETE FROM ARRAY:C228($ar_EvFinal_Real;$ii)
				End if 
			End for 
			If (Size of array:C274($at_EvFinal_Literal)>0)
				$t_minimum:=$at_EvFinal_Literal{1}
				$t_maximum:=$at_EvFinal_Literal{Size of array:C274($at_EvFinal_Literal)}
				$r_Minimum:=Num:C11($t_minimum)
				$r_Maximum:=Num:C11($t_maximum)
				Case of 
					: (($r_Minimum>=1) & ($r_Maximum<=7))
						QUERY:C277([xxSTR_HistoricoEstilosEval:88];[xxSTR_HistoricoEstilosEval:88]Año:2=[Asignaturas_Historico:84]Año:5;*)
						QUERY:C277([xxSTR_HistoricoEstilosEval:88]; & ;[xxSTR_HistoricoEstilosEval:88]ID_EstiloOriginal:4=-5)
						[Asignaturas_Historico:84]ID_EstiloEvalAsignatura:25:=[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3
						SAVE RECORD:C53([Asignaturas_Historico:84])
					: (($r_Minimum>=10) & ($r_Maximum<=70))
						QUERY:C277([xxSTR_HistoricoEstilosEval:88];[xxSTR_HistoricoEstilosEval:88]Año:2=[Asignaturas_Historico:84]Año:5;*)
						QUERY:C277([xxSTR_HistoricoEstilosEval:88]; & ;[xxSTR_HistoricoEstilosEval:88]ID_EstiloOriginal:4=-4)
						[Asignaturas_Historico:84]ID_EstiloEvalAsignatura:25:=[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3
						SAVE RECORD:C53([Asignaturas_Historico:84])
					: (($r_Minimum=0) & ($r_Maximum=0))
						QUERY:C277([xxSTR_HistoricoEstilosEval:88];[xxSTR_HistoricoEstilosEval:88]Año:2=[Asignaturas_Historico:84]Año:5;*)
						QUERY:C277([xxSTR_HistoricoEstilosEval:88]; & ;[xxSTR_HistoricoEstilosEval:88]ID_EstiloOriginal:4=-1)
						[Asignaturas_Historico:84]ID_EstiloEvalAsignatura:25:=[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3
						SAVE RECORD:C53([Asignaturas_Historico:84])
					Else 
						
				End case 
			End if 
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aRecNums))
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	End if 
	
	
	UNLOAD RECORD:C212([Asignaturas_Historico:84])
	UNLOAD RECORD:C212([xxSTR_HistoricoNiveles:191])
	READ ONLY:C145([Asignaturas_Historico:84])
	READ ONLY:C145([xxSTR_HistoricoNiveles:191])
	
	
	
End if 




UNLOAD RECORD:C212([Asignaturas_Historico:84])
UNLOAD RECORD:C212([xxSTR_HistoricoNiveles:191])
READ ONLY:C145([Asignaturas_Historico:84])
READ ONLY:C145([xxSTR_HistoricoNiveles:191])





