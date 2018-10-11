//%attributes = {}
  //dbu_VerificaSubasignaturas

ALL RECORDS:C47([Asignaturas:18])
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Verificando subasignaturas..."))
While (Not:C34(End selection:C36([Asignaturas:18])))
	PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
	If ([Asignaturas:18]Consolidacion_PorPeriodo:58)
		For ($i_periodo;1;Size of array:C274(atSTR_Periodos_Nombre))
			AS_PropEval_Lectura ("";$i_periodo)
			For ($i_Columna;1;Size of array:C274(alAS_EvalPropSourceID))
				If (alAS_EvalPropSourceID{$i_Columna}<0)
					$ref:=String:C10([Asignaturas:18]Numero:1)+"."+String:C10($i_periodo)+"."+String:C10($i_Columna)
					$recNum:=Find in field:C653([xxSTR_Subasignaturas:83]Referencia:11;$ref)
					If ($recNum<0)
						CREATE RECORD:C68([xxSTR_Subasignaturas:83])
						[xxSTR_Subasignaturas:83]LongID:7:=[Asignaturas:18]Numero:1
						[xxSTR_Subasignaturas:83]Name:2:=atAS_EvalPropSourceName{$i_Columna}
						[xxSTR_Subasignaturas:83]ID_Mother:6:=[Asignaturas:18]Numero:1
						[xxSTR_Subasignaturas:83]Periodo:12:=$i_periodo
						[xxSTR_Subasignaturas:83]Columna:13:=$i_columna
						SAVE RECORD:C53([xxSTR_Subasignaturas:83])
					Else 
						READ WRITE:C146([xxSTR_Subasignaturas:83])
						GOTO RECORD:C242([xxSTR_Subasignaturas:83];$recNum)
						[xxSTR_Subasignaturas:83]LongID:7:=[Asignaturas:18]Numero:1
						[xxSTR_Subasignaturas:83]ID_Mother:6:=[Asignaturas:18]Numero:1
						[xxSTR_Subasignaturas:83]Periodo:12:=$i_periodo
						[xxSTR_Subasignaturas:83]Columna:13:=$i_columna
						SAVE RECORD:C53([xxSTR_Subasignaturas:83])
					End if 
				End if 
			End for 
		End for 
	Else 
		AS_PropEval_Lectura 
		For ($i_Columna;1;Size of array:C274(alAS_EvalPropSourceID))
			If (alAS_EvalPropSourceID{$i_Columna}<0)
				For ($i_periodo;1;Size of array:C274(atSTR_Periodos_Nombre))
					$ref:=String:C10([Asignaturas:18]Numero:1)+"."+String:C10($i_periodo)+"."+String:C10($i_Columna)
					$recNum:=Find in field:C653([xxSTR_Subasignaturas:83]Referencia:11;$ref)
					If ($recNum<0)
						CREATE RECORD:C68([xxSTR_Subasignaturas:83])
						[xxSTR_Subasignaturas:83]LongID:7:=[Asignaturas:18]Numero:1
						[xxSTR_Subasignaturas:83]Name:2:=atAS_EvalPropSourceName{$i_Columna}
						[xxSTR_Subasignaturas:83]ID_Mother:6:=[Asignaturas:18]Numero:1
						[xxSTR_Subasignaturas:83]Periodo:12:=$i_periodo
						[xxSTR_Subasignaturas:83]Columna:13:=$i_columna
						SAVE RECORD:C53([xxSTR_Subasignaturas:83])
					Else 
						READ WRITE:C146([xxSTR_Subasignaturas:83])
						GOTO RECORD:C242([xxSTR_Subasignaturas:83];$recNum)
						[xxSTR_Subasignaturas:83]LongID:7:=[Asignaturas:18]Numero:1
						[xxSTR_Subasignaturas:83]ID_Mother:6:=[Asignaturas:18]Numero:1
						[xxSTR_Subasignaturas:83]Periodo:12:=$i_periodo
						[xxSTR_Subasignaturas:83]Columna:13:=$i_columna
						SAVE RECORD:C53([xxSTR_Subasignaturas:83])
					End if 
				End for 
			End if 
		End for 
	End if 
	NEXT RECORD:C51([Asignaturas:18])
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;Selected record number:C246([Asignaturas:18])/Records in selection:C76([Asignaturas:18]);__ ("Verificando subasignaturas..."))
End while 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)

UNLOAD RECORD:C212([xxSTR_Subasignaturas:83])
READ ONLY:C145([xxSTR_Subasignaturas:83])

SQ_RestauraSecuencias (->[xxSTR_Subasignaturas:83]LongID:7)