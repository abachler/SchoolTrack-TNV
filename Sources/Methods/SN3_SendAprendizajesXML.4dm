//%attributes = {}
  //SN3_SendAprendizajesXML

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

SN3_BuildSelections (SN3_DTi_CalificacionesMPA;$todos;$useArrays)
If (Records in selection:C76([Alumnos_EvaluacionAprendizajes:203])>0)
	ARRAY LONGINT:C221($arrayLong;0)
	ARRAY LONGINT:C221($recNums;0)
	SELECTION TO ARRAY:C260([Alumnos_EvaluacionAprendizajes:203];$recNums;[Alumnos_EvaluacionAprendizajes:203]ID:90;$arrayLong)
	
	$size:=Size of array:C274($recNums)
	
	$vt_FileName:=SN3_CreateFile2Send ("crear";"";SN3_Aprendizajes_Evaluacion;"sax";->$refXMLDoc)
	SN3_BuildFileHeader ($refXMLDoc;SN3_Aprendizajes_Evaluacion;"evaluaciones";$todos;$useArrays)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando documento con ")+String:C10($size)+__ (" registros de evaluaciones de aprendizajes esperados..."))
	$numXMLs:=0
	$openXML:=True:C214
	For ($indice;1;$size)
		If ($numXMLs>=45000)
			  //cerrar
			SN3_CloseXMLCompress ("";$vt_FileName;"sax";$refXMLDoc)
			$openXML:=False:C215
			$vt_FileName:=SN3_CreateFile2Send ("crear";"";SN3_Aprendizajes_Evaluacion;"sax";->$refXMLDoc)
			SN3_BuildFileHeader ($refXMLDoc;SN3_Aprendizajes_Evaluacion;"evaluaciones";$todos;$useArrays)
			$lastNivel:=-MAXLONG:K35:2
			$numXMLs:=0
			$openXML:=True:C214
		End if 
		KRL_GotoRecord (->[Alumnos_EvaluacionAprendizajes:203];$recNums{$indice};False:C215)
		RELATE ONE:C42([Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3)
		PERIODOS_LoadData ([Alumnos:2]nivel_numero:29)
		For ($iPeriodos;1;viSTR_Periodos_NumeroPeriodos)
			SAX_CreateNode ($refXMLDoc;"evaluacion")
			SAX_CreateNode ($refXMLDoc;"id";True:C214;String:C10([Alumnos_EvaluacionAprendizajes:203]ID:90))
			SAX_CreateNode ($refXMLDoc;"idalumno";True:C214;String:C10([Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3))
			SAX_CreateNode ($refXMLDoc;"idasignatura";True:C214;String:C10([Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1))
			SAX_CreateNode ($refXMLDoc;"periodo";True:C214;String:C10($iPeriodos))
			SAX_CreateNode ($refXMLDoc;"ideje";True:C214;String:C10([Alumnos_EvaluacionAprendizajes:203]ID_Eje:5))
			SAX_CreateNode ($refXMLDoc;"iddimension";True:C214;String:C10([Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6))
			SAX_CreateNode ($refXMLDoc;"idcompetencia";True:C214;String:C10([Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7))
			SAX_CreateNode ($refXMLDoc;"tipo";True:C214;String:C10([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4))
			SAX_CreateNode ($refXMLDoc;"fechaaprobacion";True:C214;SN3_MakeDateInmune2LocalFormat ([Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89))
			Case of 
				: ($iPeriodos=1)
					$indicadorPtr:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_Indicador:14
					$evalPtr:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13
					$obsPtr:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_Observaciones:79
				: ($iPeriodos=2)
					$indicadorPtr:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_Indicador:26
					$evalPtr:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25
					$obsPtr:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_Observaciones:80
				: ($iPeriodos=3)
					$indicadorPtr:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_Indicador:38
					$evalPtr:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37
					$obsPtr:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_Observaciones:81
				: ($iPeriodos=4)
					$indicadorPtr:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_Indicador:50
					$evalPtr:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49
					$obsPtr:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_Observaciones:82
				: ($iPeriodos=5)
					$indicadorPtr:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_Indicador:67
					$evalPtr:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66
					$obsPtr:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_Observaciones:83
			End case 
			SAX_CreateNode ($refXMLDoc;"indicador";True:C214;$indicadorPtr->;True:C214)
			SAX_CreateNode ($refXMLDoc;"eval";True:C214;$evalPtr->)
			SAX_CreateNode ($refXMLDoc;"observacion";True:C214;$obsPtr->;True:C214)
			SAX CLOSE XML ELEMENT:C854($refXMLDoc)
			$numXMLs:=$numXMLs+1
		End for 
		SAX_CreateNode ($refXMLDoc;"evaluacion")
		SAX_CreateNode ($refXMLDoc;"id";True:C214;String:C10([Alumnos_EvaluacionAprendizajes:203]ID:90))
		SAX_CreateNode ($refXMLDoc;"idalumno";True:C214;String:C10([Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3))
		SAX_CreateNode ($refXMLDoc;"idasignatura";True:C214;String:C10([Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1))
		SAX_CreateNode ($refXMLDoc;"periodo";True:C214;"-1")
		SAX_CreateNode ($refXMLDoc;"ideje";True:C214;String:C10([Alumnos_EvaluacionAprendizajes:203]ID_Eje:5))
		SAX_CreateNode ($refXMLDoc;"iddimension";True:C214;String:C10([Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6))
		SAX_CreateNode ($refXMLDoc;"idcompetencia";True:C214;String:C10([Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7))
		SAX_CreateNode ($refXMLDoc;"tipo";True:C214;String:C10([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4))
		SAX_CreateNode ($refXMLDoc;"indicador";True:C214;[Alumnos_EvaluacionAprendizajes:203]Final_Indicador:62;True:C214)
		SAX_CreateNode ($refXMLDoc;"eval";True:C214;[Alumnos_EvaluacionAprendizajes:203]Final_NativoLiteral:61)
		SAX_CreateNode ($refXMLDoc;"observacion";True:C214;[Alumnos_EvaluacionAprendizajes:203]Final_Observaciones:84;True:C214)
		SAX CLOSE XML ELEMENT:C854($refXMLDoc)
		$numXMLs:=$numXMLs+1
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$indice/$size)
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	If ($openXML)
		SN3_CloseXMLCompress ("";$vt_FileName;"sax";$refXMLDoc)
	End if 
	If (Error=0)
		SN3_ManejaReferencias ("eliminar";SN3_Aprendizajes_Evaluacion;0;SNT_Accion_Actualizar;->$arrayLong)
		SN3_RegisterLogEntry (SN3_Log_FileGeneration;"Generación del documento con "+String:C10($size)+" registros de evaluaciones de aprendizajes esperados.")
	Else 
		SN3_RegisterLogEntry (SN3_Log_Error;"El documento con registros de evaluaciones de aprendizajes esperados no p"+"udo ser generado.";Error)
	End if 
End if 


SN3_SetErrorHandler ("clear";$currentErrorHandler)