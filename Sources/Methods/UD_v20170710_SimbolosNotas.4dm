//%attributes = {}
  // Método: UD_v20170710_SimbolosNotas
  //
  //
  // por Alberto Bachler Klein
  // creación 10/07/17, 11:38:08
  //MONO Correcciones Ticket 192441
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_BOOLEAN:C305($b_convertirEstiloOficial;$b_guardaRegistro;$b_notaOficialEstiloLocal;$b_usarEstiloAsignatura)
C_LONGINT:C283($i_records;$i_registros;$l_decimalesNotas;$l_decimalesPuntos;$l_estiloOficial;$l_idEstiloEvaluacion;$l_nivel;$l_numeroTabla;$l_progress;$l_recNumCompetencia)
C_LONGINT:C283($l_registros)
C_POINTER:C301($y_nota;$y_puntos;$y_real;$y_simbolo;$y_tabla)
C_REAL:C285($l_FieldNumber_PrimeraEval;$l_FieldNumber_UltimaEval)
C_TEXT:C284($t_alumno;$t_asignatura;$t_asunto;$t_copia;$t_copiaCC;$t_Cuerpo;$t_destinatario;$t_error;$t_rutaArchivo;$t_simbolo)
C_TEXT:C284($t_versionBaseDeDatos;$t_versionEstructura)

ARRAY LONGINT:C221($al_idCompetencia;0)
ARRAY LONGINT:C221($al_Periodo;0)
ARRAY LONGINT:C221($al_recNums;0)
ARRAY POINTER:C280($ay_columnas;0)
ARRAY REAL:C219($ar_notaCorregida;0)
ARRAY REAL:C219($ar_notaRegistrada;0)
ARRAY REAL:C219($ar_puntosCorregido;0)
ARRAY REAL:C219($ar_puntosRegistrado;0)
ARRAY REAL:C219($ar_realCorregido;0)
ARRAY REAL:C219($ar_realP1;0)
ARRAY REAL:C219($ar_realP2;0)
ARRAY REAL:C219($ar_realP3;0)
ARRAY REAL:C219($ar_realP4;0)
ARRAY REAL:C219($ar_realP5;0)
ARRAY REAL:C219($ar_RealRegistrado;0)
ARRAY TEXT:C222($at_adjuntos;0)
ARRAY TEXT:C222($at_alumno;0)
ARRAY TEXT:C222($at_asignaturas;0)
ARRAY TEXT:C222($at_competencia;0)
ARRAY TEXT:C222($at_encabezados;0)
ARRAY TEXT:C222($at_estilosFuleros;0)
ARRAY TEXT:C222($at_parcial;0)
ARRAY TEXT:C222($at_simboloP1;0)
ARRAY TEXT:C222($at_simboloP2;0)
ARRAY TEXT:C222($at_simboloP3;0)
ARRAY TEXT:C222($at_simboloP4;0)
ARRAY TEXT:C222($at_simboloP5;0)
ARRAY TEXT:C222($at_simboloRegistrado;0)

ALL RECORDS:C47([xxSTR_EstilosEvaluacion:44])
CREATE EMPTY SET:C140([xxSTR_EstilosEvaluacion:44];"$enSimbolos")

$y_tabla:=->[xxSTR_EstilosEvaluacion:44]
LONGINT ARRAY FROM SELECTION:C647($y_tabla->;$al_recNums)
READ ONLY:C145($y_tabla->)
For ($i_registros;1;Records in selection:C76($y_tabla->))
	GOTO RECORD:C242($y_tabla->;$al_recNums{$i_registros})
	EVS_ReadStyleData ([xxSTR_EstilosEvaluacion:44]ID:1)
	If (iEvaluationMode=Simbolos)
		ADD TO SET:C119([xxSTR_EstilosEvaluacion:44];"$enSimbolos")
	End if 
End for 


