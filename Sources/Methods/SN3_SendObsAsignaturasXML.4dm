//%attributes = {}
  //SN3_SendObsAsignaturasXML

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

SN3_BuildSelections (SN3_DTi_Observaciones;$todos;$useArrays;SN3_SDTx_Asignatura)
If (Records in selection:C76([Alumnos_ComplementoEvaluacion:209])>0)
	ARRAY LONGINT:C221($arrayLong;0)
	ARRAY LONGINT:C221($recNums;0)
	SELECTION TO ARRAY:C260([Alumnos_ComplementoEvaluacion:209];$recNums;[Alumnos_ComplementoEvaluacion:209]ID:90;$arrayLong)
	
	$size:=Size of array:C274($recNums)
	
	$vt_FileName:=SN3_CreateFile2Send ("crear";"";SN3_ObsAsignatura;"sax";->$refXMLDoc)
	SN3_BuildFileHeader ($refXMLDoc;SN3_ObsAsignatura;"observaciones";$todos;$useArrays)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando documento con ")+String:C10($size)+__ (" registros de observaciones por asignatura..."))
	For ($indice;1;$size)
		KRL_GotoRecord (->[Alumnos_ComplementoEvaluacion:209];$recNums{$indice};False:C215)
		RELATE ONE:C42([Alumnos_ComplementoEvaluacion:209]ID_Alumno:6)
		PERIODOS_LoadData ([Alumnos:2]nivel_numero:29)
		For ($j;1;viSTR_Periodos_NumeroPeriodos)
			SAX_CreateNode ($refXMLDoc;"observacion")
			SAX_CreateNode ($refXMLDoc;"id";True:C214;String:C10([Alumnos_ComplementoEvaluacion:209]ID:90))
			SAX_CreateNode ($refXMLDoc;"idalumno";True:C214;String:C10([Alumnos_ComplementoEvaluacion:209]ID_Alumno:6))
			SAX_CreateNode ($refXMLDoc;"idasignatura";True:C214;String:C10([Alumnos_ComplementoEvaluacion:209]ID_Asignatura:5))
			SAX_CreateNode ($refXMLDoc;"periodo";True:C214;String:C10($j))
			Case of 
				: ($j=1)
					SAX_CreateNode ($refXMLDoc;"obs";True:C214;[Alumnos_ComplementoEvaluacion:209]P01_Obs_Academicas:19;True:C214)
				: ($j=2)
					SAX_CreateNode ($refXMLDoc;"obs";True:C214;[Alumnos_ComplementoEvaluacion:209]P02_Obs_Academicas:24;True:C214)
				: ($j=3)
					SAX_CreateNode ($refXMLDoc;"obs";True:C214;[Alumnos_ComplementoEvaluacion:209]P03_Obs_Academicas:29;True:C214)
				: ($j=4)
					SAX_CreateNode ($refXMLDoc;"obs";True:C214;[Alumnos_ComplementoEvaluacion:209]P04_Obs_Academicas:34;True:C214)
				: ($j=5)
					SAX_CreateNode ($refXMLDoc;"obs";True:C214;[Alumnos_ComplementoEvaluacion:209]P05_Obs_Academicas:39;True:C214)
			End case 
			SAX CLOSE XML ELEMENT:C854($refXMLDoc)
		End for 
		SAX_CreateNode ($refXMLDoc;"observacion")
		SAX_CreateNode ($refXMLDoc;"id";True:C214;String:C10([Alumnos_ComplementoEvaluacion:209]ID:90))
		SAX_CreateNode ($refXMLDoc;"idalumno";True:C214;String:C10([Alumnos_ComplementoEvaluacion:209]ID_Alumno:6))
		SAX_CreateNode ($refXMLDoc;"idasignatura";True:C214;String:C10([Alumnos_ComplementoEvaluacion:209]ID_Asignatura:5))
		SAX_CreateNode ($refXMLDoc;"periodo";True:C214;"-1")
		SAX_CreateNode ($refXMLDoc;"obs";True:C214;[Alumnos_ComplementoEvaluacion:209]Final_ObservacionesAcademicas:46;True:C214)
		SAX CLOSE XML ELEMENT:C854($refXMLDoc)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$indice/$size)
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	SN3_CloseXMLCompress ("";$vt_FileName;"sax";$refXMLDoc)
	If (Error=0)
		SN3_ManejaReferencias ("eliminar";SN3_ObsAsignatura;0;SNT_Accion_Actualizar;->$arrayLong)
		SN3_RegisterLogEntry (SN3_Log_FileGeneration;"Generación del documento con "+String:C10($size)+" registros de observaciones por asignatura.")
	Else 
		SN3_RegisterLogEntry (SN3_Log_Error;"El documento con registros de observaciones por asignatura no pudo ser generado.";Error)
	End if 
End if 

SN3_SetErrorHandler ("clear";$currentErrorHandler)

