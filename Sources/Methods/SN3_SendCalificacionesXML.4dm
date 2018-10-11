//%attributes = {}
  //SN3_SendCalificacionesXML

  //`======
  // Modified by: abachler (5/2/10)
vb_ConstantesModificadas:=True:C214
  //`======


C_BOOLEAN:C305($1;$2;$todos;$useArrays)
C_TIME:C306($refXMLDoc)

$todos:=True:C214
$useArrays:=False:C215
Case of 
	: (Count parameters:C259=1)
		$todos:=$1
	: (Count parameters:C259=2)
		$todos:=$1
		$useArrays:=$2
End case 

$currentErrorHandler:=SN3_SetErrorHandler ("set")

SN3_BuildSelections (SN3_DTi_Calificaciones;$todos;$useArrays)
If (Records in selection:C76([Alumnos_Calificaciones:208])>0)
	ARRAY LONGINT:C221($arrayLong;0)
	ARRAY LONGINT:C221($recNums;0)
	SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208];$recNums;[Alumnos_Calificaciones:208]ID:506;$arrayLong)
	
	$size:=Size of array:C274($recNums)
	
	$vt_FileName:=SN3_CreateFile2Send ("crear";"";SN3_Calificaciones;"sax";->$refXMLDoc)
	SN3_BuildFileHeader ($refXMLDoc;SN3_Calificaciones;"calificaciones";$todos;$useArrays)
	
	$lastNivel:=-MAXLONG:K35:2
	
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando documento con ")+String:C10($size)+__ (" registros de calificaciones..."))
	$numXMLs:=0
	$openXML:=True:C214
	For ($indice;1;$size)
		If ($numXMLs>=60000)
			  //cerrar
			SN3_CloseXMLCompress ("";$vt_FileName;"sax";$refXMLDoc)
			$openXML:=False:C215
			$vt_FileName:=SN3_CreateFile2Send ("crear";"";SN3_Calificaciones;"sax";->$refXMLDoc)
			SN3_BuildFileHeader ($refXMLDoc;SN3_Calificaciones;"calificaciones";$todos;$useArrays)
			
			$lastNivel:=-MAXLONG:K35:2
			$numXMLs:=0
			$openXML:=True:C214
		End if 
		KRL_GotoRecord (->[Alumnos_Calificaciones:208];$recNums{$indice};False:C215)
		RELATE ONE:C42([Alumnos_Calificaciones:208]Llave_principal:1)
		RELATE ONE:C42([Alumnos_Calificaciones:208]ID_Asignatura:5)
		PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
		
		If ([Asignaturas:18]Numero_del_Nivel:6#$lastNivel)
			$lastNivel:=[Asignaturas:18]Numero_del_Nivel:6
		End if 
		For ($iPeriodo;1;viSTR_Periodos_NumeroPeriodos)
			For ($i;1;12)
				$parcial:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P"+String:C10($iPeriodo;"00")+"_Eval"+String:C10($i;"00")+"_Literal")
				$parcialR:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P"+String:C10($iPeriodo;"00")+"_Eval"+String:C10($i;"00")+"_Real")
				$parcialN:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P"+String:C10($iPeriodo;"00")+"_Eval"+String:C10($i;"00")+"_Nota")
				$parcialP:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P"+String:C10($iPeriodo;"00")+"_Eval"+String:C10($i;"00")+"_Puntos")
				$parcialS:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P"+String:C10($iPeriodo;"00")+"_Eval"+String:C10($i;"00")+"_Simbolo")
				
				SN3_BuildCalificacionTag (->$numXMLs;$refXMLDoc;[Alumnos_Calificaciones:208]ID:506;[Alumnos_Calificaciones:208]ID_Alumno:6;[Alumnos_Calificaciones:208]ID_Asignatura:5;String:C10($iPeriodo);"parcial"+String:C10($i);$parcial->;$parcialR->;$parcialN->;$parcialP->;$parcialS->;[Asignaturas:18]Numero_de_EstiloEvaluacion:39)
				
			End for 
			
			$control:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($iPeriodo)+"_Control_Literal")
			$controlR:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($iPeriodo)+"_Control_Real")
			$controlN:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($iPeriodo)+"_Control_Nota")
			$controlP:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($iPeriodo)+"_Control_Puntos")
			$controlS:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($iPeriodo)+"_Control_Simbolo")
			
			SN3_BuildCalificacionTag (->$numXMLs;$refXMLDoc;[Alumnos_Calificaciones:208]ID:506;[Alumnos_Calificaciones:208]ID_Alumno:6;[Alumnos_Calificaciones:208]ID_Asignatura:5;String:C10($iPeriodo);"control";$control->;$controlR->;$controlN->;$controlP->;$controlS->;[Asignaturas:18]Numero_de_EstiloEvaluacion:39)
			
			$presentacion:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($iPeriodo)+"_Presentacion_Literal")
			$presentacionR:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($iPeriodo)+"_Presentacion_Real")
			$presentacionN:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($iPeriodo)+"_Presentacion_Nota")
			$presentacionP:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($iPeriodo)+"_Presentacion_Puntos")
			$presentacionS:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($iPeriodo)+"_Presentacion_Simbolo")
			
			SN3_BuildCalificacionTag (->$numXMLs;$refXMLDoc;[Alumnos_Calificaciones:208]ID:506;[Alumnos_Calificaciones:208]ID_Alumno:6;[Alumnos_Calificaciones:208]ID_Asignatura:5;String:C10($iPeriodo);"presentacion";$presentacion->;$presentacionR->;$presentacionN->;$presentacionP->;$presentacionS->;[Asignaturas:18]Numero_de_EstiloEvaluacion:39)
			
			
			$esfuerzo:=KRL_GetFieldPointerByName ("[Alumnos_ComplementoEvaluacion]P0"+String:C10($iPeriodo)+"_Esfuerzo")
			SN3_BuildCalificacionTag (->$numXMLs;$refXMLDoc;[Alumnos_Calificaciones:208]ID:506;[Alumnos_Calificaciones:208]ID_Alumno:6;[Alumnos_Calificaciones:208]ID_Asignatura:5;String:C10($iPeriodo);"esfuerzo";$esfuerzo->)
			
			$promedioperiodo:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($iPeriodo)+"_Final_Literal")
			$promedioperiodoR:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($iPeriodo)+"_Final_Real")
			$promedioperiodoN:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($iPeriodo)+"_Final_Nota")
			$promedioperiodoP:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($iPeriodo)+"_Final_Puntos")
			$promedioperiodoS:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($iPeriodo)+"_Final_Simbolo")
			
			SN3_BuildCalificacionTag (->$numXMLs;$refXMLDoc;[Alumnos_Calificaciones:208]ID:506;[Alumnos_Calificaciones:208]ID_Alumno:6;[Alumnos_Calificaciones:208]ID_Asignatura:5;String:C10($iPeriodo);"promedio";$promedioperiodo->;$promedioperiodoR->;$promedioperiodoN->;$promedioperiodoP->;$promedioperiodoS->;[Asignaturas:18]Numero_de_EstiloEvaluacion:39)
			
			
			
			  //20161004 JVP
			  //agrego envio de bonificacion a SNET
			$bonificacionperiodo:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($iPeriodo)+"_Bonificacion_Literal")
			$bonificacionperiodoR:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($iPeriodo)+"_Bonificacion_Real")
			$bonificacionperiodoN:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($iPeriodo)+"_Bonificacion_Nota")
			$bonificacionperiodop:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($iPeriodo)+"_Bonificacion_Puntos")
			$bonificacionperiodos:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($iPeriodo)+"_Bonificacion_Simbolo")
			
			SN3_BuildCalificacionTag (->$numXMLs;$refXMLDoc;[Alumnos_Calificaciones:208]ID:506;[Alumnos_Calificaciones:208]ID_Alumno:6;[Alumnos_Calificaciones:208]ID_Asignatura:5;String:C10($iPeriodo);"bonificacion";$bonificacionperiodo->;$bonificacionperiodoR->;$bonificacionperiodoN->;$bonificacionperiodoP->;$bonificacionperiodoS->;[Asignaturas:18]Numero_de_EstiloEvaluacion:39)
			
			
		End for 
		
		$presentacionanual:=->[Alumnos_Calificaciones:208]Anual_Literal:15
		$presentacionanualR:=->[Alumnos_Calificaciones:208]Anual_Real:11
		$presentacionanualN:=->[Alumnos_Calificaciones:208]Anual_Nota:12
		$presentacionanualP:=->[Alumnos_Calificaciones:208]Anual_Puntos:13
		$presentacionanualS:=->[Alumnos_Calificaciones:208]Anual_Simbolo:14
		
		SN3_BuildCalificacionTag (->$numXMLs;$refXMLDoc;[Alumnos_Calificaciones:208]ID:506;[Alumnos_Calificaciones:208]ID_Alumno:6;[Alumnos_Calificaciones:208]ID_Asignatura:5;"-1";"pressentacionanual";$presentacionanual->;$presentacionanualR->;$presentacionanualN->;$presentacionanualP->;$presentacionanualS->;[Asignaturas:18]Numero_de_EstiloEvaluacion:39)
		
		
		$examen:=->[Alumnos_Calificaciones:208]ExamenAnual_Literal:20
		$examenR:=->[Alumnos_Calificaciones:208]ExamenAnual_Real:16
		$examenN:=->[Alumnos_Calificaciones:208]ExamenAnual_Nota:17
		$examenP:=->[Alumnos_Calificaciones:208]ExamenAnual_Puntos:18
		$examenS:=->[Alumnos_Calificaciones:208]ExamenAnual_Simbolo:19
		
		SN3_BuildCalificacionTag (->$numXMLs;$refXMLDoc;[Alumnos_Calificaciones:208]ID:506;[Alumnos_Calificaciones:208]ID_Alumno:6;[Alumnos_Calificaciones:208]ID_Asignatura:5;"-1";"examen";$examen->;$examenR->;$examenN->;$examenP->;$examenS->;[Asignaturas:18]Numero_de_EstiloEvaluacion:39)
		
		
		$examenextra:=->[Alumnos_Calificaciones:208]ExamenExtra_Literal:25
		$examenextraR:=->[Alumnos_Calificaciones:208]ExamenExtra_Real:21
		$examenextraN:=->[Alumnos_Calificaciones:208]ExamenExtra_Nota:22
		$examenextraP:=->[Alumnos_Calificaciones:208]ExamenExtra_Puntos:23
		$examenextraS:=->[Alumnos_Calificaciones:208]ExamenExtra_Simbolo:24
		
		SN3_BuildCalificacionTag (->$numXMLs;$refXMLDoc;[Alumnos_Calificaciones:208]ID:506;[Alumnos_Calificaciones:208]ID_Alumno:6;[Alumnos_Calificaciones:208]ID_Asignatura:5;"-1";"examenextra";$examenextra->;$examenextraR->;$examenextraN->;$examenextraP->;$examenextraS->;[Asignaturas:18]Numero_de_EstiloEvaluacion:39)
		
		
		$final:=->[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30
		$finalR:=->[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26
		$finalN:=->[Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27
		$finalP:=->[Alumnos_Calificaciones:208]EvaluacionFinal_Puntos:28
		$finalS:=->[Alumnos_Calificaciones:208]EvaluacionFinal_Simbolo:29
		
		SN3_BuildCalificacionTag (->$numXMLs;$refXMLDoc;[Alumnos_Calificaciones:208]ID:506;[Alumnos_Calificaciones:208]ID_Alumno:6;[Alumnos_Calificaciones:208]ID_Asignatura:5;"-1";"final";$final->;$finalR->;$finalN->;$finalP->;$finalS->;[Asignaturas:18]Numero_de_EstiloEvaluacion:39)
		
		
		If (KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos_Calificaciones:208]NIvel_Numero:4;->[xxSTR_Niveles:6]ConvertirEval_a_EstiloOficial:37))
			$id_ev_of:=[Asignaturas:18]Numero_de_EstiloEvaluacion:39
		Else 
			$id_ev_of:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos_Calificaciones:208]NIvel_Numero:4;->[xxSTR_Niveles:6]EvStyle_oficial:23)
		End if 
		
		$finalOf:=->[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36
		$finalROf:=->[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32
		$finalOfN:=->[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33
		$finalOfP:=->[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34
		$finalOfS:=->[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Simbolo:35
		
		SN3_BuildCalificacionTag (->$numXMLs;$refXMLDoc;[Alumnos_Calificaciones:208]ID:506;[Alumnos_Calificaciones:208]ID_Alumno:6;[Alumnos_Calificaciones:208]ID_Asignatura:5;"-1";"finalof";$finalOf->;$finalROf->;$finalOfN->;$finalOfP->;$finalOfS->;$id_ev_of)
		
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$indice/$size)
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	If ($openXML)
		SN3_CloseXMLCompress ("";$vt_FileName;"sax";$refXMLDoc)
	End if 
	If (Error=0)
		SN3_ManejaReferencias ("eliminar";SN3_Calificaciones;0;SNT_Accion_Actualizar;->$arrayLong)
		SN3_RegisterLogEntry (SN3_Log_FileGeneration;"Generación del documento con "+String:C10($size)+" registros de calificaciones.")
	Else 
		SN3_RegisterLogEntry (SN3_Log_Error;"El documento con registros de calificaciones no pudo ser generado.";Error)
	End if 
End if 

SN3_SetErrorHandler ("clear";$currentErrorHandler)