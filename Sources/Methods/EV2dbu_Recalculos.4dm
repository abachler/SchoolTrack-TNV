//%attributes = {}
  // MÉTODO: EV2dbu_Recalculos
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 13/12/11, 19:49:08
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // Ejecuta el recalculo de promedios de evaluacin de aprendizaje
  // Este metodo es llamado cada vez que es necesario recalcular el promedio o cuando el usuario
  // solicita un recalculo desde Herramientas / Ejecutar, desde el panel Asignaturas del explorador o dentro de la planilla de registro de evaluaciones
  // El recalculo esta optimizado tomando en cuenta sólo los registros con evaluaciones y guardando sólo cuando hay un cambio en los promedios.
  //
  // PARÁMETROS
  // EV2dbu_Recalculos()
  // ----------------------------------------------------
C_BLOB:C604($1)
C_BOOLEAN:C305($2)
C_BOOLEAN:C305(<>vb_calculandoPromediosT;$3;$b_setVariable)  //20121113 RCH para controlar que se ejecute el recalculo desde herramientas/ejecutar/recalcular promedios en asignaturas de a una sola vez

C_BLOB:C604($x_ArreglosRecalculos;$x_recNumArray)
C_BOOLEAN:C305($b_calcular;$b_ConversionMPA_a_notas;$b_ExecuteOnServer;$b_mostrarComparacion;$b_MostrarOpcionComparacion;$b_PromediosModificados;$b_resultadoOmitido)
C_LONGINT:C283($i;$iAsignaturas;$iEvaluaciones;$l_dimensionesCalculadas;$l_EjesCalculados;$l_ProgressProcID;$l_PromediosModificados;$l_registrosAsignaturas;$l_registrosAsignaturasMadres;$l_registrosAsignaturasMPA)
C_LONGINT:C283($l_RegistrosCalculados;$l_RegistrosCalificaciones;$l_ResultadosCalculados;$l_serverProcess;$l_TotalAsignaturas;$m;$m2)
C_REAL:C285($r_progress1;$r_progress2;$r_progress3)
C_TEXT:C284($t_Progress1;$t_Progress2;$t_Progress3;$t_seconds)

C_BOOLEAN:C305(vb_RecalcularTodo)

ARRAY BOOLEAN:C223($ab_esAsignaturaMadre;0)
ARRAY INTEGER:C220($ai_NivelJerarquico;0)
ARRAY LONGINT:C221($al_AlumnosRecalculo;0)
ARRAY LONGINT:C221($al_AsignaturaRecalculo;0)
ARRAY LONGINT:C221($al_Id_Alumnos;0)
ARRAY LONGINT:C221($al_Id_asignaturas;0)
ARRAY LONGINT:C221($al_ID_EstiloEvaluacion;0)
ARRAY LONGINT:C221($al_IDasignaturaMadre;0)
ARRAY LONGINT:C221($al_IDsConsolidantesCalculadas;0)
ARRAY LONGINT:C221($al_NumeroNivel;0)
ARRAY LONGINT:C221($al_RecNumAsignaturas;0)
ARRAY LONGINT:C221($aL_RecNumEvaluaciones;0)
ARRAY LONGINT:C221($al_RecNumsCalculosMPA;0)
ARRAY TEXT:C222($at_Curso_Asignaturas;0)
ARRAY TEXT:C222($at_CursosRecalculo;0)
ARRAY TEXT:C222($at_Nombre_Asignaturas;0)
ARRAY TEXT:C222($at_NombresAlumnos;0)
If (False:C215)
	C_BLOB:C604(EV2dbu_Recalculos ;$1)
	C_BOOLEAN:C305(EV2dbu_Recalculos ;$2)
End if 
C_BOOLEAN:C305(<>vb_ComparacionActiva)




  // CODIGO PRINCIPAL
PERIODOS_Init 
EVS_LoadStyles 
READ ONLY:C145([Asignaturas:18])
READ ONLY:C145([Alumnos:2])


