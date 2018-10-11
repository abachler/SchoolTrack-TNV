//%attributes = {}
  // MPAcfg_AsignaMapas()
  // 
  //
If (False:C215)
	  // Alberto Bachler: 06/03/12, 16:38:24
	  // 
	  // ---------------------------------------------
	  // Alberto Bachler: 09/01/13, 23:17:46
	  // En lugar de los limites de etapa de ejes, dimensiones y competencias,
	  // se utiliza el campo bitNiveles en las definiciones para determinar si el enunciado aplica en el nivel.
	  // Verificación de la existencia del registro [MPA_ObjetoMatriz] sobre el campo [MPA_ObjetoMatriz]Llave_unica, reemplazando queries compuestos
	  // Corrección de errores que podían permitir la asignación de enunciados no aplicables en el nivel
	  // ---------------------------------------------
End if 
C_LONGINT:C283($1)
C_POINTER:C301($2)
C_LONGINT:C283($3)

C_BOOLEAN:C305($b_asignarCompetencias;$b_asignarEnNivel;$b_eliminarCompetencias;$b_eliminarEvaluaciones;$b_logearEliminacion)
_O_C_INTEGER:C282($i_Materias;$i_Niveles)
C_LONGINT:C283($l_evaluados;$i;$iEtapas;$indexNivel;$l_IdArea;$l_IdMateria;$l_IdMatrizPrincipal;$l_numeroNivel;$l_opcionAsignacion;$l_ProgressProcID)
C_LONGINT:C283($l_recNumArea;$l_transaccionOK;$l_recNumMateria)
C_POINTER:C301($y_AsignaturasDelArea)
C_REAL:C285($r_progress1;$r_progress2)
C_TEXT:C284($t_area;$t_nivelNombre;$t_Progress1;$t_Progress2)

ARRAY INTEGER:C220($al_Niveles;0)
ARRAY LONGINT:C221($al_IdAsignaturas;0)
ARRAY LONGINT:C221($al_recNumCompetencias;0)
ARRAY LONGINT:C221($al_recNumDimensiones;0)
ARRAY LONGINT:C221($al_recNumEjes;0)
ARRAY LONGINT:C221($al_RecNums;0)
ARRAY LONGINT:C221($al_Restricciones;0)
ARRAY TEXT:C222($at_Curso;0)
ARRAY TEXT:C222($at_nombreAsignatura;0)
ARRAY TEXT:C222($at_Competencias;0)
If (False:C215)
	C_LONGINT:C283(MPAcfg_AsignaMapas ;$1)
	C_POINTER:C301(MPAcfg_AsignaMapas ;$2)
	C_LONGINT:C283(MPAcfg_AsignaMapas ;$3)
End if 
$l_recNumArea:=$1
$y_AsignaturasDelArea:=$2
$l_opcionAsignacion:=$3




  // CODIGO PRINCIPAL
READ ONLY:C145([MPA_DefinicionAreas:186])
GOTO RECORD:C242([MPA_DefinicionAreas:186];$l_recNumArea)
$t_area:=[MPA_DefinicionAreas:186]AreaAsignatura:4
$l_IdArea:=[MPA_DefinicionAreas:186]ID:1
BLOB_Blob2Vars (->[MPA_DefinicionAreas:186]xEtapas:10;0;->atMPA_EtapasArea;->alMPA_NivelDesde;->alMPA_NivelHasta)

  // abro el cuadro de avance de tarea e inicializo el contador de registros procesados
$l_ProgressProcID:=IT_Progress (1;0;0;__ ("Asignando competencias, dimensiones y ejes de aprendizajes en el área ")+$t_area)

READ ONLY:C145([MPA_AsignaturasMatrices:189])
READ ONLY:C145([MPA_DefinicionEjes:185])
READ ONLY:C145([MPA_DefinicionDimensiones:188])
READ ONLY:C145([MPA_DefinicionCompetencias:187])
READ ONLY:C145([xxSTR_Niveles:6])

CREATE EMPTY SET:C140([MPA_AsignaturasMatrices:189];"$matricesModificadas")

FLUSH CACHE:C297

$l_transaccionOK:=1
START TRANSACTION:C239

