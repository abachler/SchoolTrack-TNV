//%attributes = {}
  // MÉTODO: MPAdbu_Recalculos
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 21/12/11, 12:52:25
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // MPAdbu_Recalculos()
  // ----------------------------------------------------
C_BLOB:C604($1)
C_LONGINT:C283($0)
C_BLOB:C604($x_recNumArray;$x_ArreglosRecalculos)
C_BOOLEAN:C305($b_CalculoDimensiones;$b_CalculoEjes;$b_CalculoResultadoFinal;$b_Convertir_a_Notas;$b_Promediosmodificados;$b_startNewProcess)
_O_C_INTEGER:C282($i_alumnos;$i_Asignaturas;$i_Dimensiones;$i_Ejes;$i_Periodos)
C_LONGINT:C283($i;$l_CompetenciasEvaluadas;$l_count;$l_DimensionesEvaluadas;$l_EjesEvaluados;$l_IdAsignatura;$l_IdEstiloEvaluacion;$l_IDMatriz)
C_LONGINT:C283($l_modoCalculoDimensiones;$l_modoCalculoEjes;$l_ModoCalculoFinales;$l_NivelNumero;$l_ProgresProcID;$l_totalIterations;$l_PromediosModificados)
C_REAL:C285($r_progress1;$r_progress2)
C_TEXT:C284($t_key;$t_Progress1;$t_progress2;$t_thermoAsignatura)

ARRAY LONGINT:C221($al_alumnos_IDs;0)
ARRAY LONGINT:C221($al_AlumnosRecalculo;0)
ARRAY LONGINT:C221($al_AsignaturaRecalculo;0)
ARRAY LONGINT:C221($al_Id_asignaturas;0)
ARRAY LONGINT:C221($al_ID_EstiloEvaluacion;0)
ARRAY LONGINT:C221($al_ID_MatrizMPA;0)
ARRAY LONGINT:C221($al_NumeroNivel;0)
ARRAY LONGINT:C221($al_RecNumAsignaturas;0)
ARRAY LONGINT:C221($aRecNumAsignaturas;0)
ARRAY TEXT:C222($at_Curso_Asignaturas;0)
ARRAY TEXT:C222($at_CursosRecalculo;0)
ARRAY TEXT:C222($at_Dimension_Nombre;0)
ARRAY TEXT:C222($at_Ejes_Nombre;0)
ARRAY TEXT:C222($at_Nombre_Asignaturas;0)
ARRAY TEXT:C222($at_NombreAlumno;0)
ARRAY LONGINT:C221($al_RecNumDimensiones;0)
ARRAY LONGINT:C221($al_RecNumEjes;0)

If (False:C215)
	C_BLOB:C604(MPAdbu_Recalculos ;$1)
End if 





  // CODIGO PRINCIPAL
READ ONLY:C145(*)

  // determino la selección de asignaturas para las que se recalcularán promedios
If (Count parameters:C259>=1)
	  // si se recibió un parametro
	$x_recNumArray:=$1
	If (BLOB size:C605($x_recNumArray)>0)
		  // si se recibió un blob y el blob contiene datos creo la selección de asignaturas a partir de los recnums contenidos en el arreglo
		BLOB_Blob2Vars (->$x_recNumArray;0;->$aRecNumAsignaturas)
		CREATE SELECTION FROM ARRAY:C640([Asignaturas:18];$aRecNumAsignaturas)
		QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]EVAPR_IdMatriz:91>0)
	Else 
		  // si el blob no tiene datos el recalculo se aplica a todas las asignaturas que tienen asignada una matriz de evaluacion de aprendizajes
		QUERY:C277([Asignaturas:18];[Asignaturas:18]EVAPR_IdMatriz:91>0)
	End if 
	
Else 
	  // si el método fue llamado sin parámetros el recalculo se aplica a todas las asignaturas que tienen asignada una matriz de evaluacion de aprendizajes
	QUERY:C277([Asignaturas:18];[Asignaturas:18]EVAPR_IdMatriz:91>0)
End if 

  // ABK inicializo períodos y estilos de evaluación en (para evitar errores si se ejecuta en un proceso nuevo)