CREATE EMPTY SET:C140([Asignaturas:18];"$porRecalcular")
CREATE EMPTY SET:C140([Asignaturas:18];"$asignaturasMadres")
CREATE EMPTY SET:C140([Asignaturas:18];"$asignaturasHijas")

  //Si el recalculo de la situacion final de los alumnos está bloqueado se aborta el recalculo
If (<>vb_BloquearModifSituacionFinal)
	CD_Dlog (0;"Cualquier acción que afecte la situación académica de los alumnos ha sido bloquea"+"da a contar del "+String:C10(<>vd_FechaBloqueoSchoolTrack;5)+".")
	OK:=0
Else 
	
	
	  // determino la selección de asignaturas para las que se recalcularán promedios
	If (Count parameters:C259>=1)
		  // si se recibió un parametro
		$x_recNumArray:=$1
		If (BLOB size:C605($x_recNumArray)>0)
			  // si se recibió un blob y el blob contiene datos creo la selección de asignaturas a partir de los recnums contenidos en el arreglo
			BLOB_Blob2Vars (->$x_recNumArray;0;->$al_RecNumAsignaturas)
			CREATE SELECTION FROM ARRAY:C640([Asignaturas:18];$al_RecNumAsignaturas)
		Else 
			  // si el blob no tiene datos el recalculo se aplica a todas las asignaturas
			ALL RECORDS:C47([Asignaturas:18])
		End if 
		
	Else 
		  // si el método fue llamado sin parámetros el recalculo se aplica a todas las asignaturas
		ALL RECORDS:C47([Asignaturas:18])
	End if 
	
	QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]Numero:1>0)
	
	
	If (Records in selection:C76([Asignaturas:18])>0)
		CREATE SET:C116([Asignaturas:18];"$porRecalcular")
		If (Count parameters:C259>=2)
			$b_MostrarOpcionComparacion:=$2
		Else 
			$b_MostrarOpcionComparacion:=True:C214
		End if 
		
		If (Count parameters:C259>=3)
			$b_setVariable:=$3
		Else 
			$b_setVariable:=False:C215
		End if 
		
		If ((Not:C34(<>vb_ComparacionActiva)) & ($b_MostrarOpcionComparacion))
			OK:=CD_Dlog (0;__ ("Los promedios de las asignaturas concernidas deben ser recalculados.\r\r¿Desea utilizar una herramienta de visualización de los cam"+"b"+"ios obte"+"nidos después del recálculo?");"";__ ("Si");__ ("No");__ ("Cancelar recálculo"))
			Case of 
				: (OK=1)
					$b_mostrarComparacion:=True:C214
					$b_calcular:=True:C214
				: (OK=2)
					$b_mostrarComparacion:=False:C215
					$b_calcular:=True:C214
				: (OK=3)
					$b_mostrarComparacion:=False:C215
					$b_calcular:=False:C215
					<>vb_calculandoPromediosT:=False:C215
					SET PROCESS VARIABLE:C370(-1;<>vb_calculandoPromediosT;<>vb_calculandoPromediosT)
					  // Modificado por: Saúl Ponce (17-03-2017) Ticket Nº 175469, loguea cuando se cancela el recálculo de los promedios.
					CD_Dlog (0;"Usted ha cancelado el recálculo de promedios.\n\nLos promedios mostrados en la asignatura podrían no corresponder con las evaluaciones y ponderaciones registradas.")
					LOG_RegisterEvt ("Modificación de propiedades de evaluación sin recalculo de los promedios para "+[Asignaturas:18]Asignatura:3+" del curso "+[Asignaturas:18]Curso:5+".")
			End case 
		Else 
			$b_calcular:=True:C214
			$b_mostrarComparacion:=False:C215
		End if 
		
		If ($b_calcular)
			KRL_RelateSelection (->[Asignaturas_Consolidantes:231]ID_AsignaturaMadre:1;->[Asignaturas:18]Numero:1)
			KRL_RelateSelection (->[Asignaturas:18]Numero:1;->[Asignaturas_Consolidantes:231]ID_ParentRecord:5)
			QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]Resultado_no_calculado:47=False:C215)
			CREATE SET:C116([Asignaturas:18];"$asignaturasHijas")
			UNION:C120("$asignaturasHijas";"$porRecalcular";"$porRecalcular")
			
			
			
			  // excluyo las asignaturas con promedios calculados a partir de evaluación de aprendizajes
			  // y los pongo en un arreglo para ejecutar el calculo en el llamado a MPAdbu_Recalculos más abajo
			USE SET:C118("$porRecalcular")
			QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]EVAPR_IdMatriz:91>0)
			LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$al_RecNumsCalculosMPA;"")
			For ($i;Size of array:C274($al_RecNumsCalculosMPA);1;-1)
				GOTO RECORD:C242([Asignaturas:18];$al_RecNumsCalculosMPA{$i})
				$b_ConversionMPA_a_notas:=KRL_GetBooleanFieldData (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[Asignaturas:18]EVAPR_IdMatriz:91;->[MPA_AsignaturasMatrices:189]Convertir_a_Notas:9)
				$l_ResultadosCalculados:=KRL_GetNumericFieldData (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[Asignaturas:18]EVAPR_IdMatriz:91;->[MPA_AsignaturasMatrices:189]BaseCalculoResultado:23)
				$l_EjesCalculados:=KRL_GetNumericFieldData (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[Asignaturas:18]EVAPR_IdMatriz:91;->[MPA_AsignaturasMatrices:189]ModoCalculoEjes:10)
				$l_dimensionesCalculadas:=KRL_GetNumericFieldData (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[Asignaturas:18]EVAPR_IdMatriz:91;->[MPA_AsignaturasMatrices:189]ModoCalculoDimensiones:6)
				Case of 
					: ($b_ConversionMPA_a_notas)
						  //si la matriz de evaluación de apendizajes contempla el calculo de calificaciones basado en aprendizajes
						REMOVE FROM SET:C561([Asignaturas:18];"$porRecalcular")  // retiro a la asignatura del universo a recalcular (el recalculo se hace más abajo en MPAdbu_Recalculos)
						
					: (($l_ResultadosCalculados+$l_EjesCalculados+$l_dimensionesCalculadas)>0)
						  // si la matriz de evaluación de apendizajes no contempla la conversión a notas
						  // pero si el calculo de aprendizajes, la mantengo en el universo de asignatura para el calculo de calificaciones y tambien en el arreglo de asignaturas
						  // con evaluación de aprendizajes para calcular ejes, dimensiones y resultado final sin conversion a notas
						
					: (($l_ResultadosCalculados+$l_EjesCalculados+$l_dimensionesCalculadas)=0)
						  // si la matriz de evaluación de apendizajes no contempla cálculo alguno
						DELETE FROM ARRAY:C228($al_RecNumsCalculosMPA;$i)  // la elimino del universo de calculos de evaluación de aprendizajes
						
				End case 
			End for 
			$l_registrosAsignaturasMPA:=Size of array:C274($al_RecNumsCalculosMPA)
			$l_TotalAsignaturas:=$l_registrosAsignaturas
			
			
			  // excluyo de la selección a calcular las asignaturas consolidantes (madres)
			  // ya que los calculos de consolidación son realizados en el llamado a EV2_Recalculo
			USE SET:C118("$porRecalcular")
			KRL_RelateSelection (->[Asignaturas_Consolidantes:231]ID_ParentRecord:5;->[Asignaturas:18]Numero:1)
			
			USE SET:C118("$porRecalcular")
			QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]nivel_jerarquico:107>0)
			KRL_RelateSelection (->[Asignaturas_Consolidantes:231]ID_ParentRecord:5;->[Asignaturas:18]Numero:1)
			KRL_RelateSelection (->[Asignaturas:18]Numero:1;->[Asignaturas_Consolidantes:231]ID_AsignaturaMadre:1)
			CREATE SET:C116([Asignaturas:18];"$asignaturasMadres")
			DIFFERENCE:C122("$porRecalcular";"$asignaturasMadres";"$porRecalcular")
			
			  // si las madres tienen registradas evaluaciones directas las sumamos a las asignaturas a recalcular aún cuando no estén en  la lista
			USE SET:C118("$asignaturasMadres")
			KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Asignatura:5;->[Asignaturas:18]Numero:1)
			QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]PeriodosEvaluados_bitField:503>0)
			KRL_RelateSelection (->[Asignaturas:18]Numero:1;->[Alumnos_Calificaciones:208]ID_Asignatura:5)
			If (Records in selection:C76([Asignaturas:18])>0)
				  //20150526 RCH Aparece error en compilado.
				  //CREATE SET("$asignaturasMadres")
				CREATE SET:C116([Asignaturas:18];"$asignaturasMadres")
				UNION:C120("$porRecalcular";"$asignaturasMadres";"$porRecalcular")
			End if 
			
			  // determino cuales son las asignaturas que tienen activada la propiedad RESULTADOS NO CALCULADOS
			  // y las agrego al arreglo de asignaturas para las que hay que calcular promedios generales 
			  // el calculo de promedios generales de asignaturas se inicia al final del metodo en proceso separado 
			USE SET:C118("$porRecalcular")
			QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]Resultado_no_calculado:47=True:C214)
			SELECTION TO ARRAY:C260([Asignaturas:18]Numero:1;$al_Id_asignaturas)
			For ($iAsignaturas;1;Size of array:C274($al_Id_asignaturas))
				If (Find in array:C230($al_AsignaturaRecalculo;$al_Id_asignaturas{$iAsignaturas})<0)  // agrego los Ids de asignaturas al arreglo que promedios generales de asignatura a recalcular
					APPEND TO ARRAY:C911($al_AsignaturaRecalculo;$al_Id_asignaturas{$iAsignaturas})
				End if 
			End for 
			
			
			  // reduzco la seleccion de asignaturas solo a aquellas con resultados calculados y que cuentan con registros de calificaciones evaluados
			USE SET:C118("$porRecalcular")
			QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]Resultado_no_calculado:47=False:C215)
			RELATE MANY SELECTION:C340([Alumnos_Calificaciones:208]ID_Asignatura:5)
			QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]PeriodosEvaluados_bitField:503>0)
			RELATE MANY SELECTION:C340([Alumnos_Calificaciones:208]ID_Asignatura:5)
			$l_RegistrosCalificaciones:=Records in selection:C76([Alumnos_Calificaciones:208])
			RELATE ONE SELECTION:C349([Alumnos_Calificaciones:208];[Asignaturas:18])
			
			
			
			
			If ($b_mostrarComparacion)
				  // llamo las rutinas de inicializacion y carga de los promedios actuales
				  // para compararlos con los promedios recalculados
				EV2_CambiosPostRecalculo ("Init")
				EV2_CambiosPostRecalculo ("LoadAverages_BeforeRecalc")
			End if 
			
			vb_RecalcularTodo:=True:C214
			
			USE SET:C118("$porRecalcular")
			If (Records in selection:C76([Asignaturas:18])>0)
				
				ORDER BY:C49([Asignaturas:18];[Asignaturas:18]nivel_jerarquico:107;<;[Asignaturas:18]Numero_del_Nivel:6;>;[Asignaturas:18]Curso:5;>;[Asignaturas:18]Numero_de_EstiloEvaluacion:39;>;[Asignaturas:18]denominacion_interna:16;>)
				SELECTION TO ARRAY:C260([Asignaturas:18];$al_RecNumAsignaturas;[Asignaturas:18]Numero:1;$al_Id_asignaturas;[Asignaturas:18]Numero_del_Nivel:6;$al_NumeroNivel;[Asignaturas:18]Numero_de_EstiloEvaluacion:39;$al_ID_EstiloEvaluacion;[Asignaturas:18]denominacion_interna:16;$at_Nombre_Asignaturas;[Asignaturas:18]Curso:5;$at_Curso_Asignaturas;[Asignaturas:18]nivel_jerarquico:107;$ai_NivelJerarquico;[Asignaturas:18]Consolidacion_EsConsolidante:35;$ab_esAsignaturaMadre)
				
				  // inicializo las variables proceso utilizadas en los metodos de recalculo ya que
				  // que estos pueden ejecutarse en el server en el proceso gemelo del cliente
				$b_resultadoOmitido:=EV2_Recalculo (-1)  //para inicializar variables proceso utilizadas en el método de recalculo
				
				  // abro el cuadro de avance de tarea e inicializo el contador de registros procesados
				$l_ProgressProcID:=IT_Progress (1;0;0;"Calculando promedios en asignaturas...")
				$l_RegistrosCalculados:=0
				$l_PromediosModificados:=0
				
				  // Para cada asignatura de la selección
				For ($iAsignaturas;1;Size of array:C274($al_Id_asignaturas))
					  // asigno valores a las variables usadas para mostrar el avance de la tareas
					$r_progress2:=$iAsignaturas/Size of array:C274($al_Id_asignaturas)
					$t_Progress2:=$at_Nombre_Asignaturas{$iAsignaturas}+", "+$at_Curso_Asignaturas{$iAsignaturas}
					
					  // busco los registros de calificaciones de la asignatura que contienen evaluaciones en algun período
					SET FIELD RELATION:C919([Alumnos_Calificaciones:208]ID_Alumno:6;Automatic:K51:4;Structure configuration:K51:2)
					QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=$al_Id_asignaturas{$iAsignaturas})
					  //QUERY([Alumnos_Calificaciones];[Alumnos_Calificaciones]ID_Asignatura=$al_Id_asignaturas{$iAsignaturas};*)
					  //QUERY([Alumnos_Calificaciones]; & ;[Alumnos_Calificaciones]PeriodosEvaluados_bitField>0)
					SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208];$aL_RecNumEvaluaciones;[Alumnos:2]apellidos_y_nombres:40;$at_NombresAlumnos;[Alumnos_Calificaciones:208]ID_Alumno:6;$al_Id_Alumnos)
					SET FIELD RELATION:C919([Alumnos_Calificaciones:208]ID_Alumno:6;Structure configuration:K51:2;Structure configuration:K51:2)
					
					
					  // para cada registro de [Alumnos_Calificaciones]
					For ($iEvaluaciones;1;Size of array:C274($aL_RecNumEvaluaciones))
						$l_RegistrosCalculados:=$l_RegistrosCalculados+1
						$r_progress1:=$l_RegistrosCalculados/$l_RegistrosCalificaciones
						$t_Progress1:="Calculando promedios en asignaturas ("+String:C10($l_RegistrosCalculados)+" registros sobre "+String:C10($l_RegistrosCalificaciones)+")..."
						$r_progress3:=$iEvaluaciones/Size of array:C274($aL_RecNumEvaluaciones)
						$t_Progress3:=$at_NombresAlumnos{$iEvaluaciones}
						$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$r_progress1;$t_Progress1;$r_progress2;$t_Progress2;$r_progress3;$t_Progress3)
						
						  // llamo al método de recalculo (en modo cliente servidor se ejecuta en el servidor), 
						  // que recalcula los promedios de todos los periodos con evaluaciones y el promedio final, 
						  // tanto para el registro de calificaciones actual como para toda la jerarquía ascendente (asignaturas madres)
						  //$b_PromediosModificados:=EV2_Recalculo ($aL_RecNumEvaluaciones{$iEvaluaciones};$al_NumeroNivel{$iAsignaturas};$al_ID_EstiloEvaluacion{$iAsignaturas};$ab_esAsignaturaMadre{$iAsignaturas})
						$b_PromediosModificados:=EV2_Recalculo ($aL_RecNumEvaluaciones{$iEvaluaciones};$al_NumeroNivel{$iAsignaturas};$al_ID_EstiloEvaluacion{$iAsignaturas};$ab_esAsignaturaMadre{$iAsignaturas};True:C214)  //20120712 ASM. Paso el 5to parámetro en True para forzar el recalculo de promedios
						
						  // si los promedios fueron modificados después del recalculo...
						If ($b_PromediosModificados | vb_RecalcularTodo)
							$l_PromediosModificados:=$l_PromediosModificados+1
							If (Find in array:C230($al_AlumnosRecalculo;$al_Id_Alumnos{$iEvaluaciones})<0)  // agrego los Ids de alumno al arreglo que promedios generales de alumno a recalcular
								APPEND TO ARRAY:C911($al_AlumnosRecalculo;$al_Id_Alumnos{$iEvaluaciones})
							End if 
							If (Find in array:C230($at_CursosRecalculo;$at_Curso_Asignaturas{$iAsignaturas})<0)  // agrego los Ids de cursos al arreglo que promedios generales de curso a recalcular
								APPEND TO ARRAY:C911($at_CursosRecalculo;$at_Curso_Asignaturas{$iAsignaturas})
							End if 
							If (Find in array:C230($al_AsignaturaRecalculo;$al_Id_asignaturas{$iAsignaturas})<0)  // agrego los Ids de asignaturas al arreglo que promedios generales de asignatura a recalcular
								APPEND TO ARRAY:C911($al_AsignaturaRecalculo;$al_Id_asignaturas{$iAsignaturas})
							End if 
						End if 
					End for 
					$l_recNumAsignatura:=Find in field:C653([Asignaturas:18]Numero:1;$al_Id_asignaturas{$iAsignaturas})
					EV2_ResultadosAsignatura ($l_recNumAsignatura)
				End for 
				
				$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)  // cierro el cuadro de diálogo de avance
			End if 
			
			
			  // fuerzo el recalculo de resultados en las asignaturas madres cuyos promedios pudieron haber sido modificados desde las hijas
			If (Records in set:C195("$asignaturasMadres")>0)
				USE SET:C118("$asignaturasMadres")
				SELECTION TO ARRAY:C260([Asignaturas:18]Numero:1;$al_Id_asignaturas)
				For ($iAsignaturas;1;Size of array:C274($al_Id_asignaturas))
					If (Find in array:C230($al_AsignaturaRecalculo;$al_Id_asignaturas{$iAsignaturas})<0)  // agrego los Ids de asignaturas al arreglo que promedios generales de asignatura a recalcular
						APPEND TO ARRAY:C911($al_AsignaturaRecalculo;$al_Id_asignaturas{$iAsignaturas})
					End if 
				End for 
			End if 
			
			
			  // inicio la ejecucion del recalculo de evaluaciones evaluaciones de aprendizajes para las asignaturas
			  // cuyos Ids están contenidos en el arreglo $al_RecNumsCalculosMPA
			If (Size of array:C274($al_RecNumsCalculosMPA)>0)
				BLOB_Variables2Blob (->$x_recNumArray;0;->$al_RecNumsCalculosMPA)
				$l_PromediosModificados:=$l_PromediosModificados+MPAdbu_Recalculos ($x_recNumArray)
			End if 
			
			
			  // ejecuto en el servidor (o en un proceso separado en mono-usuario) el método que crea 
			  // las tareas de recalculo de promedios generales de asignaturas, alumnos y cursos
			BLOB_Variables2Blob (->$x_ArreglosRecalculos;0;->$al_AsignaturaRecalculo;->$al_AlumnosRecalculo;->$at_CursosRecalculo)
			$l_serverProcess:=Execute on server:C373("EV2_TareasRecalculosPromedios";128000;"TareasRecalculoPromediosGenerales";$x_ArreglosRecalculos)
			
			
			  // si la comparación entre promedios pre y post recalculo está activada ejecuto el método
			  // que examina los registros antes y después del calculo para detectar las diferencias
			If ($b_mostrarComparacion)
				EV2_CambiosPostRecalculo ("BuildChangeList")
			End if 
			
			If ($b_setVariable)
				<>vb_calculandoPromediosT:=False:C215
				SET PROCESS VARIABLE:C370(-1;<>vb_calculandoPromediosT;<>vb_calculandoPromediosT)
			End if 
			vb_RecalcularTodo:=False:C215
			
			  ///agrego al Log si se efectua un recalculo de calificaciones 147179
			C_TEXT:C284($log)
			$log:=__ ("Se realizo un recalculo de calificaciones")
			LOG_RegisterEvt ($log)
			
			vlEVS_CurrentEvStyleID:=0
			vlSTR_Periodos_CurrentRef:=0
			
		End if 
	End if 
End if 