LOG_RegisterEvt ("Regeneración de Matrices de Evaluación de aprendizajes por omisión para el área "+$t_area+" iniciada")
For ($i_Materias;1;Size of array:C274($y_AsignaturasDelArea->))
	  //busqueda de las asignaturas correspondientes al subsector
	QUERY:C277([Asignaturas:18];[Asignaturas:18]Asignatura:3=$y_AsignaturasDelArea->{$i_Materias})
	$l_recNumMateria:=Find in field:C653([xxSTR_Materias:20]Materia:2;$y_AsignaturasDelArea->{$i_Materias})
	If ($l_recNumMateria>=0)
		KRL_GotoRecord (->[xxSTR_Materias:20];$l_recNumMateria;False:C215)
		$r_progress1:=$i_Materias/Size of array:C274($y_AsignaturasDelArea->)
		$t_Progress1:=[xxSTR_Materias:20]Materia:2
		
		$l_IdMateria:=[xxSTR_Materias:20]ID_Materia:16
		AT_DistinctsFieldValues (->[Asignaturas:18]Numero_del_Nivel:6;->$al_Niveles)
		For ($i_Niveles;1;Size of array:C274($al_Niveles))
			$l_numeroNivel:=$al_Niveles{$i_Niveles}
			QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=$l_numeroNivel)
			$t_nivelNombre:=[xxSTR_Niveles:6]Nivel:1
			
			$r_progress2:=$i_Niveles/Size of array:C274($al_Niveles)
			$t_Progress2:=$t_nivelNombre
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$r_progress1;$t_Progress1;$r_progress2;$t_Progress2)
			
			  //búsqueda de las competencias de la etapa correspondiente al nivel
			QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID_Area:11=$l_IdArea)
			$indexNivel:=Find in array:C230(<>aNivNo;$l_numeroNivel)
			QUERY SELECTION BY FORMULA:C207([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]BitNiveles:28 ?? $indexNivel)
			SELECTION TO ARRAY:C260([MPA_DefinicionCompetencias:187];$al_recNumCompetencias;[MPA_DefinicionCompetencias:187]Competencia:6;$at_Competencias;[MPA_DefinicionCompetencias:187]RestriccionSubsector:3;$al_Restricciones)
			$l_Competencias:=Size of array:C274($al_recNumCompetencias)
			
			QUERY:C277([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]ID_Area:2=$l_IdArea)
			$indexNivel:=Find in array:C230(<>aNivNo;$l_numeroNivel)
			QUERY SELECTION BY FORMULA:C207([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]BitsNiveles:20 ?? $indexNivel)
			SELECTION TO ARRAY:C260([MPA_DefinicionEjes:185];$al_recNumEjes)
			$l_Ejes:=Size of array:C274($al_recNumEjes)
			
			QUERY:C277([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]ID_Area:2=$l_IdArea)
			$indexNivel:=Find in array:C230(<>aNivNo;$l_numeroNivel)
			QUERY SELECTION BY FORMULA:C207([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]BitsNiveles:21 ?? $indexNivel)
			SELECTION TO ARRAY:C260([MPA_DefinicionDimensiones:188];$al_recNumDimensiones)
			$l_dimensiones:=Size of array:C274($al_recNumDimensiones)
			
			
			
			If (($l_Competencias+$l_dimensiones+$l_Ejes)>0)
				
				QUERY:C277([MPA_AsignaturasMatrices:189];[MPA_AsignaturasMatrices:189]Asignatura:3=$y_AsignaturasDelArea->{$i_Materias};*)
				QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]NumeroNivel:4=$l_numeroNivel;*)
				QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]ConfiguracionPrincipal:19;=;True:C214)
				
				  //creación del registro de evaluación por defecto si no existe
				If (Records in selection:C76([MPA_AsignaturasMatrices:189])=0)
					CREATE RECORD:C68([MPA_AsignaturasMatrices:189])
					[MPA_AsignaturasMatrices:189]ID_Matriz:1:=SQ_SeqNumber (->[MPA_AsignaturasMatrices:189]ID_Matriz:1)
					[MPA_AsignaturasMatrices:189]Asignatura:3:=$y_AsignaturasDelArea->{$i_Materias}
					[MPA_AsignaturasMatrices:189]ID_Area:22:=$l_IdArea
					[MPA_AsignaturasMatrices:189]Area:13:=$t_area
					[MPA_AsignaturasMatrices:189]ConfiguracionPrincipal:19:=True:C214
					[MPA_AsignaturasMatrices:189]CreadaPor:15:=USR_GetUserName (USR_GetUserID )
					[MPA_AsignaturasMatrices:189]DTS_Creacion:16:=DTS_MakeFromDateTime (Current date:C33(*);Current time:C178(*))
					[MPA_AsignaturasMatrices:189]DTS_Modificacion:18:=DTS_MakeFromDateTime (Current date:C33(*);Current time:C178(*))
					[MPA_AsignaturasMatrices:189]ID_Creador:20:=USR_GetUserID 
					[MPA_AsignaturasMatrices:189]ModificadaPor:17:=USR_GetUserName (USR_GetUserID )
					[MPA_AsignaturasMatrices:189]NombreMatriz:2:=$y_AsignaturasDelArea->{$i_Materias}+", "+$t_nivelNombre
					[MPA_AsignaturasMatrices:189]NumeroNivel:4:=$l_numeroNivel
					[MPA_AsignaturasMatrices:189]PonderacionResultado:8:=0
					[MPA_AsignaturasMatrices:189]ResultadoFinalCalculado:7:=False:C215
					SAVE RECORD:C53([MPA_AsignaturasMatrices:189])
				End if 
				$l_IdMatrizPrincipal:=[MPA_AsignaturasMatrices:189]ID_Matriz:1
				
				$b_eliminarCompetencias:=False:C215
				$b_eliminarEvaluaciones:=False:C215
				$b_asignarCompetencias:=True:C214
				Case of 
					: ($l_opcionAsignacion=4)
						$b_eliminarCompetencias:=True:C214
						$b_eliminarEvaluaciones:=True:C214
						$b_asignarCompetencias:=True:C214
						
					: ($l_opcionAsignacion=3)
						READ ONLY:C145([Asignaturas:18])
						QUERY:C277([Asignaturas:18];[Asignaturas:18]Asignatura:3=$y_AsignaturasDelArea->{$i_Materias};*)
						QUERY:C277([Asignaturas:18]; & [Asignaturas:18]Numero_del_Nivel:6=$l_numeroNivel;*)
						QUERY:C277([Asignaturas:18]; & [Asignaturas:18]EVAPR_IdMatriz:91=$l_IdMatrizPrincipal)
						SELECTION TO ARRAY:C260([Asignaturas:18]Numero:1;$al_IdAsignaturas)
						For ($i;1;Size of array:C274($al_IdAsignaturas))
							
							SET QUERY DESTINATION:C396(Into variable:K19:4;$l_evaluados)
							QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1=$al_IdAsignaturas{$i};*)
							QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63>0;*)
							QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Año:77=<>gYear)
							SET QUERY DESTINATION:C396(Into current selection:K19:1)
							
							If ($l_evaluados=0)
								$b_asignarCompetencias:=True:C214
								$b_eliminarCompetencias:=True:C214
							Else 
								$b_asignarCompetencias:=False:C215
								$b_eliminarCompetencias:=False:C215
								$b_eliminarEvaluaciones:=False:C215
								$i:=Size of array:C274($al_IdAsignaturas)
							End if 
						End for 
						
						
					: ($l_opcionAsignacion=2)
						$b_asignarCompetencias:=True:C214
						$b_eliminarCompetencias:=False:C215
						$b_eliminarEvaluaciones:=False:C215
						
						
					: ($l_opcionAsignacion=1)
						READ ONLY:C145([Asignaturas:18])
						QUERY:C277([Asignaturas:18];[Asignaturas:18]Asignatura:3=$y_AsignaturasDelArea->{$i_Materias};*)
						QUERY:C277([Asignaturas:18]; & [Asignaturas:18]Numero_del_Nivel:6=$l_numeroNivel;*)
						QUERY:C277([Asignaturas:18]; & [Asignaturas:18]EVAPR_IdMatriz:91=$l_IdMatrizPrincipal)
						SELECTION TO ARRAY:C260([Asignaturas:18]Numero:1;$al_IdAsignaturas)
						For ($i;1;Size of array:C274($al_IdAsignaturas))
							SET QUERY DESTINATION:C396(Into variable:K19:4;$l_asignados)
							QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1=$al_IdAsignaturas{$i};*)
							QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Año:77=<>gYear)
							SET QUERY DESTINATION:C396(Into current selection:K19:1)
							If ($l_asignados=0)
								$b_asignarCompetencias:=True:C214
								$b_eliminarCompetencias:=False:C215
							Else 
								$b_asignarCompetencias:=False:C215
								$b_eliminarCompetencias:=False:C215
								$b_eliminarEvaluaciones:=False:C215
								$i:=Size of array:C274($al_IdAsignaturas)
							End if 
						End for 
						
				End case 
				
				If ($b_eliminarEvaluaciones)
					  //eliminación de las evaluaciones de ejes
					READ ONLY:C145([Asignaturas:18])
					QUERY:C277([Asignaturas:18];[Asignaturas:18]Asignatura:3=$y_AsignaturasDelArea->{$i_Materias};*)
					QUERY:C277([Asignaturas:18]; & [Asignaturas:18]Numero_del_Nivel:6=$l_numeroNivel;*)
					QUERY:C277([Asignaturas:18]; & [Asignaturas:18]EVAPR_IdMatriz:91=$l_IdMatrizPrincipal)
					SELECTION TO ARRAY:C260([Asignaturas:18]Numero:1;$al_IdAsignaturas;[Asignaturas:18]denominacion_interna:16;$at_nombreAsignatura;[Asignaturas:18]Curso:5;$at_Curso)
					
					For ($i;1;Size of array:C274($al_IdAsignaturas))
						  //eliminación de las evaluaciones de competencias
						
						$b_logearEliminacion:=False:C215
						READ WRITE:C146([Alumnos_EvaluacionAprendizajes:203])
						QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1=$al_IdAsignaturas{$i})
						If (Records in selection:C76([Alumnos_EvaluacionAprendizajes:203])>0)
							$l_transaccionOK:=KRL_DeleteSelection (->[Alumnos_EvaluacionAprendizajes:203])
							$b_logearEliminacion:=True:C214
						End if 
						
						If (($l_transaccionOK=1) & ($b_logearEliminacion))
							LOG_RegisterEvt ("Registros de Evaluación de aprendizajes eliminadas en "+$at_nombreAsignatura{$i}+", "+$at_Curso{$i}+" por regeneración de Matrices de Evaluación")
						End if 
						
						If ($l_transaccionOK=0)
							$b_eliminarCompetencias:=False:C215
							$b_asignarCompetencias:=False:C215
							$i:=Size of array:C274($al_IdAsignaturas)
						End if 
					End for 
				End if 
				
				If ($b_eliminarCompetencias)
					$b_logearEliminacion:=False:C215
					  //eliminación de los objetos de la matriz
					If ($l_transaccionOK=1)
						READ WRITE:C146([MPA_ObjetosMatriz:204])
						QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1=$l_IdMatrizPrincipal)
						If (Records in selection:C76([MPA_ObjetosMatriz:204])>0)
							  // agrego al conjunto $matricesModificadas (declarado al inicio de la ejecución de este metodo) la matriz actual
							  // en la que eliminamos objetos
							SET QUERY DESTINATION:C396(Into set:K19:2;"$matrices")
							QUERY:C277([MPA_AsignaturasMatrices:189];[MPA_AsignaturasMatrices:189]ID_Matriz:1=$l_IdMatrizPrincipal)
							SET QUERY DESTINATION:C396(Into current selection:K19:1)
							UNION:C120("$matrices";"$matricesModificadas";"$matricesModificadas")
							
							$l_transaccionOK:=KRL_DeleteSelection (->[MPA_ObjetosMatriz:204])
							$b_logearEliminacion:=True:C214
						End if 
					End if 
					
					If (($l_transaccionOK=1) & ($b_logearEliminacion))
						LOG_RegisterEvt ("Matriz de Evaluación por omisión de "+$y_AsignaturasDelArea->{$i_Materias}+", "+$t_nivelNombre+" eliminada por regeneración de Matrices de Evaluación")
					End if 
					
					If ($l_transaccionOK=0)
						$b_eliminarCompetencias:=False:C215
						$b_asignarCompetencias:=False:C215
					End if 
				End if 
				
				If ($l_transaccionOK=1)
					If ($b_asignarCompetencias)
						
						For ($i;1;Size of array:C274($al_recNumEjes))
							GOTO RECORD:C242([MPA_DefinicionEjes:185];$al_recNumEjes{$i})
							$t_llaveObjetoMatriz:=String:C10(<>gInstitucion)+"."+String:C10($l_IdMatrizPrincipal)+"."+String:C10([MPA_DefinicionEjes:185]ID:1)+"."+String:C10(0)+"."+String:C10(0)
							$l_recNumObjetoMatriz:=KRL_FindAndLoadRecordByIndex (->[MPA_ObjetosMatriz:204]Llave_unica:27;->$t_llaveObjetoMatriz;True:C214)
							If (($l_recNumObjetoMatriz<0) | ([MPA_ObjetosMatriz:204]Tipo_Objeto:2#Eje_Aprendizaje))
								CREATE RECORD:C68([MPA_ObjetosMatriz:204])
								[MPA_ObjetosMatriz:204]ID_Eje:3:=[MPA_DefinicionEjes:185]ID:1
								[MPA_ObjetosMatriz:204]ID_Matriz:1:=$l_IdMatrizPrincipal
								[MPA_ObjetosMatriz:204]Tipo_Objeto:2:=Eje_Aprendizaje
								[MPA_ObjetosMatriz:204]Periodos:7:=1
								SAVE RECORD:C53([MPA_ObjetosMatriz:204])
							Else 
								[MPA_ObjetosMatriz:204]Periodos:7:=1
								SAVE RECORD:C53([MPA_ObjetosMatriz:204])
							End if 
						End for 
						
						For ($i;1;Size of array:C274($al_recNumDimensiones))
							GOTO RECORD:C242([MPA_DefinicionDimensiones:188];$al_recNumDimensiones{$i})
							$t_llaveObjetoMatriz:=String:C10(<>gInstitucion)+"."+String:C10($l_IdMatrizPrincipal)+"."+String:C10([MPA_DefinicionCompetencias:187]ID_Eje:2)+"."+String:C10([MPA_DefinicionCompetencias:187]ID_Dimension:23)+"."+String:C10(0)
							$l_recNumObjetoMatriz:=KRL_FindAndLoadRecordByIndex (->[MPA_ObjetosMatriz:204]Llave_unica:27;->$t_llaveObjetoMatriz;True:C214)
							If (($l_recNumObjetoMatriz<0) | ([MPA_ObjetosMatriz:204]Tipo_Objeto:2#Dimension_Aprendizaje))
								CREATE RECORD:C68([MPA_ObjetosMatriz:204])
								[MPA_ObjetosMatriz:204]ID_Eje:3:=[MPA_DefinicionDimensiones:188]ID_Eje:3
								[MPA_ObjetosMatriz:204]ID_Dimension:4:=[MPA_DefinicionDimensiones:188]ID:1
								[MPA_ObjetosMatriz:204]ID_Matriz:1:=$l_IdMatrizPrincipal
								[MPA_ObjetosMatriz:204]Tipo_Objeto:2:=Dimension_Aprendizaje
								[MPA_ObjetosMatriz:204]Periodos:7:=1
								SAVE RECORD:C53([MPA_ObjetosMatriz:204])
							Else 
								[MPA_ObjetosMatriz:204]ID_Eje:3:=[MPA_DefinicionDimensiones:188]ID_Eje:3
								[MPA_ObjetosMatriz:204]Periodos:7:=1
								SAVE RECORD:C53([MPA_ObjetosMatriz:204])
							End if 
						End for 
						
						For ($i;1;Size of array:C274($al_recNumCompetencias))
							GOTO RECORD:C242([MPA_DefinicionCompetencias:187];$al_recNumCompetencias{$i})
							If (([MPA_DefinicionCompetencias:187]RestriccionSubsector:3=0) | ([MPA_DefinicionCompetencias:187]RestriccionSubsector:3=$l_IdMateria))
								$t_llaveObjetoMatriz:=String:C10(<>gInstitucion)+"."+String:C10($l_IdMatrizPrincipal)+"."+String:C10([MPA_DefinicionCompetencias:187]ID_Eje:2)+"."+String:C10([MPA_DefinicionCompetencias:187]ID_Dimension:23)+"."+String:C10([MPA_DefinicionCompetencias:187]ID:1)
								$l_recNumObjetoMatriz:=KRL_FindAndLoadRecordByIndex (->[MPA_ObjetosMatriz:204]Llave_unica:27;->$t_llaveObjetoMatriz;True:C214)
								If (($l_recNumObjetoMatriz<0) | ([MPA_ObjetosMatriz:204]Tipo_Objeto:2#Logro_Aprendizaje))
									CREATE RECORD:C68([MPA_ObjetosMatriz:204])
									[MPA_ObjetosMatriz:204]ID_Eje:3:=[MPA_DefinicionCompetencias:187]ID_Eje:2
									[MPA_ObjetosMatriz:204]ID_Dimension:4:=[MPA_DefinicionCompetencias:187]ID_Dimension:23
									[MPA_ObjetosMatriz:204]ID_Competencia:5:=[MPA_DefinicionCompetencias:187]ID:1
									[MPA_ObjetosMatriz:204]ID_Matriz:1:=$l_IdMatrizPrincipal
									[MPA_ObjetosMatriz:204]Tipo_Objeto:2:=Logro_Aprendizaje
									[MPA_ObjetosMatriz:204]Periodos:7:=1
									SAVE RECORD:C53([MPA_ObjetosMatriz:204])
								Else 
									[MPA_ObjetosMatriz:204]ID_Eje:3:=[MPA_DefinicionCompetencias:187]ID_Eje:2
									[MPA_ObjetosMatriz:204]ID_Dimension:4:=[MPA_DefinicionCompetencias:187]ID_Dimension:23
									[MPA_ObjetosMatriz:204]Periodos:7:=1
									SAVE RECORD:C53([MPA_ObjetosMatriz:204])
								End if 
							End if 
						End for 
						LOG_RegisterEvt ("Matriz de Evaluación por omisión de "+$y_AsignaturasDelArea->{$i_Materias}+", "+$t_nivelNombre+" regenerada.")
					End if 
					
					QUERY:C277([Asignaturas:18];[Asignaturas:18]Asignatura:3=$y_AsignaturasDelArea->{$i_Materias};*)
					QUERY:C277([Asignaturas:18]; & [Asignaturas:18]Numero_del_Nivel:6=$l_numeroNivel)
					LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$al_RecNums;"")
					For ($i;1;Size of array:C274($al_RecNums))
						READ WRITE:C146([Asignaturas:18])
						GOTO RECORD:C242([Asignaturas:18];$al_RecNums{$i})
						$l_transaccionOK:=KRL_LoadRecord (->[Asignaturas:18])
						If ($l_transaccionOK=1)
							[Asignaturas:18]EVAPR_IdMatriz:91:=$l_IdMatrizPrincipal
							SAVE RECORD:C53([Asignaturas:18])
						Else 
							$i:=Size of array:C274($al_RecNums)
						End if 
					End for 
				End if 
				
				If ($l_transaccionOK=0)
					$i_Materias:=Size of array:C274($y_AsignaturasDelArea->)
					$i_Niveles:=Size of array:C274($al_Niveles)
				End if 
			End if 
		End for 
	End if 
End for 

$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)

If ($l_transaccionOK=1)
	DELAY PROCESS:C323(Current process:C322;60)
	LOG_RegisterEvt ("Regeneración de Matrices de evaluación de aprendizajes por omisión para el área  "+$t_area+" terminada")
	VALIDATE TRANSACTION:C240
	  // agrego al arreglo de matrices a recalcular las matrices modificadas durante la asignación
	UNION:C120("$matrices_a_recalcular";"$matricesModificadas";"$matrices_a_recalcular")
Else 
	CANCEL TRANSACTION:C241
End if 

KRL_ReloadAsReadOnly (->[Asignaturas:18])
KRL_ReloadAsReadOnly (->[MPA_AsignaturasMatrices:189])
KRL_ReloadAsReadOnly (->[MPA_ObjetosMatriz:204])
KRL_ReloadAsReadOnly (->[Alumnos_EvaluacionAprendizajes:203])

SET_ClearSets ("$matricesModificadas";"$matrices")

FLUSH CACHE:C297

