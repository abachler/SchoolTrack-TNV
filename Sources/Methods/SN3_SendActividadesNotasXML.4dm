//%attributes = {}
  //SN3_SendActividadesNotasXML

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

SN3_BuildSelections (SN3_DTi_CalificacionesExtraCurr;$todos;$useArrays)
If (Records in selection:C76([Alumnos_Actividades:28])>0)
	ARRAY LONGINT:C221($arrayLong;0)
	ARRAY LONGINT:C221($recNums;0)
	SELECTION TO ARRAY:C260([Alumnos_Actividades:28];$recNums;[Alumnos_Actividades:28]ID:63;$arrayLong)
	
	$size:=Size of array:C274($recNums)
	
	$vt_FileName:=SN3_CreateFile2Send ("crear";"";SN3_Actividades_Evaluaciones;"sax";->$refXMLDoc)
	SN3_BuildFileHeader ($refXMLDoc;SN3_Actividades_Evaluaciones;"evaluaciones";$todos;$useArrays)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando documento con ")+String:C10($size)+__ (" registros de evaluaciones de actividades..."))
	For ($indice;1;$size)
		KRL_GotoRecord (->[Alumnos_Actividades:28];$recNums{$indice};False:C215)
		RELATE ONE:C42([Alumnos_Actividades:28]Actividad_numero:2)
		PERIODOS_LoadData ([Actividades:29]ID_ConfiguracionPeriodos:13)
		For ($i;1;viSTR_Periodos_NumeroPeriodos)
			If (([Alumnos_Actividades:28]Periodos_Inscritos:44 ?? 0) | ([Alumnos_Actividades:28]Periodos_Inscritos:44 ?? $i))
				XCR_ObtieneDatosPeriodoActual ($i)
				SAX_CreateNode ($refXMLDoc;"evaluacion")
				SAX_CreateNode ($refXMLDoc;"idalumno";True:C214;String:C10([Alumnos_Actividades:28]Alumno_Numero:1))
				SAX_CreateNode ($refXMLDoc;"idactividad";True:C214;String:C10([Alumnos_Actividades:28]Actividad_numero:2))
				SAX_CreateNode ($refXMLDoc;"periodo";True:C214;String:C10($i))
				SAX_CreateNode ($refXMLDoc;"ev1";True:C214;[Alumnos_Actividades:28]Periodo_Actual_Evaluacion1:54;True:C214)
				SAX_CreateNode ($refXMLDoc;"ev2";True:C214;[Alumnos_Actividades:28]Periodo_Actual_Evaluacion2:55;True:C214)
				SAX_CreateNode ($refXMLDoc;"ev3";True:C214;[Alumnos_Actividades:28]Periodo_Actual_Evaluacion3:56;True:C214)
				SAX_CreateNode ($refXMLDoc;"ev4";True:C214;[Alumnos_Actividades:28]Periodo_Actual_Evaluacion4:57;True:C214)
				SAX_CreateNode ($refXMLDoc;"ev5";True:C214;[Alumnos_Actividades:28]Periodo_Actual_Evaluacion5:58;True:C214)
				SAX_CreateNode ($refXMLDoc;"ev6";True:C214;[Alumnos_Actividades:28]Periodo_Actual_Evaluacion6:59;True:C214)
				SAX_CreateNode ($refXMLDoc;"evf";True:C214;[Alumnos_Actividades:28]Periodo_Actual_Evaluacion_Final:60;True:C214)
				SAX_CreateNode ($refXMLDoc;"inasistencia";True:C214;String:C10([Alumnos_Actividades:28]Periodo_Actual_Inasistencia:61))
				SAX_CreateNode ($refXMLDoc;"comentarios";True:C214;[Alumnos_Actividades:28]Periodo_Actual_Comentarios:62;True:C214)
				SAX CLOSE XML ELEMENT:C854($refXMLDoc)
			End if 
		End for 
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$indice/$size)
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	SN3_CloseXMLCompress ("";$vt_FileName;"sax";$refXMLDoc)
	If (Error=0)
		SN3_ManejaReferencias ("eliminar";SN3_Actividades_Evaluaciones;0;SNT_Accion_Actualizar;->$arrayLong)
		SN3_RegisterLogEntry (SN3_Log_FileGeneration;"Generación del documento con "+String:C10($size)+" registros de evaluaciones de actividades .")
	Else 
		SN3_RegisterLogEntry (SN3_Log_Error;"El documento con registros de evaluaciones de actividades no pudo ser generado.";Error)
	End if 
End if 

SN3_SetErrorHandler ("clear";$currentErrorHandler)