PERIODOS_Init 
EVS_initialize 

  // asigno los valores por defecto a los flags que indican que objetos recalcular
$b_CalculoResultadoFinal:=True:C214
$b_CalculoEjes:=True:C214
$b_CalculoDimensiones:=True:C214

Case of 
	: (Count parameters:C259=5)
		$b_startNewProcess:=$5
		$b_CalculoDimensiones:=$4
		$b_CalculoEjes:=$3
		$b_CalculoResultadoFinal:=$2
		
	: (Count parameters:C259=4)
		$b_CalculoDimensiones:=$4
		$b_CalculoEjes:=$3
		$b_CalculoResultadoFinal:=$2
		
	: (Count parameters:C259=3)
		$b_CalculoEjes:=$3
		$b_CalculoResultadoFinal:=$2
		
	: (Count parameters:C259=2)
		$b_CalculoResultadoFinal:=$2
		
	: (Count parameters:C259=1)
		
	: (Count parameters:C259=0)
		
End case 


  // reduzco la seleccion de asignaturas solo a aquellas que efectivamente cuentan con registros de evaluuacion de aprendizajes efectivamente evaluados

CREATE SET:C116([Asignaturas:18];"$selección")
REDUCE SELECTION:C351([Alumnos_EvaluacionAprendizajes:203];0)
RELATE MANY SELECTION:C340([Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1)
QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63>0)
RELATE ONE SELECTION:C349([Alumnos_EvaluacionAprendizajes:203];[Asignaturas:18])
CREATE SET:C116([Asignaturas:18];"$conAprendizajesEvaluados")

DIFFERENCE:C122("$seleccion";"$conAprendizajesEvaluados";"$sinAprendizajesEvaluados")
USE SET:C118("$sinAprendizajesEvaluados")
KRL_RelateSelection (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[Asignaturas:18]EVAPR_IdMatriz:91)
QUERY SELECTION:C341([MPA_AsignaturasMatrices:189];[MPA_AsignaturasMatrices:189]Convertir_a_Notas:9=True:C214)
SELECTION TO ARRAY:C260([MPA_AsignaturasMatrices:189]ID_Matriz:1;$al_ID_matrices)
USE SET:C118("$sinAprendizajesEvaluados")
QUERY SELECTION WITH ARRAY:C1050([Asignaturas:18]EVAPR_IdMatriz:91;$al_ID_matrices)
CREATE SET:C116([Asignaturas:18];"$borrarPromediosAprendizajes")
SELECTION TO ARRAY:C260([Asignaturas:18]denominacion_interna:16;$a_asignaturas;[Asignaturas:18]Curso:5;$a_cursos)