USE SET:C118("$enSimbolos")
KRL_RelateSelection (->[Asignaturas:18]Numero_de_EstiloEvaluacion:39;->[xxSTR_EstilosEvaluacion:44]ID:1)
KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Asignatura:5;->[Asignaturas:18]Numero:1)
QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]Año:3=<>GYEAR;*)
QUERY SELECTION:C341([Alumnos_Calificaciones:208]; & [Alumnos_Calificaciones:208]PeriodosEvaluados_bitField:503>0)
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
ORDER BY:C49([Alumnos_Calificaciones:208];[Asignaturas:18]Numero_de_EstiloEvaluacion:39;>)
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)


$l_progress:=Progress New 
Progress SET TITLE ($l_progress;"Verificando equivalencias símbolos-numéricos…";0;"en registros de calificaciones…")
Progress SET ICON ($l_progress;<>p_iconoColegium)

$y_tabla:=->[Alumnos_Calificaciones:208]
$l_numeroTabla:=Table:C252($y_tabla)
LONGINT ARRAY FROM SELECTION:C647($y_tabla->;$al_recNums)
READ WRITE:C146($y_tabla->)
$l_registros:=Records in selection:C76($y_tabla->)

For ($i_registros;1;$l_registros)
	$b_guardaRegistro:=False:C215
	GOTO RECORD:C242($y_tabla->;$al_recNums{$i_registros})
	Progress SET PROGRESS ($l_progress;$i_registros/$l_registros)
	
	$t_asignatura:=KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[Alumnos_Calificaciones:208]ID_Asignatura:5;->[Asignaturas:18]Asignatura:3)
	$t_alumno:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[Alumnos_Calificaciones:208]ID_Alumno:6;->[Alumnos:2]apellidos_y_nombres:40)
	$l_idEstiloEvaluacion:=KRL_GetNumericFieldData (->[Asignaturas:18]Numero:1;->[Alumnos_Calificaciones:208]ID_Asignatura:5;->[Asignaturas:18]Numero_de_EstiloEvaluacion:39)
	$l_nivel:=KRL_GetNumericFieldData (->[Asignaturas:18]Numero:1;->[Alumnos_Calificaciones:208]ID_Asignatura:5;->[Asignaturas:18]Numero_del_Nivel:6)
	$b_usarEstiloAsignatura:=KRL_GetBooleanFieldData (->[Asignaturas:18]Numero:1;->[Alumnos_Calificaciones:208]ID_Asignatura:5;->[Asignaturas:18]NotaOficial_conEstiloAsignatura:95)
	$b_convertirEstiloOficial:=KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_nivel;->[xxSTR_Niveles:6]ConvertirEval_a_EstiloOficial:37)
	
	EVS_ReadStyleData ($l_idEstiloEvaluacion)
	
	$l_decimalesNotas:=iGradesDEC
	$l_decimalesPuntos:=iPointsDEC
	
	  //PARCIALES DE TODOS LOS PERIODOS
	For ($i_periodo;1;5)
		
		For ($i_nota;1;12)
			$y_literal:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($i_periodo)+"_Eval"+String:C10($i_nota;"00")+"_Literal")
			$y_real:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($i_periodo)+"_Eval"+String:C10($i_nota;"00")+"_Real")
			$y_nota:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($i_periodo)+"_Eval"+String:C10($i_nota;"00")+"_Nota")
			$y_puntos:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($i_periodo)+"_Eval"+String:C10($i_nota;"00")+"_Puntos")
			$y_simbolo:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($i_periodo)+"_Eval"+String:C10($i_nota;"00")+"_Simbolo")
			If ($y_simbolo->#"")
				$t_simbolo:=EV2_Real_a_Literal ($y_real->;Simbolos)
				If ($t_simbolo#$y_simbolo->)
					$y_real->:=EV2_Simbolo_a_Real ($t_simbolo)
					$y_nota->:=EV2_Real_a_Nota ($y_real->;0;$l_decimalesNotas)
					$y_puntos->:=EV2_Real_a_Puntos ($y_real->;0;$l_decimalesPuntos)
					$y_simbolo->:=$t_simbolo
					$y_literal->:=$t_simbolo
					APPEND TO ARRAY:C911($at_estilosFuleros;[xxSTR_EstilosEvaluacion:44]Name:2)
					APPEND TO ARRAY:C911($at_asignaturas;$t_asignatura)
					APPEND TO ARRAY:C911($at_alumno;$t_alumno)
					APPEND TO ARRAY:C911($at_parcial;String:C10($i_nota))
					APPEND TO ARRAY:C911($al_Periodo;$i_periodo)
					APPEND TO ARRAY:C911($at_simboloRegistrado;$y_simbolo->)
					APPEND TO ARRAY:C911($ar_RealRegistrado;Old:C35($y_real->))
					APPEND TO ARRAY:C911($ar_realCorregido;$y_real->)
					APPEND TO ARRAY:C911($ar_notaRegistrada;Old:C35($y_nota->))
					APPEND TO ARRAY:C911($ar_notaCorregida;$y_nota->)
					APPEND TO ARRAY:C911($ar_puntosRegistrado;Old:C35($y_puntos->))
					APPEND TO ARRAY:C911($ar_puntosCorregido;$y_puntos->)
					$b_guardaRegistro:=True:C214
					
				End if 
				
			End if 
			
		End for 
		
	End for 
	
	  //CONTROLES DE PERIODO
	For ($i_periodo;1;5)
		$y_literal:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($i_periodo)+"_Control_Literal")
		$y_real:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($i_periodo)+"_Control_Real")
		$y_simbolo:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($i_periodo)+"_Control_Simbolo")
		$y_nota:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($i_periodo)+"_Control_Nota")
		$y_puntos:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($i_periodo)+"_Control_Puntos")
		
		If ($y_simbolo->#"")
			$t_simbolo:=EV2_Real_a_Literal ($y_real->;Simbolos)
			If ($t_simbolo#$y_simbolo->)
				$y_real->:=EV2_Simbolo_a_Real ($t_simbolo)
				$y_nota->:=EV2_Real_a_Nota ($y_real->;0;$l_decimalesNotas)
				$y_puntos->:=EV2_Real_a_Puntos ($y_real->;0;$l_decimalesPuntos)
				$y_simbolo->:=$t_simbolo
				$y_literal->:=$t_simbolo
				APPEND TO ARRAY:C911($at_estilosFuleros;[xxSTR_EstilosEvaluacion:44]Name:2)
				APPEND TO ARRAY:C911($at_asignaturas;$t_asignatura)
				APPEND TO ARRAY:C911($at_alumno;$t_alumno)
				APPEND TO ARRAY:C911($at_parcial;"CP")
				APPEND TO ARRAY:C911($al_Periodo;$i_periodo)
				APPEND TO ARRAY:C911($at_simboloRegistrado;$y_simbolo->)
				APPEND TO ARRAY:C911($ar_RealRegistrado;Old:C35($y_real->))
				APPEND TO ARRAY:C911($ar_realCorregido;$y_real->)
				APPEND TO ARRAY:C911($ar_notaRegistrada;Old:C35($y_nota->))
				APPEND TO ARRAY:C911($ar_notaCorregida;$y_nota->)
				APPEND TO ARRAY:C911($ar_puntosRegistrado;Old:C35($y_puntos->))
				APPEND TO ARRAY:C911($ar_puntosCorregido;$y_puntos->)
				$b_guardaRegistro:=True:C214
			End if 
		End if 
		
	End for 
	
	  //PROMEDIOS PERIODO
	$l_decimalesNotas:=iGradesDECPP
	$l_decimalesPuntos:=iPointsDECPP
	
	For ($i_periodo;1;5)
		$y_literal:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($i_periodo)+"_Final_Literal")
		$y_real:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($i_periodo)+"_Final_Real")
		$y_simbolo:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($i_periodo)+"_Final_Simbolo")
		$y_nota:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($i_periodo)+"_Final_Nota")
		$y_puntos:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($i_periodo)+"_Final_Puntos")
		If ($y_simbolo->#"")
			$t_simbolo:=EV2_Real_a_Literal ($y_real->;Simbolos)
			If ($t_simbolo#$y_simbolo->)
				$y_real->:=EV2_Simbolo_a_Real ($t_simbolo)
				$y_nota->:=EV2_Real_a_Nota ($y_real->;0;$l_decimalesNotas)
				$y_puntos->:=EV2_Real_a_Puntos ($y_real->;0;$l_decimalesPuntos)
				$y_simbolo->:=$t_simbolo
				$y_literal->:=$t_simbolo
				
				APPEND TO ARRAY:C911($at_estilosFuleros;[xxSTR_EstilosEvaluacion:44]Name:2)
				APPEND TO ARRAY:C911($at_asignaturas;$t_asignatura)
				APPEND TO ARRAY:C911($at_alumno;$t_alumno)
				APPEND TO ARRAY:C911($at_parcial;"PP")
				APPEND TO ARRAY:C911($al_Periodo;$i_periodo)
				APPEND TO ARRAY:C911($at_simboloRegistrado;$y_simbolo->)
				APPEND TO ARRAY:C911($ar_RealRegistrado;Old:C35($y_real->))
				APPEND TO ARRAY:C911($ar_realCorregido;$y_real->)
				APPEND TO ARRAY:C911($ar_notaRegistrada;Old:C35($y_nota->))
				APPEND TO ARRAY:C911($ar_notaCorregida;$y_nota->)
				APPEND TO ARRAY:C911($ar_puntosRegistrado;Old:C35($y_puntos->))
				APPEND TO ARRAY:C911($ar_puntosCorregido;$y_puntos->)
				$b_guardaRegistro:=True:C214
				
			End if 
		End if 
		
	End for 
	
	  //PROMEDIO ANUAL
	$l_decimalesNotas:=iGradesDECPF
	$l_decimalesPuntos:=iPointsDECPF
	
	$y_literal:=->[Alumnos_Calificaciones:208]Anual_Literal:15
	$y_real:=->[Alumnos_Calificaciones:208]Anual_Real:11
	$y_simbolo:=->[Alumnos_Calificaciones:208]Anual_Simbolo:14
	$y_nota:=->[Alumnos_Calificaciones:208]Anual_Nota:12
	$y_puntos:=->[Alumnos_Calificaciones:208]Anual_Puntos:13
	If ($y_simbolo->#"")
		$t_simbolo:=EV2_Real_a_Literal ($y_real->;Simbolos)
		If ($t_simbolo#$y_simbolo->)
			$y_real->:=EV2_Simbolo_a_Real ($t_simbolo)
			$y_nota->:=EV2_Real_a_Nota ($y_real->;0;$l_decimalesNotas)
			$y_puntos->:=EV2_Real_a_Puntos ($y_real->;0;$l_decimalesPuntos)
			$y_simbolo->:=$t_simbolo
			$y_literal->:=$t_simbolo
			
			APPEND TO ARRAY:C911($at_estilosFuleros;[xxSTR_EstilosEvaluacion:44]Name:2)
			APPEND TO ARRAY:C911($at_asignaturas;$t_asignatura)
			APPEND TO ARRAY:C911($at_alumno;$t_alumno)
			APPEND TO ARRAY:C911($at_parcial;"PA")
			APPEND TO ARRAY:C911($al_Periodo;0)
			APPEND TO ARRAY:C911($at_simboloRegistrado;$y_simbolo->)
			APPEND TO ARRAY:C911($ar_RealRegistrado;Old:C35($y_real->))
			APPEND TO ARRAY:C911($ar_realCorregido;$y_real->)
			APPEND TO ARRAY:C911($ar_notaRegistrada;Old:C35($y_nota->))
			APPEND TO ARRAY:C911($ar_notaCorregida;$y_nota->)
			APPEND TO ARRAY:C911($ar_puntosRegistrado;Old:C35($y_puntos->))
			APPEND TO ARRAY:C911($ar_puntosCorregido;$y_puntos->)
			$b_guardaRegistro:=True:C214
			
		End if 
	End if 
	
	  //PROMEDIO FINAL
	$l_decimalesNotas:=iGradesDecNF
	$l_decimalesPuntos:=iPointsDecNF
	y_literal:=->[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30
	$y_real:=->[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26
	$y_simbolo:=->[Alumnos_Calificaciones:208]EvaluacionFinal_Simbolo:29
	$y_nota:=->[Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27
	$y_puntos:=->[Alumnos_Calificaciones:208]EvaluacionFinal_Puntos:28
	If ($y_simbolo->#"")
		$t_simbolo:=EV2_Real_a_Literal ($y_real->;Simbolos)
		If ($t_simbolo#$y_simbolo->)
			$y_real->:=EV2_Simbolo_a_Real ($t_simbolo)
			$y_nota->:=EV2_Real_a_Nota ($y_real->;0;$l_decimalesNotas)
			$y_puntos->:=EV2_Real_a_Puntos ($y_real->;0;$l_decimalesPuntos)
			$y_simbolo->:=$t_simbolo
			$y_literal->:=$t_simbolo
			
			APPEND TO ARRAY:C911($at_estilosFuleros;[xxSTR_EstilosEvaluacion:44]Name:2)
			APPEND TO ARRAY:C911($at_asignaturas;$t_asignatura)
			APPEND TO ARRAY:C911($at_alumno;$t_alumno)
			APPEND TO ARRAY:C911($at_parcial;"NF")
			APPEND TO ARRAY:C911($al_Periodo;0)
			APPEND TO ARRAY:C911($at_simboloRegistrado;$y_simbolo->)
			APPEND TO ARRAY:C911($ar_RealRegistrado;Old:C35($y_real->))
			APPEND TO ARRAY:C911($ar_realCorregido;$y_real->)
			APPEND TO ARRAY:C911($ar_notaRegistrada;Old:C35($y_nota->))
			APPEND TO ARRAY:C911($ar_notaCorregida;$y_nota->)
			APPEND TO ARRAY:C911($ar_puntosRegistrado;Old:C35($y_puntos->))
			APPEND TO ARRAY:C911($ar_puntosCorregido;$y_puntos->)
			$b_guardaRegistro:=True:C214
			
		End if 
	End if 
	
	  //PROMEDIO FINAL OFICIAL
	$l_decimalesNotas:=iGradesDecNO
	$l_decimalesPuntos:=iPointsDecNO
	$y_literal:=->[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36
	$y_real:=->[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32
	$y_simbolo:=->[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Simbolo:35
	$y_nota:=->[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33
	$y_puntos:=->[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34
	
	If ($y_simbolo->#"")
		
		If ($b_convertirEstiloOficial & Not:C34($b_usarEstiloAsignatura))
			$l_estiloOficial:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_nivel;->[xxSTR_Niveles:6]EvStyle_oficial:23)
			EVS_ReadStyleData ($l_estiloOficial)
			$l_decimalesNotas:=iGradesDecNO
			$l_decimalesPuntos:=iPointsDecNO
		End if 
		
		$t_simbolo:=EV2_Real_a_Literal ($y_real->;Simbolos)
		
		If ($t_simbolo#$y_simbolo->)
			
			$y_real->:=EV2_Simbolo_a_Real ($t_simbolo)
			$y_nota->:=EV2_Real_a_Nota ($y_real->;0;$l_decimalesNotas)
			$y_puntos->:=EV2_Real_a_Puntos ($y_real->;0;$l_decimalesPuntos)
			$y_literal->:=EV2_Real_a_Literal ($y_real->)
			$y_simbolo->:=$t_simbolo
			
			APPEND TO ARRAY:C911($at_estilosFuleros;[xxSTR_EstilosEvaluacion:44]Name:2)
			APPEND TO ARRAY:C911($at_asignaturas;$t_asignatura)
			APPEND TO ARRAY:C911($at_alumno;$t_alumno)
			APPEND TO ARRAY:C911($at_parcial;"NF")
			APPEND TO ARRAY:C911($al_Periodo;0)
			APPEND TO ARRAY:C911($at_simboloRegistrado;$y_simbolo->)
			APPEND TO ARRAY:C911($ar_RealRegistrado;Old:C35($y_real->))
			APPEND TO ARRAY:C911($ar_realCorregido;$y_real->)
			APPEND TO ARRAY:C911($ar_notaRegistrada;Old:C35($y_nota->))
			APPEND TO ARRAY:C911($ar_notaCorregida;$y_nota->)
			APPEND TO ARRAY:C911($ar_puntosRegistrado;Old:C35($y_puntos->))
			APPEND TO ARRAY:C911($ar_puntosCorregido;$y_puntos->)
			$b_guardaRegistro:=True:C214
			If (Not:C34($b_notaOficialEstiloLocal))
				EVS_ReadStyleData ($l_idEstiloEvaluacion)
			End if 
		End if 
	End if 
	
	If ($b_guardaRegistro)
		SAVE RECORD:C53([Alumnos_Calificaciones:208])
	End if 
End for 
Progress QUIT ($l_progress)


If (Size of array:C274($at_estilosFuleros)>0)
	AT_AppendItems2TextArray (->$at_encabezados;"Estilo evaluación";"Asignatura";"Alumno";"Periodo";"Tipo";"Simbolo";"Real registrado";"Real ajustado";"Nota registrada";"Nota ajustada";"Puntos registrado";"Puntos ajustado")
	APPEND TO ARRAY:C911($ay_columnas;->$at_estilosFuleros)
	APPEND TO ARRAY:C911($ay_columnas;->$at_asignaturas)
	APPEND TO ARRAY:C911($ay_columnas;->$at_alumno)
	APPEND TO ARRAY:C911($ay_columnas;->$al_Periodo)
	APPEND TO ARRAY:C911($ay_columnas;->$at_parcial)
	APPEND TO ARRAY:C911($ay_columnas;->$at_simboloRegistrado)
	APPEND TO ARRAY:C911($ay_columnas;->$ar_RealRegistrado)
	APPEND TO ARRAY:C911($ay_columnas;->$ar_realCorregido)
	APPEND TO ARRAY:C911($ay_columnas;->$ar_notaRegistrada)
	APPEND TO ARRAY:C911($ay_columnas;->$ar_notaCorregida)
	APPEND TO ARRAY:C911($ay_columnas;->$ar_puntosRegistrado)
	APPEND TO ARRAY:C911($ay_columnas;->$ar_puntosCorregido)
	
	MULTI SORT ARRAY:C718($at_alumno;>;$at_asignaturas;>;$at_estilosFuleros;>;$al_Periodo;>;$at_parcial;>;$at_simboloRegistrado;$ar_RealRegistrado;$ar_realCorregido;$ar_notaRegistrada;$ar_notaCorregida;$ar_puntosRegistrado;$ar_puntosCorregido)
	
	$t_rutaArchivo:=Get 4D folder:C485(Logs folder:K5:19)+"Ajuste de equivalencias símbolos-reales en calificaciones.xls"
	XLS_GeneraArchivo ($t_rutaArchivo;"";"";->$at_encabezados;->$ay_columnas)
	APPEND TO ARRAY:C911($at_adjuntos;$t_rutaArchivo)
	
	$t_asunto:="Ajuste de equivalencias símbolos-reales en registros de calificaciones ["+<>gCustom+"]"
	$t_Cuerpo:="Durante la actualización a la versión ^2 se detectaron y corrigieron inconsistencias en las equivalencias de simbolos en los registros de calificaciones."
	$t_Cuerpo:=$t_Cuerpo+"\r\rEl documento adjunto contiene información detallada de todas las correcciones realizadas."
	$t_Cuerpo:=$t_Cuerpo+"\r\r"+__ ("Nombre del computador: ")+Current machine:C483
	$t_Cuerpo:=$t_Cuerpo+"\r"+__ ("Nombre del usuario activo: ")+Current system user:C484
	$t_Cuerpo:=$t_Cuerpo+"\r"+__ ("Ruta de la base de datos: \r")+Data file:C490
	$t_asunto:=Replace string:C233($t_asunto;"^2";$t_versionEstructura)
	$t_Cuerpo:=Replace string:C233($t_Cuerpo;"^1";$t_versionBaseDeDatos)
	$t_Cuerpo:=Replace string:C233($t_Cuerpo;"^2";$t_versionEstructura)
	$t_destinatario:="laravena@colegium.com"
	$t_copia:="qa@colegium.com"
	$t_copiaCC:="abachler@colegium.com,rcatalan@colegium.com,abustamante@colegium.com"
	$t_error:=Mail_EnviaNotificacion ($t_asunto;$t_Cuerpo;$t_destinatario;$t_copia;$t_copiaCC;->$at_adjuntos;__ ("Enviando informe de actualización a Colegium..."))
End if 



