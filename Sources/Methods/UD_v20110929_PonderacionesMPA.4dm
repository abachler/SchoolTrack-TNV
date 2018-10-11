//%attributes = {}
  // MÉTODO: UD_v20110929_PonderacionesMPA
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 03/10/11, 08:01:09
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // Copia ponderaciones globales a ponderaciones período cuando 
  // la competencia, dimensión o eje se imparte sólo en algunos períodos
  // esto es necesario debido a una inconsistencia en 10.3
  // PARÁMETROS
  // UD_v20110929_PonderacionesMPA()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES



  // CODIGO PRINCIPAL


ARRAY REAL:C219($aPonderacionesG;0)
ARRAY REAL:C219($aPonderacionesP;0)


ALL RECORDS:C47([MPA_AsignaturasMatrices:189])




ARRAY LONGINT:C221($aRecNums;0)
LONGINT ARRAY FROM SELECTION:C647([MPA_AsignaturasMatrices:189];$aRecNums;"")


$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Verificando ponderaciones en matrices de evaluación por competencias...")
For ($i;1;Size of array:C274($aRecNums))
	READ WRITE:C146([MPA_AsignaturasMatrices:189])
	GOTO RECORD:C242([MPA_AsignaturasMatrices:189];$aRecNums{$i})
	
	
	Case of 
		: ([MPA_AsignaturasMatrices:189]BaseCalculoResultado:23=Eje_Aprendizaje)
			  //busco los ejes de la matriz
			QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1=[MPA_AsignaturasMatrices:189]ID_Matriz:1;*)
			QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2=Eje_Aprendizaje)
			CREATE SET:C116([MPA_ObjetosMatriz:204];"ejes")
			
			  //determino si los ejes a evaluar son distintos en los períodos
			ARRAY LONGINT:C221($al_Periodos;0)
			AT_DistinctsFieldValues (->[MPA_ObjetosMatriz:204]Periodos:7;->$al_Periodos)
			$vbMPA_configSegunPeriodo:=False:C215
			If (Size of array:C274($al_Periodos)>0)
				If (Size of array:C274($al_Periodos)>1)
					$vbMPA_configSegunPeriodo:=True:C214
				Else 
					If ($al_Periodos{1}>=2)
						$vbMPA_configSegunPeriodo:=True:C214
					End if 
				End if 
			End if 
			
			
			If ($vbMPA_configSegunPeriodo)
				For ($i_Periodos;1;5)
					USE SET:C118("ejes")
					QUERY SELECTION BY FORMULA:C207([MPA_ObjetosMatriz:204];([MPA_ObjetosMatriz:204]Periodos:7 ?? $i_Periodos))
					If (Records in selection:C76([MPA_ObjetosMatriz:204])>0)
						CREATE SET:C116([MPA_ObjetosMatriz:204];"ejes_periodo")
						Case of 
							: ($i_Periodos=1)
								$fieldPointer:=->[MPA_ObjetosMatriz:204]PonderacionP1_EnResultado:9
							: ($i_Periodos=2)
								$fieldPointer:=->[MPA_ObjetosMatriz:204]PonderacionP2_EnResultado:10
							: ($i_Periodos=3)
								$fieldPointer:=->[MPA_ObjetosMatriz:204]PonderacionP3_EnResultado:11
							: ($i_Periodos=4)
								$fieldPointer:=->[MPA_ObjetosMatriz:204]PonderacionP4_EnResultado:12
							: ($i_Periodos=5)
								$fieldPointer:=->[MPA_ObjetosMatriz:204]PonderacionP5_EnResultado:23
								
						End case 
						SELECTION TO ARRAY:C260([MPA_ObjetosMatriz:204]PonderacionG_EnResultado:8;$aPonderacionesG;$fieldPointer->;$aPonderacionesP)
						$totalPonderacionesG:=AT_GetSumArray (->$aPonderacionesG)
						$totalPonderacionesP:=AT_GetSumArray (->$aPonderacionesP)
						
						If ((($totalPonderacionesP=0) & ($totalPonderacionesG>0)) | (($totalPonderacionesP#$totalPonderacionesG) & ($totalPonderacionesG#0) & ($totalPonderacionesP#0)))
							USE SET:C118("ejes_periodo")
							READ WRITE:C146([MPA_ObjetosMatriz:204])
							While (Not:C34(End selection:C36([MPA_ObjetosMatriz:204])))
								$fieldPointer->:=[MPA_ObjetosMatriz:204]PonderacionG_EnResultado:8
								SAVE RECORD:C53([MPA_ObjetosMatriz:204])
								NEXT RECORD:C51([MPA_ObjetosMatriz:204])
							End while 
							UNLOAD RECORD:C212([MPA_ObjetosMatriz:204])
							READ ONLY:C145([MPA_ObjetosMatriz:204])
						End if 
					End if 
				End for 
			End if 
			
		: ([MPA_AsignaturasMatrices:189]BaseCalculoResultado:23=Dimension_Aprendizaje)
			QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1=[MPA_AsignaturasMatrices:189]ID_Matriz:1;*)
			QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2=Dimension_Aprendizaje)
			CREATE SET:C116([MPA_ObjetosMatriz:204];"dimensiones")
			
			  //determino si los dimensiones a evaluar son distintos en los períodos
			ARRAY LONGINT:C221($al_Periodos;0)
			AT_DistinctsFieldValues (->[MPA_ObjetosMatriz:204]Periodos:7;->$al_Periodos)
			$vbMPA_configSegunPeriodo:=False:C215
			If (Size of array:C274($al_Periodos)>0)
				If (Size of array:C274($al_Periodos)>1)
					$vbMPA_configSegunPeriodo:=True:C214
				Else 
					If ($al_Periodos{1}>=2)
						$vbMPA_configSegunPeriodo:=True:C214
					End if 
				End if 
			End if 
			
			
			If ($vbMPA_configSegunPeriodo)
				For ($i_Periodos;1;5)
					USE SET:C118("dimensiones")
					QUERY SELECTION BY FORMULA:C207([MPA_ObjetosMatriz:204];([MPA_ObjetosMatriz:204]Periodos:7 ?? $i_Periodos))
					If (Records in selection:C76([MPA_ObjetosMatriz:204])>0)
						CREATE SET:C116([MPA_ObjetosMatriz:204];"dimensiones_periodo")
						Case of 
							: ($i_Periodos=1)
								$fieldPointer:=->[MPA_ObjetosMatriz:204]PonderacionP1_EnResultado:9
							: ($i_Periodos=2)
								$fieldPointer:=->[MPA_ObjetosMatriz:204]PonderacionP2_EnResultado:10
							: ($i_Periodos=3)
								$fieldPointer:=->[MPA_ObjetosMatriz:204]PonderacionP3_EnResultado:11
							: ($i_Periodos=4)
								$fieldPointer:=->[MPA_ObjetosMatriz:204]PonderacionP4_EnResultado:12
							: ($i_Periodos=5)
								$fieldPointer:=->[MPA_ObjetosMatriz:204]PonderacionP5_EnResultado:23
								
						End case 
						SELECTION TO ARRAY:C260([MPA_ObjetosMatriz:204]PonderacionG_EnResultado:8;$aPonderacionesG;$fieldPointer->;$aPonderacionesP)
						$totalPonderacionesG:=AT_GetSumArray (->$aPonderacionesG)
						$totalPonderacionesP:=AT_GetSumArray (->$aPonderacionesP)
						
						If ((($totalPonderacionesP=0) & ($totalPonderacionesG>0)) | (($totalPonderacionesP#$totalPonderacionesG) & ($totalPonderacionesG#0) & ($totalPonderacionesP#0)))
							USE SET:C118("dimensiones_periodo")
							READ WRITE:C146([MPA_ObjetosMatriz:204])
							While (Not:C34(End selection:C36([MPA_ObjetosMatriz:204])))
								$fieldPointer->:=[MPA_ObjetosMatriz:204]PonderacionG_EnResultado:8
								SAVE RECORD:C53([MPA_ObjetosMatriz:204])
								NEXT RECORD:C51([MPA_ObjetosMatriz:204])
							End while 
							UNLOAD RECORD:C212([MPA_ObjetosMatriz:204])
							READ ONLY:C145([MPA_ObjetosMatriz:204])
						End if 
					End if 
				End for 
			End if 
			
			
		: ([MPA_AsignaturasMatrices:189]BaseCalculoResultado:23=Logro_Aprendizaje)
			QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1=[MPA_AsignaturasMatrices:189]ID_Matriz:1;*)
			QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2=Logro_Aprendizaje)
			CREATE SET:C116([MPA_ObjetosMatriz:204];"competencias")
			
			  //determino si los competencias a evaluar son distintos en los períodos
			ARRAY LONGINT:C221($al_Periodos;0)
			AT_DistinctsFieldValues (->[MPA_ObjetosMatriz:204]Periodos:7;->$al_Periodos)
			vbMPA_competenciasSegunPeriodo:=False:C215
			If (Size of array:C274($al_Periodos)>1)
				$vbMPA_configSegunPeriodo:=True:C214
			End if 
			
			If ($vbMPA_configSegunPeriodo)
				For ($i_Periodos;1;5)
					USE SET:C118("competencias")
					QUERY SELECTION BY FORMULA:C207([MPA_ObjetosMatriz:204];([MPA_ObjetosMatriz:204]Periodos:7 ?? $i_Periodos))
					If (Records in selection:C76([MPA_ObjetosMatriz:204])>0)
						CREATE SET:C116([MPA_ObjetosMatriz:204];"competencias_periodo")
						Case of 
							: ($i_Periodos=1)
								$fieldPointer:=->[MPA_ObjetosMatriz:204]PonderacionP1_EnResultado:9
							: ($i_Periodos=2)
								$fieldPointer:=->[MPA_ObjetosMatriz:204]PonderacionP2_EnResultado:10
							: ($i_Periodos=3)
								$fieldPointer:=->[MPA_ObjetosMatriz:204]PonderacionP3_EnResultado:11
							: ($i_Periodos=4)
								$fieldPointer:=->[MPA_ObjetosMatriz:204]PonderacionP4_EnResultado:12
							: ($i_Periodos=5)
								$fieldPointer:=->[MPA_ObjetosMatriz:204]PonderacionP5_EnResultado:23
								
						End case 
						SELECTION TO ARRAY:C260([MPA_ObjetosMatriz:204]PonderacionG_EnResultado:8;$aPonderacionesG;$fieldPointer->;$aPonderacionesP)
						$totalPonderacionesG:=AT_GetSumArray (->$aPonderacionesG)
						$totalPonderacionesP:=AT_GetSumArray (->$aPonderacionesP)
						
						If (($totalPonderacionesP=0) & ($totalPonderacionesG>0))
							USE SET:C118("competencias_periodo")
							READ WRITE:C146([MPA_ObjetosMatriz:204])
							While (Not:C34(End selection:C36([MPA_ObjetosMatriz:204])))
								$fieldPointer->:=[MPA_ObjetosMatriz:204]PonderacionG_EnResultado:8
								SAVE RECORD:C53([MPA_ObjetosMatriz:204])
							End while 
							UNLOAD RECORD:C212([MPA_ObjetosMatriz:204])
							READ ONLY:C145([MPA_ObjetosMatriz:204])
						End if 
					End if 
				End for 
			End if 
	End case 
	
	
	
	Case of 
		: ([MPA_AsignaturasMatrices:189]ModoCalculoEjes:10=Dimension_Aprendizaje)
			QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1=[MPA_AsignaturasMatrices:189]ID_Matriz:1;*)
			QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2=Eje_Aprendizaje)
			ARRAY LONGINT:C221($aIds;0)
			SELECTION TO ARRAY:C260([MPA_ObjetosMatriz:204]ID_Eje:3;$aIds)
			
			For ($i_Ejes;1;Size of array:C274($aIds))
				QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1=[MPA_AsignaturasMatrices:189]ID_Matriz:1;*)
				QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2=Dimension_Aprendizaje;*)
				QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]ID_Eje:3=$aIds{$i_Ejes})
				CREATE SET:C116([MPA_ObjetosMatriz:204];"dimensiones")
				
				  //determino si los competencias a evaluar son distintos en los diferentes períodos
				ARRAY LONGINT:C221($al_Periodos;0)
				AT_DistinctsFieldValues (->[MPA_ObjetosMatriz:204]Periodos:7;->$al_Periodos)
				$vbMPA_configSegunPeriodo:=False:C215
				If (Size of array:C274($al_Periodos)>0)
					If (Size of array:C274($al_Periodos)>1)
						$vbMPA_configSegunPeriodo:=True:C214
					Else 
						If ($al_Periodos{1}>=2)
							$vbMPA_configSegunPeriodo:=True:C214
						End if 
					End if 
				End if 
				
				If ($vbMPA_configSegunPeriodo)
					For ($i_Periodos;1;5)
						USE SET:C118("dimensiones")
						QUERY SELECTION BY FORMULA:C207([MPA_ObjetosMatriz:204];([MPA_ObjetosMatriz:204]Periodos:7 ?? $i_Periodos))
						If (Records in selection:C76([MPA_ObjetosMatriz:204])>0)
							CREATE SET:C116([MPA_ObjetosMatriz:204];"dimensiones_periodo")
							Case of 
								: ($i_Periodos=1)
									$fieldPointer:=->[MPA_ObjetosMatriz:204]PonderacionP1_EnEje:14
								: ($i_Periodos=2)
									$fieldPointer:=->[MPA_ObjetosMatriz:204]PonderacionP2_EnEje:15
								: ($i_Periodos=3)
									$fieldPointer:=->[MPA_ObjetosMatriz:204]PonderacionP3_EnEje:16
								: ($i_Periodos=4)
									$fieldPointer:=->[MPA_ObjetosMatriz:204]PonderacionP4_EnEje:17
								: ($i_Periodos=5)
									$fieldPointer:=->[MPA_ObjetosMatriz:204]PonderacionP5_EnEje:24
									
							End case 
							SELECTION TO ARRAY:C260([MPA_ObjetosMatriz:204]PonderacionG_EnEje:13;$aPonderacionesG;$fieldPointer->;$aPonderacionesP)
							$totalPonderacionesG:=AT_GetSumArray (->$aPonderacionesG)
							$totalPonderacionesP:=AT_GetSumArray (->$aPonderacionesP)
							If ((($totalPonderacionesP=0) & ($totalPonderacionesG>0)) | (($totalPonderacionesP#$totalPonderacionesG) & ($totalPonderacionesG#0) & ($totalPonderacionesP#0)))
								USE SET:C118("dimensiones_periodo")
								READ WRITE:C146([MPA_ObjetosMatriz:204])
								While (Not:C34(End selection:C36([MPA_ObjetosMatriz:204])))
									$fieldPointer->:=[MPA_ObjetosMatriz:204]PonderacionG_EnEje:13
									SAVE RECORD:C53([MPA_ObjetosMatriz:204])
									NEXT RECORD:C51([MPA_ObjetosMatriz:204])
								End while 
								UNLOAD RECORD:C212([MPA_ObjetosMatriz:204])
								READ ONLY:C145([MPA_ObjetosMatriz:204])
							End if 
						End if 
					End for 
				End if 
			End for 
			
			
		: ([MPA_AsignaturasMatrices:189]ModoCalculoEjes:10=Logro_Aprendizaje)
			QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1=[MPA_AsignaturasMatrices:189]ID_Matriz:1;*)
			QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2=Eje_Aprendizaje)
			ARRAY LONGINT:C221($aIds;0)
			SELECTION TO ARRAY:C260([MPA_ObjetosMatriz:204]ID_Eje:3;$aIds)
			
			For ($i_Ejes;1;Size of array:C274($aIds))
				QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1=[MPA_AsignaturasMatrices:189]ID_Matriz:1;*)
				QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2=Logro_Aprendizaje;*)
				QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]ID_Eje:3=$aIds{$i_Ejes})
				CREATE SET:C116([MPA_ObjetosMatriz:204];"competencias")
				
				  //determino si los competencias a evaluar son distintos en los diferentes períodos
				ARRAY LONGINT:C221($al_Periodos;0)
				AT_DistinctsFieldValues (->[MPA_ObjetosMatriz:204]Periodos:7;->$al_Periodos)
				$vbMPA_configSegunPeriodo:=False:C215
				If (Size of array:C274($al_Periodos)>0)
					If (Size of array:C274($al_Periodos)>1)
						$vbMPA_configSegunPeriodo:=True:C214
					Else 
						If ($al_Periodos{1}>=2)
							$vbMPA_configSegunPeriodo:=True:C214
						End if 
					End if 
				End if 
				
				
				If ($vbMPA_configSegunPeriodo)
					For ($i_Periodos;1;5)
						USE SET:C118("competencias")
						QUERY SELECTION BY FORMULA:C207([MPA_ObjetosMatriz:204];([MPA_ObjetosMatriz:204]Periodos:7 ?? $i_Periodos))
						If (Records in selection:C76([MPA_ObjetosMatriz:204])>0)
							CREATE SET:C116([MPA_ObjetosMatriz:204];"competencias_periodo")
							Case of 
								: ($i_Periodos=1)
									$fieldPointer:=->[MPA_ObjetosMatriz:204]PonderacionP1_EnEje:14
								: ($i_Periodos=2)
									$fieldPointer:=->[MPA_ObjetosMatriz:204]PonderacionP2_EnEje:15
								: ($i_Periodos=3)
									$fieldPointer:=->[MPA_ObjetosMatriz:204]PonderacionP3_EnEje:16
								: ($i_Periodos=4)
									$fieldPointer:=->[MPA_ObjetosMatriz:204]PonderacionP4_EnEje:17
								: ($i_Periodos=5)
									$fieldPointer:=->[MPA_ObjetosMatriz:204]PonderacionP5_EnEje:24
									
							End case 
							SELECTION TO ARRAY:C260([MPA_ObjetosMatriz:204]PonderacionG_EnEje:13;$aPonderacionesG;$fieldPointer->;$aPonderacionesP)
							$totalPonderacionesG:=AT_GetSumArray (->$aPonderacionesG)
							$totalPonderacionesP:=AT_GetSumArray (->$aPonderacionesP)
							If ((($totalPonderacionesP=0) & ($totalPonderacionesG>0)) | (($totalPonderacionesP#$totalPonderacionesG) & ($totalPonderacionesG#0) & ($totalPonderacionesP#0)))
								USE SET:C118("competencias_periodo")
								READ WRITE:C146([MPA_ObjetosMatriz:204])
								While (Not:C34(End selection:C36([MPA_ObjetosMatriz:204])))
									$fieldPointer->:=[MPA_ObjetosMatriz:204]PonderacionG_EnEje:13
									SAVE RECORD:C53([MPA_ObjetosMatriz:204])
									NEXT RECORD:C51([MPA_ObjetosMatriz:204])
								End while 
								UNLOAD RECORD:C212([MPA_ObjetosMatriz:204])
								READ ONLY:C145([MPA_ObjetosMatriz:204])
							End if 
						End if 
					End for 
				End if 
			End for 
			
	End case 
	
	
	
	
	
	
	
	
	  //si las dimensiones son calculadas sobre la base de competencias
	  // verifico las ponderaciones en cada período
	If ([MPA_AsignaturasMatrices:189]ModoCalculoDimensiones:6=Logro_Aprendizaje)
		QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1=[MPA_AsignaturasMatrices:189]ID_Matriz:1;*)
		QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2=Dimension_Aprendizaje)
		ARRAY LONGINT:C221($aIds;0)
		SELECTION TO ARRAY:C260([MPA_ObjetosMatriz:204]ID_Dimension:4;$aIds)
		
		For ($i_Dimensiones;1;Size of array:C274($aIds))
			QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1=[MPA_AsignaturasMatrices:189]ID_Matriz:1;*)
			QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2=Logro_Aprendizaje;*)
			QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]ID_Dimension:4=$aIds{$i_Dimensiones})
			CREATE SET:C116([MPA_ObjetosMatriz:204];"competencias")
			
			  //determino si los competencias a evaluar son distintos en los diferentes períodos
			ARRAY LONGINT:C221($al_Periodos;0)
			AT_DistinctsFieldValues (->[MPA_ObjetosMatriz:204]Periodos:7;->$al_Periodos)
			vbMPA_competenciasSegunPeriodo:=False:C215
			If (Size of array:C274($al_Periodos)>1)
				$vbMPA_configSegunPeriodo:=True:C214
				If ($al_Periodos{1}>=2)
					$vbMPA_configSegunPeriodo:=True:C214
				End if 
			End if 
			
			If ($vbMPA_configSegunPeriodo)
				For ($i_Periodos;1;5)
					USE SET:C118("competencias")
					QUERY SELECTION BY FORMULA:C207([MPA_ObjetosMatriz:204];([MPA_ObjetosMatriz:204]Periodos:7 ?? $i_Periodos))
					If (Records in selection:C76([MPA_ObjetosMatriz:204])>0)
						CREATE SET:C116([MPA_ObjetosMatriz:204];"competencias_periodo")
						Case of 
							: ($i_Periodos=1)
								$fieldPointer:=->[MPA_ObjetosMatriz:204]PonderacionP1_EnDimension:19
							: ($i_Periodos=2)
								$fieldPointer:=->[MPA_ObjetosMatriz:204]PonderacionP2_EnDimension:20
							: ($i_Periodos=3)
								$fieldPointer:=->[MPA_ObjetosMatriz:204]PonderacionP3_EnDimension:21
							: ($i_Periodos=4)
								$fieldPointer:=->[MPA_ObjetosMatriz:204]PonderacionP4_EnDimension:22
							: ($i_Periodos=5)
								$fieldPointer:=->[MPA_ObjetosMatriz:204]PonderacionP5_EnDimension:25
								
						End case 
						SELECTION TO ARRAY:C260([MPA_ObjetosMatriz:204]PonderacionG_EnDimension:18;$aPonderacionesG;$fieldPointer->;$aPonderacionesP)
						$totalPonderacionesG:=AT_GetSumArray (->$aPonderacionesG)
						$totalPonderacionesP:=AT_GetSumArray (->$aPonderacionesP)
						If ((($totalPonderacionesP=0) & ($totalPonderacionesG>0)) | (($totalPonderacionesP#$totalPonderacionesG) & ($totalPonderacionesG#0) & ($totalPonderacionesP#0)))
							USE SET:C118("competencias_periodo")
							READ WRITE:C146([MPA_ObjetosMatriz:204])
							While (Not:C34(End selection:C36([MPA_ObjetosMatriz:204])))
								$fieldPointer->:=[MPA_ObjetosMatriz:204]PonderacionG_EnDimension:18
								SAVE RECORD:C53([MPA_ObjetosMatriz:204])
								NEXT RECORD:C51([MPA_ObjetosMatriz:204])
							End while 
							UNLOAD RECORD:C212([MPA_ObjetosMatriz:204])
							READ ONLY:C145([MPA_ObjetosMatriz:204])
						End if 
					End if 
				End for 
			End if 
			
			
		End for 
	End if 
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aRecNums))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)


KRL_UnloadReadOnly (->[MPA_AsignaturasMatrices:189])