USE SET:C118("$conAprendizajesEvaluados")
If (Records in selection:C76([Asignaturas:18])>0)
	MPA_Calculos_DIM_onServer (-1)  //* solo para inicializar Estilos y periodos en el proceso gemelo del cliente en el server
	
	  // ordeno las asignaturas y pongo la información necesaria al recalculo en arreglos para evitar la carga de registros
	ORDER BY:C49([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6;>;[Asignaturas:18]Curso:5;>;[Asignaturas:18]denominacion_interna:16)
	SELECTION TO ARRAY:C260([Asignaturas:18];$al_RecNumAsignaturas;[Asignaturas:18]Numero:1;$al_Id_asignaturas;[Asignaturas:18]EVAPR_IdMatriz:91;$al_ID_MatrizMPA;[Asignaturas:18]Numero_del_Nivel:6;$al_NumeroNivel;[Asignaturas:18]Numero_de_EstiloEvaluacion:39;$al_ID_EstiloEvaluacion;[Asignaturas:18]denominacion_interna:16;$at_Nombre_Asignaturas;[Asignaturas:18]Curso:5;$at_Curso_Asignaturas)
	
	$l_ProgresProcID:=IT_Progress (1;0;0;"Recalculando evaluaciones de aprendizajes...")
	
	  // para cada asignatura en la selección
	For ($i_Asignaturas;1;Size of array:C274($al_RecNumAsignaturas))
		$l_IdAsignatura:=$al_Id_asignaturas{$i_Asignaturas}
		$r_progress1:=$i_Asignaturas/Size of array:C274($al_RecNumAsignaturas)
		$t_Progress1:="Recalculando evaluaciones de aprendizajes...\r"+$at_Nombre_Asignaturas{$i_Asignaturas}
		
		SET QUERY LIMIT:C395(1)
		SET QUERY DESTINATION:C396(Into variable:K19:4;$l_CompetenciasEvaluadas)
		
		  // determino el número de registros de evaluación de aprendizajes evaluados
		  // para poder determinar si efectivamente es necesario recalcular algo
		QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1;=;$l_IdAsignatura;*)
		QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;=;Logro_Aprendizaje;*)
		QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63;>;0)
		
		SET QUERY DESTINATION:C396(Into variable:K19:4;$l_DimensionesEvaluadas)
		QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1;=;$l_IdAsignatura;*)
		QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;=;Dimension_Aprendizaje;*)
		QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63;>;0)
		
		SET QUERY DESTINATION:C396(Into variable:K19:4;$l_EjesEvaluados)
		QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1;=;$l_IdAsignatura;*)
		QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;=;Eje_Aprendizaje;*)
		QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63;>;0)
		
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		SET QUERY LIMIT:C395(0)
		
		  // si hay registros evaluados inicio el recalculo para cada asignatura
		If (($l_CompetenciasEvaluadas+$l_DimensionesEvaluadas+$l_EjesEvaluados)>0)
			$l_IDMatriz:=$al_ID_MatrizMPA{$i_Asignaturas}
			$l_IdEstiloEvaluacion:=$al_ID_EstiloEvaluacion{$i_Asignaturas}
			
			  //obtengo la configuración actual de calculo finales, ejes y dimensiones
			$l_modoCalculoDimensiones:=KRL_GetNumericFieldData (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->$l_IDMatriz;->[MPA_AsignaturasMatrices:189]ModoCalculoDimensiones:6)
			$l_modoCalculoEjes:=KRL_GetNumericFieldData (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->$l_IDMatriz;->[MPA_AsignaturasMatrices:189]ModoCalculoEjes:10)
			$l_ModoCalculoFinales:=KRL_GetNumericFieldData (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->$l_IDMatriz;->[MPA_AsignaturasMatrices:189]BaseCalculoResultado:23)
			$b_Convertir_a_Notas:=KRL_GetBooleanFieldData (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->$l_IDMatriz;->[MPA_AsignaturasMatrices:189]Convertir_a_Notas:9)
			
			
			
			$l_NivelNumero:=KRL_GetNumericFieldData (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->$l_IDMatriz;->[MPA_AsignaturasMatrices:189]NumeroNivel:4)
			PERIODOS_LoadData ($l_NivelNumero)
			
			
			  // CALCULO DE DIMENSIONES BASADAS EN COMPETENCIAS
			  // si las dimensiones se calculan sobre la base de las evaluaciones de competencias
			  // y los argumentos recibidos indican que se debe calcular las dimensiones
			  // se inicia el recalculo de dimensiones en la asignatura
			  //If (($b_CalculoDimensiones) & ($l_modoCalculoDimensiones=Logro_Aprendizaje))
			
			If ($l_modoCalculoDimensiones=Logro_Aprendizaje)
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1;=;$l_IdAsignatura)
				QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6;#;0;*)
				QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;=;Dimension_Aprendizaje)
				CREATE SET:C116([Alumnos_EvaluacionAprendizajes:203];"$dimensiones")
				$l_totalIterations:=Records in set:C195("$dimensiones")*viSTR_Periodos_NumeroPeriodos
				
				  // para cada período
				$l_count:=0
				For ($i_Periodos;1;viSTR_Periodos_NumeroPeriodos)
					
					  //busco solo las dimensiones utilizadas en el período
					USE SET:C118("$dimensiones")
					QUERY SELECTION BY FORMULA:C207([Alumnos_EvaluacionAprendizajes:203];([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? $i_Periodos) | ([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? 0) | ([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10=0))
					SET FIELD RELATION:C919([Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6;Automatic:K51:4;Structure configuration:K51:2)
					ORDER BY:C49([Alumnos_EvaluacionAprendizajes:203];[MPA_DefinicionDimensiones:188]EstiloEvaluacion:11;>;[MPA_DefinicionDimensiones:188]AlphaSort:8;>)
					SELECTION TO ARRAY:C260([Alumnos_EvaluacionAprendizajes:203];$al_RecNumDimensiones;[MPA_DefinicionDimensiones:188]Dimensión:4;$at_Dimension_Nombre;[MPA_DefinicionDimensiones:188]TipoEvaluacion:15;$al_TipoCalculo;[MPA_DefinicionDimensiones:188]EstiloEvaluacion:11;$al_EstiloEvaluacion;[MPA_DefinicionDimensiones:188]Escala_Minimo:12;$ar_escalaMinimo;[MPA_DefinicionDimensiones:188]Escala_Maximo:13;$ar_EscalaMaximo)
					SET FIELD RELATION:C919([Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6;Structure configuration:K51:2;Structure configuration:K51:2)
					
					  // ejecuto el recalculo de las dimensiones
					For ($i_Dimensiones;1;Size of array:C274($al_RecNumDimensiones))
						$l_count:=$l_count+1
						$r_progress2:=$l_count/$l_totalIterations
						$t_progress2:=$at_Dimension_Nombre{$i_Dimensiones}
						MPA_Calculos_DIM_onServer ($al_RecNumDimensiones{$i_Dimensiones};$i_Periodos;$al_TipoCalculo{$i_Dimensiones};$al_EstiloEvaluacion{$i_Dimensiones};$ar_escalaMinimo{$i_Dimensiones};$ar_EscalaMaximo{$i_Dimensiones})
						$l_ProgresProcID:=IT_Progress (0;$l_ProgresProcID;$r_progress1;$t_Progress1;$r_progress2;$t_Progress2)
					End for 
					
				End for 
			End if 
			
			
			
			
			
			  // CALCULO DE EJES BASADOS EN COMPETENCIAS O DIMENSIONES
			  // si los ejes se calculan sobre la base de las evaluaciones de competencias O DIMENSIONES
			  // y los argumentos recibidos indican que se debe calcular las ejes
			  // se inicia el recalculo de ejes en la asignatura
			  //If (($b_CalculoEjes) & ($l_modoCalculoEjes>=Dimension_Aprendizaje))
			If ($l_modoCalculoEjes>=Dimension_Aprendizaje)
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1;=;$l_IdAsignatura)
				QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5;#;0;*)
				QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;=;Eje_Aprendizaje)
				CREATE SET:C116([Alumnos_EvaluacionAprendizajes:203];"$ejes")
				$l_totalIterations:=Records in set:C195("$ejes")*viSTR_Periodos_NumeroPeriodos
				
				  // para cada período
				$l_count:=0
				For ($i_Periodos;1;viSTR_Periodos_NumeroPeriodos)
					
					  //busco solo los ejes utilizados en el período
					USE SET:C118("$ejes")
					QUERY SELECTION BY FORMULA:C207([Alumnos_EvaluacionAprendizajes:203];([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? $i_Periodos) | ([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? 0) | ([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10=0))
					SET FIELD RELATION:C919([Alumnos_EvaluacionAprendizajes:203]ID_Eje:5;Automatic:K51:4;Structure configuration:K51:2)
					ORDER BY:C49([Alumnos_EvaluacionAprendizajes:203];[MPA_DefinicionEjes:185]EstiloEvaluación:13;>;[MPA_DefinicionEjes:185]AlphaSort:21;>)
					SELECTION TO ARRAY:C260([Alumnos_EvaluacionAprendizajes:203];$al_RecNumEjes;[MPA_DefinicionEjes:185]Nombre:3;$at_Ejes_Nombre;[MPA_DefinicionEjes:185]TipoEvaluación:12;$al_TipoCalculo;[MPA_DefinicionEjes:185]EstiloEvaluación:13;$al_EstiloEvaluacion;[MPA_DefinicionEjes:185]Escala_Minimo:17;$ar_escalaMinimo;[MPA_DefinicionEjes:185]Escala_Maximo:18;$ar_EscalaMaximo)
					SET FIELD RELATION:C919([Alumnos_EvaluacionAprendizajes:203]ID_Eje:5;Structure configuration:K51:2;Structure configuration:K51:2)
					
					  // ejecuto el recalculo de los ejes
					For ($i_Ejes;1;Size of array:C274($al_RecNumEjes))
						MPA_Calculos_EJE_onServer ($al_RecNumEjes{$i_Ejes};$i_Periodos;$al_TipoCalculo{$i_Ejes};$al_EstiloEvaluacion{$i_Ejes};$ar_escalaMinimo{$i_Ejes};$ar_EscalaMaximo{$i_Ejes})
						$l_count:=$l_count+1
						$r_progress2:=$l_count/$l_totalIterations
						$t_progress2:=$at_ejes_Nombre{$i_ejes}
						$l_ProgresProcID:=IT_Progress (0;$l_ProgresProcID;$r_progress1;$t_Progress1;$r_progress2;$t_Progress2)
					End for 
				End for 
			End if 
			
			
			
			
			
			  // CALCULO DE RESULTADOS FINALES DE EVALUACION DE APRENDIZAJES 
			  // si los argumentos recibidos y la matriz de evaluación de la asignatura establece que los resultados finales (almacenados en [Alumnos_ComplementoEvaluacion])
			  // deben ser recalculados
			  //If (($b_CalculoResultadoFinal) & ($l_ModoCalculoFinales>=Eje_Aprendizaje))
			
			If ($l_ModoCalculoFinales>=Eje_Aprendizaje)
				  // cargo la asignatura
				KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->$l_IdAsignatura)
				$t_thermoAsignatura:=[Asignaturas:18]denominacion_interna:16
				EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
				
				  // busco los alumnos de la asignatura
				QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5;=;[Asignaturas:18]Numero:1)
				KRL_RelateSelection (->[Alumnos:2]numero:1;->[Alumnos_Calificaciones:208]ID_Alumno:6;"")
				SELECTION TO ARRAY:C260([Alumnos:2]numero:1;$al_alumnos_IDs;[Alumnos:2]apellidos_y_nombres:40;$at_NombreAlumno)
				
				  // para cada alumno
				For ($i_alumnos;1;Size of array:C274($al_alumnos_IDs))
					
					  // calculos los resultados finales en cada período
					For ($i_Periodos;1;viSTR_Periodos_NumeroPeriodos)
						MPA_Calculos_FinalP_onServer ([Asignaturas:18]Numero:1;$al_alumnos_IDs{$i_alumnos};$i_Periodos)
					End for 
					
					  // si la matriz indica que hay que convertir los resultados finales de la evaluacion de aprendizaje
					  // en notas en los registros [alumnos_calificaciones
					If ($b_Convertir_a_Notas)
						
						AS_PropEval_Lectura ("";1)  // solo para obtener las opciones de consolidación de examenes
						
						  // calculo los promedios en la tabla [Alumnos_calificaciones]
						$t_key:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10([Asignaturas:18]Numero_del_Nivel:6)+"."+String:C10([Asignaturas:18]Numero:1)+"."+String:C10($al_alumnos_IDs{$i_alumnos})
						$b_Promediosmodificados:=MPA_Aprendizajes_a_Notas ($l_IDMatriz;$t_key)
						
						  // si hubo modificación de promedios agrego los elementos actuales a los arreglos para la creación de tareas de recalculo de promedios generales
						If ($b_PromediosModificados)
							$l_PromediosModificados:=$l_PromediosModificados+1
							If (Find in array:C230($al_AlumnosRecalculo;$al_alumnos_IDs{$i_alumnos})<0)
								APPEND TO ARRAY:C911($al_AlumnosRecalculo;$al_alumnos_IDs{$i_alumnos})
							End if 
							If (Find in array:C230($at_CursosRecalculo;$at_Curso_Asignaturas{$i_Asignaturas})<0)
								APPEND TO ARRAY:C911($at_CursosRecalculo;$at_Curso_Asignaturas{$i_Asignaturas})
							End if 
							If (Find in array:C230($al_AsignaturaRecalculo;$al_Id_asignaturas{$i_Asignaturas})<0)
								APPEND TO ARRAY:C911($al_AsignaturaRecalculo;$al_Id_asignaturas{$i_Asignaturas})
							End if 
						End if 
						
						$t_Progress1:="Recalculando promedios sobre evaluaciones de aprendizajes...\r"+$at_Nombre_Asignaturas{$i_Asignaturas}
						$r_Progress2:=$i_alumnos/Size of array:C274($al_alumnos_IDs)
						$t_progress2:=$at_NombreAlumno{$i_alumnos}
						$l_ProgresProcID:=IT_Progress (0;$l_ProgresProcID;$r_progress1;$t_Progress1;$r_progress2;$t_progress2)
					End if 
				End for 
			End if 
		End if 
		
	End for 
	$l_ProgresProcID:=IT_Progress (-1;$l_ProgresProcID)
	
End if 

If (Records in set:C195("$borrarPromediosAprendizajes")>0)
	USE SET:C118("$borrarPromediosAprendizajes")
	RELATE MANY SELECTION:C340([Alumnos_Calificaciones:208]ID_Asignatura:5)
	SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
	ORDER BY:C49([Alumnos_Calificaciones:208];[Asignaturas:18]denominacion_interna:16;>)
	
	ARRAY LONGINT:C221($aRecNums;0)
	LONGINT ARRAY FROM SELECTION:C647([Alumnos_Calificaciones:208];$aRecNums;"")
	
	$l_ProgresProcID:=IT_Progress (1;0;0;"Inicializando promedios......")
	For ($i;1;Size of array:C274($aRecNums))
		READ WRITE:C146([Alumnos_Calificaciones:208])
		GOTO RECORD:C242([Alumnos_Calificaciones:208];$aRecNums{$i})
		$b_Promediosmodificados:=EV2_BorraPromedios ($aRecNums{$i})
		
		  // si hubo modificación de promedios agrego los elementos actuales a los arreglos para la creación de tareas de recalculo de promedios generales
		If ($b_PromediosModificados)
			$l_PromediosModificados:=$l_PromediosModificados+1
			If (Find in array:C230($al_AlumnosRecalculo;[Alumnos_Calificaciones:208]ID_Alumno:6)<0)
				APPEND TO ARRAY:C911($al_AlumnosRecalculo;[Alumnos_Calificaciones:208]ID_Alumno:6)
				RELATE ONE:C42([Alumnos_Calificaciones:208]ID_Alumno:6)
				If (Find in array:C230($at_CursosRecalculo;[Alumnos:2]curso:20)<0)
					APPEND TO ARRAY:C911($at_CursosRecalculo;[Alumnos:2]curso:20)
				End if 
			End if 
			If (Find in array:C230($al_AsignaturaRecalculo;[Alumnos_Calificaciones:208]ID_Asignatura:5)<0)
				APPEND TO ARRAY:C911($al_AsignaturaRecalculo;[Alumnos_Calificaciones:208]ID_Asignatura:5)
			End if 
		End if 
		
		$l_ProgresProcID:=IT_Progress (0;$l_ProgresProcID;$i/Size of array:C274($aRecNums);"Inicializando promedios...\r"+[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5)
	End for 
	$l_ProgresProcID:=IT_Progress (-1;$l_ProgresProcID)
	SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
	KRL_UnloadReadOnly (->[Alumnos_Calificaciones:208])
End if 

  // se crean las tareas de recalculo de promedios generales
If ((Size of array:C274($al_AsignaturaRecalculo)+Size of array:C274($al_AlumnosRecalculo)+Size of array:C274($at_CursosRecalculo))>0)
	BLOB_Variables2Blob (->$x_ArreglosRecalculos;0;->$al_AsignaturaRecalculo;->$al_AlumnosRecalculo;->$at_CursosRecalculo)
	$l_serverProcess:=Execute on server:C373("EV2_TareasRecalculosPromedios";128000;"TareasRecalculoPromediosGenerales";$x_ArreglosRecalculos)
End if 
$0:=$l_PromediosModificados  // retorno el numero de registros [Alumnos_Calificaciones] con modificaciones en promedios

READ ONLY:C145(*)
SET_ClearSets ("$selección";"$conAprendizajesEvaluados";"$sinAprendizajesEvaluados";"$conConversion_a_Notas";"$borrarPromediosAprendizajes")




