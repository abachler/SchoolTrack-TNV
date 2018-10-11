If (Self:C308->>0)
	If (alMPA_LimiteAsignacion{Self:C308->}#[MPA_DefinicionCompetencias:187]RestriccionSubsector:3)
		  //busco las matrices asignadas a las asignaturas del area excluyendo la que corresponde a la asignatura seleccionada 
		COPY ARRAY:C226(atMPA_LimiteAsignacion;$aAsignaturas)
		DELETE FROM ARRAY:C228($aAsignaturas;1;1)
		$el:=Find in array:C230($aAsignaturas;atMPA_LimiteAsignacion{atMPA_LimiteAsignacion})
		If ($el>0)
			DELETE FROM ARRAY:C228($aAsignaturas;$el;1)
		End if 
		QUERY WITH ARRAY:C644([Asignaturas:18]Asignatura:3;$aAsignaturas)
		KRL_RelateSelection (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[Asignaturas:18]EVAPR_IdMatriz:91;"")
		
		  //busco los objetos de las matrices que no corresponden a las asignaturas seleccionadas
		KRL_RelateSelection (->[MPA_ObjetosMatriz:204]ID_Matriz:1;->[MPA_AsignaturasMatrices:189]ID_Matriz:1;"")
		  //busco en la selección las competencias que deben ser desligadas de las matrices que no corresponde a la asignatura seleccionada
		QUERY SELECTION:C341([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Competencia:5=[MPA_DefinicionCompetencias:187]ID:1)
		If (Records in selection:C76([MPA_ObjetosMatriz:204])>0)
			KRL_RelateSelection (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[MPA_ObjetosMatriz:204]ID_Matriz:1;"")
			  //$msg:=RP_GetIdxString (21017;183)
			  //$msg:=Replace string($msg;"^0";atMPA_LimiteAsignacion{atMPA_LimiteAsignacion})
			  //$msg:=Replace string($msg;"^1";String(Records in selection([MPA_AsignaturasMatrices])))
			$result:=CD_Dlog (0;Replace string:C233(Replace string:C233(__ ("Si limita el uso de esta Competencia a la asignatura \"^0\" será retirada de las ^1 matrices de evaluación asignadas a las otras asignaturas del área que la incluyen actualmente.\r\r¿Desea realmente limitar el uso de esta Competencia a la asignatura \"");__ ("^0");atMPA_LimiteAsignacion{atMPA_LimiteAsignacion});__ ("^1");String:C10(Records in selection:C76([MPA_AsignaturasMatrices:189])));__ ("");__ ("No");__ ("Si"))
			If ($result=2)
				KRL_RelateSelection (->[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1;->[Asignaturas:18]Numero:1;"")
				QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7=[MPA_DefinicionCompetencias:187]ID:1)
				START TRANSACTION:C239
				OK:=KRL_DeleteSelection (->[Alumnos_EvaluacionAprendizajes:203];False:C215)
				If (OK=1)
					OK:=KRL_DeleteSelection (->[MPA_ObjetosMatriz:204];False:C215)
				End if 
				If (OK=1)
					[MPA_DefinicionCompetencias:187]RestriccionSubsector:3:=alMPA_LimiteAsignacion{Self:C308->}
					SAVE RECORD:C53([MPA_DefinicionCompetencias:187])
					If (cb_AutoActualizaMatricesMPA=1)
						$recNum:=Find in field:C653([MPA_DefinicionAreas:186]ID:1;[MPA_DefinicionCompetencias:187]ID_Area:11)
						MPAcfg_ActualizaMatrices ($recNum;Logro_Aprendizaje;[MPA_DefinicionCompetencias:187]DesdeGrado:5;[MPA_DefinicionCompetencias:187]HastaGrado:13;Record number:C243([MPA_DefinicionCompetencias:187]))
					End if 
					$msg:=__ ("La utilización de la Competencia \"^0\" del Area \"^1\" fue limitada a la asignatura \"^2\". Fue retirada de las matrices de evaluación de las otras asignaturas previa confirmación del usuario.")
					$msg:=Replace string:C233($msg;"^2";atMPA_LimiteAsignacion{atMPA_LimiteAsignacion})
					$msg:=Replace string:C233($msg;"^1";[MPA_DefinicionAreas:186]AreaAsignatura:4)
					$msg:=Replace string:C233($msg;"^0";[MPA_DefinicionCompetencias:187]Competencia:6)
					LOG_RegisterEvt ($msg)
					_O_DISABLE BUTTON:C193(bCancel)
					VALIDATE TRANSACTION:C240
				Else 
					$el:=Find in array:C230(alMPA_LimiteAsignacion;[MPA_DefinicionCompetencias:187]RestriccionSubsector:3)
					If ($el>0)
						atMPA_LimiteAsignacion:=$el
					Else 
						[MPA_DefinicionCompetencias:187]RestriccionSubsector:3:=0
					End if 
					CANCEL TRANSACTION:C241
					CD_Dlog (0;__ ("No es posible realizar esta operación en este momento.\r\rPor favor inténtelo más tarde."))
				End if 
			End if 
		Else 
			[MPA_DefinicionCompetencias:187]RestriccionSubsector:3:=alMPA_LimiteAsignacion{Self:C308->}
			SAVE RECORD:C53([MPA_DefinicionCompetencias:187])
			If (cb_AutoActualizaMatricesMPA=1)
				$recNum:=Find in field:C653([MPA_DefinicionAreas:186]ID:1;[MPA_DefinicionCompetencias:187]ID_Area:11)
				MPAcfg_ActualizaMatrices ($recNum;Logro_Aprendizaje;[MPA_DefinicionCompetencias:187]DesdeGrado:5;[MPA_DefinicionCompetencias:187]HastaGrado:13;Record number:C243([MPA_DefinicionCompetencias:187]))
			End if 
			_O_DISABLE BUTTON:C193(bCancel)
		End if 
	Else 
		[MPA_DefinicionCompetencias:187]RestriccionSubsector:3:=alMPA_LimiteAsignacion{Self:C308->}
		SAVE RECORD:C53([MPA_DefinicionCompetencias:187])
		If (cb_AutoActualizaMatricesMPA=1)
			$recNum:=Find in field:C653([MPA_DefinicionAreas:186]ID:1;[MPA_DefinicionCompetencias:187]ID_Area:11)
			MPAcfg_ActualizaMatrices ($recNum;Logro_Aprendizaje;[MPA_DefinicionCompetencias:187]DesdeGrado:5;[MPA_DefinicionCompetencias:187]HastaGrado:13;Record number:C243([MPA_DefinicionCompetencias:187]))
		End if 
		_O_DISABLE BUTTON:C193(bCancel)
	End if 
End if 