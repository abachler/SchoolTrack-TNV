//%attributes = {}
  // EV2_AprobacionReprobacion_ar()
  // Por: Alberto Bachler: 14/08/13, 13:46:51
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_asignarNotaOficial;$b_BachilleratoModalizado;$b_calificacionAprobatoria;$b_hayEvaluacionesPendientes;$b_noHayEvaluaciones;$b_todosPeriodosEvaluados;$b_ultimoPeriodoEvaluado;$b_guardar)
C_REAL:C285($r_minimoRequerido)
C_TEXT:C284($t_cursoAlumno)


[Alumnos_Calificaciones:208]PeriodosEvaluados_bitField:503:=EV2_RegistroHaSidoEvaluado 

Case of 
		
		  // ABK 20131230 nuevo cambio solicitado desde Argentina
		  // el calculo de la nota oficial debe hacerse sobre todas las asignaturas con promedios calculados desde el grado 7
		  // no solo las asignaturas oficiales.
		  // las 4 lineas  de código siguiente son desactivadas y reemplzadas por las 4 más abajo
		
		  //ANTES del 20131230
		  // la asignatura no es asignatura oficial
		  //: (Not([Asignaturas]Incluida_en_Actas))
		  //[Alumnos_Calificaciones]Reprobada:=False
		  //[Alumnos_Calificaciones]RequiereRecuperacion:=False
		  //$b_asignarNotaOficial:=False
		
		  //DESDE el 20131230
	: ([Asignaturas:18]Resultado_no_calculado:47)
		
		  //codigo antiguo
		  //[Alumnos_Calificaciones]AprobacionPendiente:=False
		  //[Alumnos_Calificaciones]Reprobada:=False
		  // **********************************
		
		
		  // Modificado por: Alexis Bustamante (09-06-2017)
		
		If ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32=-10)
			[Alumnos_Calificaciones:208]Reprobada:9:=False:C215
		Else 
			If ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32>=vrNTA_MinimoEscalaReferencia)
				Case of 
					: (iPrintActa=Notas)
						If ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33>=rGradesMinimum)
							[Alumnos_Calificaciones:208]Reprobada:9:=False:C215
						Else 
							[Alumnos_Calificaciones:208]Reprobada:9:=True:C214
						End if 
					: (iPrintActa=Puntos)
						If ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34>rPointsMinimum)
							[Alumnos_Calificaciones:208]Reprobada:9:=False:C215
						Else 
							[Alumnos_Calificaciones:208]Reprobada:9:=True:C214
						End if 
					Else 
						If ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32>=rPctMinimum)
							[Alumnos_Calificaciones:208]Reprobada:9:=False:C215
						Else 
							[Alumnos_Calificaciones:208]Reprobada:9:=True:C214
						End if 
				End case 
				
				If ([Alumnos_Calificaciones:208]Reprobada:9=False:C215)
					If ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32<vr_MinimoRecuperacion)
						[Alumnos_Calificaciones:208]AprobacionPendiente:508:=True:C214
					Else 
						[Alumnos_Calificaciones:208]AprobacionPendiente:508:=False:C215
					End if 
				End if 
			End if 
		End if 
		
		
		  //Solo para asignatura que no se claculan promedios.
		$b_guardar:=True:C214
		
	: ((vi_SinReprobacion=1) | ([Asignaturas:18]Numero_del_Nivel:6<7))
		[Alumnos_Calificaciones:208]Reprobada:9:=False:C215
		$b_calificacionAprobatoria:=True:C214
		$b_ultimoPeriodoEvaluado:=[Alumnos_Calificaciones:208]PeriodosEvaluados_bitField:503 ?? viSTR_Periodos_NumeroPeriodos
		  // segun especificaciones de Hector Rojo en ticket 112576, en adjunto a comentario del 18/12/2013, todos los alumnos hasta nivel 6 aprueban todas las asignaturas
		$b_guardar:=False:C215
	Else 
		$b_guardar:=False:C215
		
		  // CASO ESPECIAL - COLEGIO SANTA HILDA: las calificaciones del primer periodo (bimestre) no son consideradas para la aprobación/reprobación
		  // El primer trimestre corresponde al 2º bimestre, el segundo trimestre corresponde al 3er bimestre y el tercer trimestre corresponde al 4º bimestre
		  // El resto de las condiciones son las mismas que para la provincia de Buenos Aires
		Case of 
			: ((<>gCustom="@St. Hilda's College@") | (<>gRolBD="10008"))
				  // CONDICIONES PARA LA PROVINCIA DE BUENOS AIRES Y OTRAS PROVINCIAS
				$r_MinimoPromedioAnual:=70
				$r_minimoUltimoPeriodo:=40
				$r_minimoExamen:=40
				
				$b_todosPeriodosEvaluados:=([Alumnos_Calificaciones:208]PeriodosEvaluados_bitField:503 ?? 2) & ([Alumnos_Calificaciones:208]PeriodosEvaluados_bitField:503 ?? 3) & ([Alumnos_Calificaciones:208]PeriodosEvaluados_bitField:503 ?? 4)  // en el colegio Santa Hilda el primer período no cuenta.
				$b_ultimoPeriodoEvaluado:=[Alumnos_Calificaciones:208]PeriodosEvaluados_bitField:503 ?? viSTR_Periodos_NumeroPeriodos  // determino si hay evaluaciones en el último período (si no las hay la asignatura se marca como aprobada pero no se asigna la nota oficial
				$b_noHayEvaluaciones:=([Alumnos_Calificaciones:208]PeriodosEvaluados_bitField:503=0) & ([Alumnos_Calificaciones:208]ExamenAnual_Real:16=-10)  // no hay evaluaciones en ningún periodo ni hay evaluaciones de examen (en Argentina las cosas son raras)
				$b_hayEvaluacionesPendientes:=([Alumnos_Calificaciones:208]Anual_Real:11=-2)
				
				  // determino, en función de las condiciones anteriores y del promedio anual definitivo (incluyendo el último período)  o provisorio (cuando el último período no ha sido evaluado)
				  // si es posible asumir que las calificaciones del alumno hasta la fecha implican aprobación/o reprobación de la asignatura
				$b_calificacionAprobatoria:=True:C214
				If ($b_todosPeriodosEvaluados & $b_ultimoPeriodoEvaluado & Not:C34($b_hayEvaluacionesPendientes))
					$b_calificacionAprobatoria:=([Alumnos_Calificaciones:208]P04_Final_Real:337>=$r_minimoUltimoPeriodo) & ([Alumnos_Calificaciones:208]Anual_Real:11>=$r_MinimoPromedioAnual) & ([Alumnos_Calificaciones:208]ExamenAnual_Real:16=-10)
					$b_calificacionAprobatoria:=$b_calificacionAprobatoria | ([Alumnos_Calificaciones:208]ExamenAnual_Real:16>=$r_minimoExamen) | ([Alumnos_Calificaciones:208]ExamenExtra_Real:21>=$r_minimoExamen)
				End if 
				
				
				
			: ((<>gRegion="Capital Federal") | (<>gRegion="Distrito Federal"))
				  //CONDICIONES DE PROMOCION CAPITAL FEDERAL
				Case of 
					: (([Asignaturas:18]GrupoEstadistico:89="Ingles") & ((<>gCustom="@Langeley@") | (<>gCustom="@Lange Ley@") | (<>gRolBD="AR242")))
						$r_MinimoPromedioAnual:=70
						$r_minimoUltimoPeriodo:=70
						$r_minimoExamen:=60
						$b_calificacionAprobatoria:=$b_calificacionAprobatoria | ([Alumnos_Calificaciones:208]ExamenAnual_Real:16>=$r_minimoExamen) | ([Alumnos_Calificaciones:208]ExamenExtra_Real:21>=$r_minimoExamen)  // si la calificación anual es aprobatoria o el examen es superior o igual
						
						
					: (($b_BachilleratoModalizado) & ([Asignaturas:18]Numero_del_Nivel:6=12))
						  // segun especificaciones de Hector Rojo en ticket 112576,  en adjunto a comentario del 18/12/2013, esta excepción ya no aplica para en bachillerato modalizado
						  //$r_MinimoPromedioAnual:=70
						  //$r_minimoUltimoPeriodo:=0
						  //$r_minimoExamen:=60
						
					: ((Not:C34($b_BachilleratoModalizado)) & ([Asignaturas:18]Numero_del_Nivel:6>=7))
						$r_MinimoPromedioAnual:=60
						$r_minimoUltimoPeriodo:=60
						$r_minimoExamen:=60
				End case 
				
				
				$t_cursoAlumno:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[Alumnos_Calificaciones:208]ID_Alumno:6;->[Alumnos:2]curso:20)
				
				$b_todosPeriodosEvaluados:=([Alumnos_Calificaciones:208]PeriodosEvaluados_bitField:503 ?? 1) & ([Alumnos_Calificaciones:208]PeriodosEvaluados_bitField:503 ?? 2) & ([Alumnos_Calificaciones:208]PeriodosEvaluados_bitField:503 ?? 3)
				$b_ultimoPeriodoEvaluado:=[Alumnos_Calificaciones:208]PeriodosEvaluados_bitField:503 ?? viSTR_Periodos_NumeroPeriodos
				$b_noHayEvaluaciones:=([Alumnos_Calificaciones:208]PeriodosEvaluados_bitField:503=0) & ([Alumnos_Calificaciones:208]ExamenAnual_Real:16=-10) | ([Alumnos_Calificaciones:208]ExamenExtra_Real:21>=$r_minimoExamen)  // no hay evaluaciones en ningún periodo ni hay evaluaciones de examen
				$b_hayEvaluacionesPendientes:=([Alumnos_Calificaciones:208]Anual_Real:11=-2)
				
				  // determino, en función de las condiciones anteriores y del promedio anual definitivo (incluyendo el último período)  o provisorio (cuando el último período no ha sido evaluado)
				  // si es posible asumir que las calificaciones del alumno hasta la fecha implican aprobación/o reprobación de la asignatura
				$b_calificacionAprobatoria:=True:C214
				If ($b_todosPeriodosEvaluados & $b_ultimoPeriodoEvaluado & Not:C34($b_hayEvaluacionesPendientes))
					$b_calificacionAprobatoria:=([Alumnos_Calificaciones:208]Anual_Real:11>=$r_MinimoPromedioAnual) & ([Alumnos_Calificaciones:208]P03_Final_Real:262>=$r_minimoUltimoPeriodo) & ([Alumnos_Calificaciones:208]ExamenAnual_Real:16=-10)  // si no hay examen y el promedio anual es superior o igual al mínimo requerido
					$b_calificacionAprobatoria:=$b_calificacionAprobatoria | ([Alumnos_Calificaciones:208]ExamenAnual_Real:16>=$r_minimoExamen) | ([Alumnos_Calificaciones:208]ExamenExtra_Real:21>=$r_minimoExamen)  // si la calificación anual es aprobatoria o el examen es superior o igual
				End if 
				
				
			Else 
				  // CONDICIONES PARA LA PROVINCIA DE BUENOS AIRES Y OTRAS PROVINCIAS
				$r_MinimoPromedioAnual:=70
				$r_minimoUltimoPeriodo:=40
				$r_minimoExamen:=40
				
				$b_todosPeriodosEvaluados:=([Alumnos_Calificaciones:208]PeriodosEvaluados_bitField:503 ?? 1) & ([Alumnos_Calificaciones:208]PeriodosEvaluados_bitField:503 ?? 2) & ([Alumnos_Calificaciones:208]PeriodosEvaluados_bitField:503 ?? 3)
				$b_ultimoPeriodoEvaluado:=[Alumnos_Calificaciones:208]PeriodosEvaluados_bitField:503 ?? viSTR_Periodos_NumeroPeriodos  // determino si hay evaluaciones en el último período (si no las hay la asignatura se marca como aprobada pero no se asigna la nota oficial
				$b_noHayEvaluaciones:=([Alumnos_Calificaciones:208]PeriodosEvaluados_bitField:503=0) & ([Alumnos_Calificaciones:208]ExamenAnual_Real:16=-10)  // no hay evaluaciones en ningún periodo ni hay evaluaciones de examen (en Argentina las cosas son raras)
				$b_hayEvaluacionesPendientes:=([Alumnos_Calificaciones:208]Anual_Real:11=-2)
				
				  // determino, en función de las condiciones anteriores y del promedio anual definitivo (incluyendo el último período)  o provisorio (cuando el último período no ha sido evaluado)
				  // si es posible asumir que las calificaciones del alumno hasta la fecha implican aprobación/o reprobación de la asignatura
				$b_calificacionAprobatoria:=True:C214
				If ($b_todosPeriodosEvaluados & $b_ultimoPeriodoEvaluado & Not:C34($b_hayEvaluacionesPendientes))
					$b_calificacionAprobatoria:=([Alumnos_Calificaciones:208]P03_Final_Real:262>=$r_minimoUltimoPeriodo) & ([Alumnos_Calificaciones:208]Anual_Real:11>=$r_MinimoPromedioAnual) & ([Alumnos_Calificaciones:208]ExamenAnual_Real:16=-10)
					$b_calificacionAprobatoria:=$b_calificacionAprobatoria | ([Alumnos_Calificaciones:208]ExamenAnual_Real:16>=$r_minimoExamen) | ([Alumnos_Calificaciones:208]ExamenExtra_Real:21>=$r_minimoExamen)
				End if 
				
		End case 
End case 



  // Modificado por: Alexis Bustamante (09-06-2017)


  //Agrego validacion solo para el caso en que la asignatura tiene No calcular Promedios 
  //

If ($b_guardar)
	$b_asignarNotaOficial:=True:C214
Else 
	$b_asignarNotaOficial:=$b_ultimoPeriodoEvaluado & $b_calificacionAprobatoria
	[Alumnos_Calificaciones:208]Reprobada:9:=Not:C34($b_calificacionAprobatoria)
	[Alumnos_Calificaciones:208]RequiereRecuperacion:507:=Not:C34($b_calificacionAprobatoria)
End if 


If (Not:C34($b_asignarNotaOficial))
	[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=-10
	[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30:=""
	[Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27:=-10
	[Alumnos_Calificaciones:208]EvaluacionFinal_Puntos:28:=-10
	[Alumnos_Calificaciones:208]EvaluacionFinal_Simbolo:29:=""
	
	[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32:=-10
	[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Palabras:492:=""
	[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33:=-10
	[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34:=-10
	[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36:=""
	[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Simbolo:35:=""
End if 
SAVE RECORD:C53([Alumnos_Calificaciones:208])

