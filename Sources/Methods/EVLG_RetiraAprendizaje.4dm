//%attributes = {}
  //EVLG_RetiraAprendizaje

  //`xShell, Alberto Bachler
  //Metodo: Método: EVLG_RetiraEjeAprendizaje
  //Por abachler
  //Creada el 23/09/2005, 08:00:18
  //Modificaciones:
If ("DESCRIPCION"="")
	  //elimina o inicializa los registro de evaluaciones de ejes y aprendizajes que se retiran de la matriz
	  // los registros de definición de ejes y aprendizajes son eliminados o marcados para no ser utilizados en la evaluación del período seleccionado
End if 

  //****DECLARACIONES****
C_LONGINT:C283($1;$2;$3;$recNumAsignaturaActual;$ejesEvaluados;$logrosEvaluados)

  //****INICIALIZACIONES****
$idMatriz:=$1
$id:=$2
$refPeriodo:=$3
$tipoObjeto:=$4

ARRAY TEXT:C222($at_TextArray;0)
ARRAY LONGINT:C221($al_LongintArray;0)
ARRAY REAL:C219($ar_ArrayReal;0)


  //****CUERPO****
If (Not:C34(Semaphore:C143("UsoMatrizLogros"+String:C10($idMatriz))))
	
	  // buscamos ejes y logros de la matriz seleccionada
	QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1;=;$idMatriz)
	Case of 
		: ($tipoObjeto=Eje_Aprendizaje)
			QUERY SELECTION:C341([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Eje:3=$id)
		: ($tipoObjeto=Dimension_Aprendizaje)
			QUERY SELECTION:C341([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Dimension:4=$id)
		: ($tipoObjeto=Logro_Aprendizaje)
			QUERY SELECTION:C341([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Competencia:5=$id)
	End case 
	
	If ($refPeriodo=0)
		$b_ObjectoConPonderacion:=([MPA_ObjetosMatriz:204]PonderacionG_EnResultado:8#0)
	Else 
		Case of 
			: ($refPeriodo=1)
				$b_ObjectoConPonderacion:=([MPA_ObjetosMatriz:204]PonderacionP1_EnResultado:9#0)
			: ($refPeriodo=2)
				$b_ObjectoConPonderacion:=([MPA_ObjetosMatriz:204]PonderacionP2_EnResultado:10#0)
			: ($refPeriodo=3)
				$b_ObjectoConPonderacion:=([MPA_ObjetosMatriz:204]PonderacionP3_EnResultado:11#0)
			: ($refPeriodo=4)
				$b_ObjectoConPonderacion:=([MPA_ObjetosMatriz:204]PonderacionP4_EnResultado:12#0)
			: ($refPeriodo=5)
				$b_ObjectoConPonderacion:=([MPA_ObjetosMatriz:204]PonderacionP5_EnResultado:23#0)
		End case 
	End if 
	
	$b_Continuar:=True:C214
	If ($b_ObjectoConPonderacion)
		$l_action:=CD_Dlog (0;__ ("El enunciado seleccionado tiene asignada una ponderación. \r\r¿Desea realmente retirar un enunciado de una matriz de evaluación de aprendizajes aun teniendo una ponderación asignada?");__ ("");__ ("No");__ ("Si"))
		If ($l_action=1)
			$b_Continuar:=False:C215
		End if 
	End if 
	
	If ($b_Continuar)
		CREATE SET:C116([MPA_ObjetosMatriz:204];"ObjetosMatriz")
		
		  // buscamos eventuales ejes y aprendizajes evaluados en las asignaturas que utilizan esta matriz
		$readonlyState:=Read only state:C362([Asignaturas:18])
		$recNumAsignaturaActual:=Record number:C243([Asignaturas:18])  // preservo el rec num de la asignatura para volver a ella al terminar
		
		
		  // ejes evaluados
		READ ONLY:C145([Asignaturas:18])
		QUERY:C277([Asignaturas:18];[Asignaturas:18]EVAPR_IdMatriz:91=$idMatriz)
		KRL_RelateSelection (->[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1;->[Asignaturas:18]Numero:1;"")
		Case of 
			: ($tipoObjeto=Eje_Aprendizaje)
				QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5=$id)
			: ($tipoObjeto=Dimension_Aprendizaje)
				QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6=$id)
			: ($tipoObjeto=Logro_Aprendizaje)
				QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7=$id)
		End case 
		CREATE SET:C116([Alumnos_EvaluacionAprendizajes:203];"EvaluacionesAEliminar")
		QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63>0;*)
		QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Año:77=<>gYear)
		CREATE SET:C116([Alumnos_EvaluacionAprendizajes:203];"EvaluacionesAInicializar")
		$aprendizajesEvaluados:=Records in selection:C76([Alumnos_EvaluacionAprendizajes:203])
		
		If ($aprendizajesEvaluados>0)
			$action:=CD_Dlog (0;__ ("Algunos de los items que desea retirar ya han sido evaluados. Si continúa las evaluaciones existentes serán ser eliminadas.\r\r¿Esta usted seguro de que es lo quiere hacer?");__ ("");__ ("No");__ ("Si"))
		Else 
			$action:=2
		End if 
		
		
		If ($action=2)
			$bitPeriodo:=0
			$bitPeriodo:=$bitPeriodo ?+ $refPeriodo
			If (($refPeriodo=0) | ([MPA_ObjetosMatriz:204]Periodos:7=$bitPeriodo))
				START TRANSACTION:C239
				  // si aprendizajes y ejes se utilizan en todo el período, simplemente se eliminan en la matriz y se eliminan los registros de evaluación correspondientes
				USE SET:C118("EvaluacionesAEliminar")
				OK:=KRL_DeleteSelection (->[Alumnos_EvaluacionAprendizajes:203])
				
				If (OK=1)
					USE SET:C118("ObjetosMatriz")
					KRL_DeleteSelection (->[MPA_ObjetosMatriz:204])
				End if 
				
				If (OK=1)
					VALIDATE TRANSACTION:C240
					KRL_FindAndLoadRecordByIndex (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->$idMatriz)
					If (([MPA_AsignaturasMatrices:189]BaseCalculoResultado:23>=Logro_Aprendizaje) | ([MPA_AsignaturasMatrices:189]ModoCalculoEjes:10>=Logro_Aprendizaje) | ([MPA_AsignaturasMatrices:189]ModoCalculoDimensiones:6=Logro_Aprendizaje))
						QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2;=;$idMatriz;*)
						QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & [Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63;>;0)
						If (Records in selection:C76([Alumnos_EvaluacionAprendizajes:203])>0)
							$b_CalculoResultadoFinal:=([MPA_AsignaturasMatrices:189]BaseCalculoResultado:23>=Logro_Aprendizaje)
							$b_CalculoEjes:=([MPA_AsignaturasMatrices:189]ModoCalculoEjes:10>=Logro_Aprendizaje)
							$b_CalculoDimensiones:=([MPA_AsignaturasMatrices:189]ModoCalculoDimensiones:6=Logro_Aprendizaje)
							MPA_Recalculos_Matriz ($idMatriz;$b_CalculoResultadoFinal;$b_CalculoEjes;$b_CalculoDimensiones;True:C214)
						End if 
					End if 
				Else 
					CANCEL TRANSACTION:C241
				End if 
				
			Else 
				
				START TRANSACTION:C239
				  // si los aprendizajes y ejes se utilizan en un período determinado, se inicializan las evaluaciones registradas en el período seleccionado
				Case of 
					: ($refPeriodo=1)
						USE SET:C118("EvaluacionesAInicializar")
						AT_RedimArrays (0;->$at_TextArray;->$ar_ArrayReal)
						AT_RedimArrays (Records in selection:C76([Alumnos_EvaluacionAprendizajes:203]);->$at_TextArray;->$ar_ArrayReal)
						OK:=KRL_Array2Selection (->$at_TextArray;->[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13;->$ar_ArrayReal;->[Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11;->$at_TextArray;->[Alumnos_EvaluacionAprendizajes:203]Periodo1_Indicador:14;->$ar_ArrayReal;->[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoNumerico:12)
						
					: ($refPeriodo=2)
						USE SET:C118("EvaluacionesAInicializar")
						AT_RedimArrays (0;->$at_TextArray;->$ar_ArrayReal)
						AT_RedimArrays (Records in selection:C76([Alumnos_EvaluacionAprendizajes:203]);->$at_TextArray;->$ar_ArrayReal)
						OK:=KRL_Array2Selection (->$at_TextArray;->[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25;->$ar_ArrayReal;->[Alumnos_EvaluacionAprendizajes:203]Periodo2_Real:23;->$at_TextArray;->[Alumnos_EvaluacionAprendizajes:203]Periodo2_Indicador:26;->$ar_ArrayReal;->[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoNumerico:24)
						
						
					: ($refPeriodo=3)
						USE SET:C118("EvaluacionesAInicializar")
						AT_RedimArrays (0;->$at_TextArray;->$ar_ArrayReal)
						AT_RedimArrays (Records in selection:C76([Alumnos_EvaluacionAprendizajes:203]);->$at_TextArray;->$ar_ArrayReal)
						OK:=KRL_Array2Selection (->$at_TextArray;->[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37;->$ar_ArrayReal;->[Alumnos_EvaluacionAprendizajes:203]Periodo3_Real:35;->$at_TextArray;->[Alumnos_EvaluacionAprendizajes:203]Periodo3_Indicador:38;->$ar_ArrayReal;->[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoNumerico:36)
						
					: ($refPeriodo=4)
						USE SET:C118("EvaluacionesAInicializar")
						AT_RedimArrays (0;->$at_TextArray;->$ar_ArrayReal)
						AT_RedimArrays (Records in selection:C76([Alumnos_EvaluacionAprendizajes:203]);->$at_TextArray;->$ar_ArrayReal)
						OK:=KRL_Array2Selection (->$at_TextArray;->[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49;->$ar_ArrayReal;->[Alumnos_EvaluacionAprendizajes:203]Periodo4_Real:47;->$at_TextArray;->[Alumnos_EvaluacionAprendizajes:203]Periodo4_Indicador:50;->$ar_ArrayReal;->[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoNumerico:48)
						
					: ($refPeriodo=5)
						USE SET:C118("EvaluacionesAInicializar")
						AT_RedimArrays (0;->$at_TextArray;->$ar_ArrayReal)
						AT_RedimArrays (Records in selection:C76([Alumnos_EvaluacionAprendizajes:203]);->$at_TextArray;->$ar_ArrayReal)
						OK:=KRL_Array2Selection (->$at_TextArray;->[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66;->$ar_ArrayReal;->[Alumnos_EvaluacionAprendizajes:203]Periodo5_Real:64;->$at_TextArray;->[Alumnos_EvaluacionAprendizajes:203]Periodo5_Indicador:67;->$ar_ArrayReal;->[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoNumerico:65)
						
				End case 
				
				If (OK=1)
					  // ponemos el cero el bit de ejes y aprendizajes de la matriz que indican que el son es utilizados en el periodo seleccionado
					USE SET:C118("ObjetosMatriz")
					ARRAY LONGINT:C221($aRecNums;0)
					LONGINT ARRAY FROM SELECTION:C647([MPA_ObjetosMatriz:204];$aRecNums;"")
					For ($i;1;Size of array:C274($aRecNums))
						READ WRITE:C146([MPA_ObjetosMatriz:204])
						KRL_GotoRecord (->[MPA_ObjetosMatriz:204];$aRecNums{$i})
						If (OK=1)
							$oldBytePeriod:=[MPA_ObjetosMatriz:204]Periodos:7
							If ([MPA_ObjetosMatriz:204]Periodos:7 ?? 0)  //si estaba habilitado para todos los períodos
								[MPA_ObjetosMatriz:204]Periodos:7:=[MPA_ObjetosMatriz:204]Periodos:7 ?- 0
								For ($iPeriodos;1;Size of array:C274(atSTR_Periodos_Nombre))  // activo todos los períodos
									[MPA_ObjetosMatriz:204]Periodos:7:=[MPA_ObjetosMatriz:204]Periodos:7 ?+ $iPeriodos
								End for 
							End if 
							[MPA_ObjetosMatriz:204]Periodos:7:=[MPA_ObjetosMatriz:204]Periodos:7 ?- $refPeriodo  // desactivo el período actual
							SAVE RECORD:C53([MPA_ObjetosMatriz:204])
							
							Case of 
								: ([MPA_ObjetosMatriz:204]Tipo_Objeto:2=Eje_Aprendizaje)
									QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5=[MPA_ObjetosMatriz:204]ID_Eje:3;*)
								: ([MPA_ObjetosMatriz:204]Tipo_Objeto:2=Dimension_Aprendizaje)
									QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6=[MPA_ObjetosMatriz:204]ID_Dimension:4;*)
								: ([MPA_ObjetosMatriz:204]Tipo_Objeto:2=Logro_Aprendizaje)
									QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7=[MPA_ObjetosMatriz:204]ID_Competencia:5;*)
							End case 
							QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=[MPA_ObjetosMatriz:204]Tipo_Objeto:2)
							ARRAY LONGINT:C221($aLong;Records in selection:C76([Alumnos_EvaluacionAprendizajes:203]))
							AT_Populate (->$aLong;->[MPA_ObjetosMatriz:204]Periodos:7)
							OK:=KRL_Array2Selection (->$aLong;->[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10)
							If (OK=0)
								$i:=Size of array:C274($aRecNums)
							End if 
						End if 
					End for 
				End if 
				If (OK=1)
					VALIDATE TRANSACTION:C240
					KRL_FindAndLoadRecordByIndex (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->$idMatriz)
					If (([MPA_AsignaturasMatrices:189]BaseCalculoResultado:23>=Logro_Aprendizaje) | ([MPA_AsignaturasMatrices:189]ModoCalculoEjes:10>=Logro_Aprendizaje) | ([MPA_AsignaturasMatrices:189]ModoCalculoDimensiones:6=Logro_Aprendizaje))
						QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2;=;$idMatriz;*)
						  //QUERY([Alumnos_EvaluacionAprendizajes]; & [Alumnos_EvaluacionAprendizajes]PeriodosEvaluados_bitField;=;True)
						QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & [Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63;=;0)
						If (Records in selection:C76([Alumnos_EvaluacionAprendizajes:203])>0)
							$b_CalculoResultadoFinal:=([MPA_AsignaturasMatrices:189]BaseCalculoResultado:23>=Logro_Aprendizaje)
							$b_CalculoEjes:=([MPA_AsignaturasMatrices:189]ModoCalculoEjes:10>=Logro_Aprendizaje)
							$b_CalculoDimensiones:=([MPA_AsignaturasMatrices:189]ModoCalculoDimensiones:6=Logro_Aprendizaje)
							MPA_Recalculos_Matriz ($idMatriz;$b_CalculoResultadoFinal;$b_CalculoEjes;$b_CalculoDimensiones;True:C214)
						End if 
					End if 
				Else 
					CANCEL TRANSACTION:C241
				End if 
				
			End if 
			
			  // volvemos al registro de la asignatura
			  //  ` volvemos al registro de la asignatura (si estamos confurando una asignatura especifica)
			If ($recNumAsignaturaActual>=0)
				If (Not:C34($readonlyState))
					READ WRITE:C146([Asignaturas:18])
				End if 
				GOTO RECORD:C242([Asignaturas:18];$recNumAsignaturaActual)
			End if 
			
			
			
		End if 
	End if 
	CLEAR SEMAPHORE:C144("UsoMatrizLogros"+String:C10($idMatriz))
Else 
	CD_Dlog (0;__ ("Esta matriz de evaluación está siendo utilizada por otro usuario. No es posible modificarla ahora. \rPor favor inténtelo más tarde."))
End if 


  //****LIMPIEZA****
REDUCE SELECTION:C351([Alumnos_EvaluacionAprendizajes:203];0)
REDUCE SELECTION:C351([MPA_ObjetosMatriz:204];0)
SET_ClearSets ("EvaluacionesAInicializar";"EvaluacionesAEliminar";"ObjetosMatriz")


