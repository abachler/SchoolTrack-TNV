//%attributes = {}
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

SN3_BuildSelections (100021;$todos;$useArrays)
If (Records in selection:C76([xxSTR_Subasignaturas:83])>0)
	ARRAY LONGINT:C221($arrayLong;0)
	ARRAY LONGINT:C221($recNums;0)
	SELECTION TO ARRAY:C260([xxSTR_Subasignaturas:83];$recNums;[xxSTR_Subasignaturas:83]ID:19;$arrayLong)
	
	$size:=Size of array:C274($recNums)
	
	$vt_FileName:=SN3_CreateFile2Send ("crear";"";10500;"sax";->$refXMLDoc)
	SN3_BuildFileHeader ($refXMLDoc;10500;"subevaluaciones";$todos;$useArrays)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando documento con ")+String:C10($size)+__ (" registros de subasignaturas..."))
	$numXMLs:=0
	$openXML:=True:C214
	For ($indice;1;$size)
		KRL_GotoRecord (->[xxSTR_Subasignaturas:83];$recNums{$indice};False:C215)
		  //If (BLOB size([xxSTR_Subasignaturas]Data)>0)
		If (OB Is defined:C1231([xxSTR_Subasignaturas:83]o_Data:21))  //ABC Ticket 198408 //20180202
			If ($numXMLs>=60000)
				  //cerrar
				SN3_CloseXMLCompress ("";$vt_FileName;"sax";$refXMLDoc)
				$openXML:=False:C215
				$vt_FileName:=SN3_CreateFile2Send ("crear";"";10500;"sax";->$refXMLDoc)
				SN3_BuildFileHeader ($refXMLDoc;10500;"subevaluaciones";$todos;$useArrays)
				$numXMLs:=0
				$openXML:=True:C214
			End if 
			$evStyle:=KRL_GetNumericFieldData (->[Asignaturas:18]Numero:1;->[xxSTR_Subasignaturas:83]ID_Mother:6;->[Asignaturas:18]Numero_de_EstiloEvaluacion:39)
			If ($evStyle#0)
				EVS_ReadStyleData ($evStyle)
				ASsev_InitArrays 
				ARRAY REAL:C219(aRealTemp;0)
				ARRAY POINTER:C280(aSubEvalArrPtr;12)
				ARRAY POINTER:C280(aRealSubEvalArrPtr;12)
				ARRAY TEXT:C222(aRealSubEvalArrNames;12)
				For ($i;1;12)
					aSubEvalArrPtr{$i}:=Get pointer:C304("aSubEval"+String:C10($i))
					aRealSubEvalArrPtr{$i}:=Get pointer:C304("aRealSubEval"+String:C10($i))
					aRealSubEvalArrNames{$i}:="aRealSubEval"+String:C10($i)
				End for 
				
				  //MONO TICKET 187315 
				  //$offset:=0
				  //$offset:=BLOB_Blob2Vars (->[xxSTR_Subasignaturas]Data;$offset;->aSubEvalID;->aSubEvalStdNme;->aSubEvalCurso;->aSubEvalStatus;->aSubEvalOrden)
				OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aSubEvalID;"aSubEvalID")
				OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aSubEvalStdNme;"aSubEvalStdNme")
				OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aSubEvalCurso;"aSubEvalCurso")
				OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aSubEvalStatus;"aSubEvalStatus")
				OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aSubEvalOrden;"aSubEvalOrden")
				
				If (Size of array:C274(aSubEvalID)>0)
					For ($j;1;Size of array:C274(aSubEvalArrPtr))
						  //$offset:=BLOB_Blob2Vars (->[xxSTR_Subasignaturas]Data;$offset;aRealSubEvalArrPtr{$j})
						OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;aRealSubEvalArrPtr{$j};"aRealSubEval"+String:C10($j))
						NTA_PercentArray2StrGradeArray (aRealSubEvalArrPtr{$j};aSubEvalArrPtr{$j};iPrintMode)
					End for 
					  //$offset:=BLOB_Blob2Vars (->[xxSTR_Subasignaturas]Data;$offset;->aRealSubEvalP1)
					  //$offset:=BLOB_Blob2Vars (->[xxSTR_Subasignaturas]Data;$offset;->aRealSubEvalControles)
					  //$offset:=BLOB_Blob2Vars (->[xxSTR_Subasignaturas]Data;$offset;->aRealSubEvalPresentacion)
					OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aRealSubEvalP1;"aRealSubEvalP1")
					OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aRealSubEvalControles;"aRealSubEvalControles")
					OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aRealSubEvalPresentacion;"aRealSubEvalPresentacion")
					OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aSubEvalNombreParciales;"aSubEvalNombreParciales")
					
					
					NTA_PercentArray2StrGradeArray (->aRealSubEvalP1;->aSubEvalP1;iPrintMode)
					NTA_PercentArray2StrGradeArray (->aRealSubEvalControles;->aSubEvalControles;iPrintMode)
					NTA_PercentArray2StrGradeArray (->aRealSubEvalPresentacion;->aSubEvalPresentacion;iPrintMode)
					
					For ($i;1;Size of array:C274(aSubEvalID))
						For ($j;1;12)
							SAX_CreateNode ($refXMLDoc;"subevaluacion")
							SAX_CreateNode ($refXMLDoc;"idsubasignatura";True:C214;String:C10([xxSTR_Subasignaturas:83]ID:19))
							SAX_CreateNode ($refXMLDoc;"columna";True:C214;String:C10([xxSTR_Subasignaturas:83]Columna:13))
							SAX_CreateNode ($refXMLDoc;"idasignatura";True:C214;String:C10([xxSTR_Subasignaturas:83]ID_Mother:6))
							SAX_CreateNode ($refXMLDoc;"idalumno";True:C214;String:C10(aSubEvalID{$i}))
							SAX_CreateNode ($refXMLDoc;"periodo";True:C214;String:C10([xxSTR_Subasignaturas:83]Periodo:12))
							SAX_CreateNode ($refXMLDoc;"tipo";True:C214;"parcial"+String:C10($j))
							SAX_CreateNode ($refXMLDoc;"nota";True:C214;aSubEvalArrPtr{$j}->{$i})
							SAX_CreateNode ($refXMLDoc;"porcentaje";True:C214;EV2_Real_a_Literal (aRealSubEvalArrPtr{$j}->{$i};Porcentaje))
							SAX_CreateNode ($refXMLDoc;"notanum";True:C214;EV2_Real_a_Literal (aRealSubEvalArrPtr{$j}->{$i};Notas;iGradesDec))
							SAX_CreateNode ($refXMLDoc;"puntos";True:C214;EV2_Real_a_Literal (aRealSubEvalArrPtr{$j}->{$i};Puntos;iPointsDec))
							SAX_CreateNode ($refXMLDoc;"simbolo";True:C214;EV2_Real_a_Literal (aRealSubEvalArrPtr{$j}->{$i};Simbolos))
							SAX_CreateNode ($refXMLDoc;"color";True:C214;SN3_GetColorNota ($evStyle;aRealSubEvalArrPtr{$j}->{$i}))
							SAX CLOSE XML ELEMENT:C854($refXMLDoc)
							$numXMLs:=$numXMLs+1
						End for 
						SAX_CreateNode ($refXMLDoc;"subevaluacion")
						SAX_CreateNode ($refXMLDoc;"idsubasignatura";True:C214;String:C10([xxSTR_Subasignaturas:83]ID:19))
						SAX_CreateNode ($refXMLDoc;"columna";True:C214;String:C10([xxSTR_Subasignaturas:83]Columna:13))
						SAX_CreateNode ($refXMLDoc;"idasignatura";True:C214;String:C10([xxSTR_Subasignaturas:83]ID_Mother:6))
						SAX_CreateNode ($refXMLDoc;"idalumno";True:C214;String:C10(aSubEvalID{$i}))
						SAX_CreateNode ($refXMLDoc;"periodo";True:C214;String:C10([xxSTR_Subasignaturas:83]Periodo:12))
						SAX_CreateNode ($refXMLDoc;"tipo";True:C214;"promedio")
						SAX_CreateNode ($refXMLDoc;"nota";True:C214;aSubEvalP1{$i})
						SAX_CreateNode ($refXMLDoc;"porcentaje";True:C214;EV2_Real_a_Literal (aRealSubEvalP1{$i};Porcentaje))
						SAX_CreateNode ($refXMLDoc;"notanum";True:C214;EV2_Real_a_Literal (aRealSubEvalP1{$i};Notas;iGradesDec))
						SAX_CreateNode ($refXMLDoc;"puntos";True:C214;EV2_Real_a_Literal (aRealSubEvalP1{$i};Puntos;iPointsDec))
						SAX_CreateNode ($refXMLDoc;"simbolo";True:C214;EV2_Real_a_Literal (aRealSubEvalP1{$i};Simbolos))
						SAX_CreateNode ($refXMLDoc;"color";True:C214;SN3_GetColorNota ($evStyle;aRealSubEvalP1{$i}))
						SAX CLOSE XML ELEMENT:C854($refXMLDoc)
						$numXMLs:=$numXMLs+1
						SAX_CreateNode ($refXMLDoc;"subevaluacion")
						SAX_CreateNode ($refXMLDoc;"idsubasignatura";True:C214;String:C10([xxSTR_Subasignaturas:83]ID:19))
						SAX_CreateNode ($refXMLDoc;"columna";True:C214;String:C10([xxSTR_Subasignaturas:83]Columna:13))
						SAX_CreateNode ($refXMLDoc;"idasignatura";True:C214;String:C10([xxSTR_Subasignaturas:83]ID_Mother:6))
						SAX_CreateNode ($refXMLDoc;"idalumno";True:C214;String:C10(aSubEvalID{$i}))
						SAX_CreateNode ($refXMLDoc;"periodo";True:C214;String:C10([xxSTR_Subasignaturas:83]Periodo:12))
						SAX_CreateNode ($refXMLDoc;"tipo";True:C214;"control")
						SAX_CreateNode ($refXMLDoc;"nota";True:C214;aSubEvalControles{$i})
						SAX_CreateNode ($refXMLDoc;"porcentaje";True:C214;EV2_Real_a_Literal (aRealSubEvalControles{$i};Porcentaje))
						SAX_CreateNode ($refXMLDoc;"notanum";True:C214;EV2_Real_a_Literal (aRealSubEvalControles{$i};Notas;iGradesDec))
						SAX_CreateNode ($refXMLDoc;"puntos";True:C214;EV2_Real_a_Literal (aRealSubEvalControles{$i};Puntos;iPointsDec))
						SAX_CreateNode ($refXMLDoc;"simbolo";True:C214;EV2_Real_a_Literal (aRealSubEvalControles{$i};Simbolos))
						SAX_CreateNode ($refXMLDoc;"color";True:C214;SN3_GetColorNota ($evStyle;aRealSubEvalControles{$i}))
						SAX CLOSE XML ELEMENT:C854($refXMLDoc)
						$numXMLs:=$numXMLs+1
						SAX_CreateNode ($refXMLDoc;"subevaluacion")
						SAX_CreateNode ($refXMLDoc;"idsubasignatura";True:C214;String:C10([xxSTR_Subasignaturas:83]ID:19))
						SAX_CreateNode ($refXMLDoc;"columna";True:C214;String:C10([xxSTR_Subasignaturas:83]Columna:13))
						SAX_CreateNode ($refXMLDoc;"idasignatura";True:C214;String:C10([xxSTR_Subasignaturas:83]ID_Mother:6))
						SAX_CreateNode ($refXMLDoc;"idalumno";True:C214;String:C10(aSubEvalID{$i}))
						SAX_CreateNode ($refXMLDoc;"periodo";True:C214;String:C10([xxSTR_Subasignaturas:83]Periodo:12))
						SAX_CreateNode ($refXMLDoc;"tipo";True:C214;"presentacion")
						SAX_CreateNode ($refXMLDoc;"nota";True:C214;aSubEvalPresentacion{$i})
						SAX_CreateNode ($refXMLDoc;"porcentaje";True:C214;EV2_Real_a_Literal (aRealSubEvalPresentacion{$i};Porcentaje))
						SAX_CreateNode ($refXMLDoc;"notanum";True:C214;EV2_Real_a_Literal (aRealSubEvalPresentacion{$i};Notas;iGradesDec))
						SAX_CreateNode ($refXMLDoc;"puntos";True:C214;EV2_Real_a_Literal (aRealSubEvalPresentacion{$i};Puntos;iPointsDec))
						SAX_CreateNode ($refXMLDoc;"simbolo";True:C214;EV2_Real_a_Literal (aRealSubEvalPresentacion{$i};Simbolos))
						SAX_CreateNode ($refXMLDoc;"color";True:C214;SN3_GetColorNota ($evStyle;aRealSubEvalPresentacion{$i}))
						SAX CLOSE XML ELEMENT:C854($refXMLDoc)
						$numXMLs:=$numXMLs+1
					End for 
				End if 
			End if 
		End if 
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$indice/$size)
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	If ($openXML)
		SN3_CloseXMLCompress ("";$vt_FileName;"sax";$refXMLDoc)
	End if 
	If (Error=0)
		SN3_ManejaReferencias ("eliminar";10500;0;SNT_Accion_Actualizar;->$arrayLong)
		SN3_RegisterLogEntry (SN3_Log_FileGeneration;"Generación del documento con "+String:C10($size)+" registros de calificaciones en subasignaturas.")
	Else 
		SN3_RegisterLogEntry (SN3_Log_Error;"El documento con registros de calificaciones en subasignaturas no pudo ser genera"+"d"+"o.";Error)
	End if 
End if 

SN3_SetErrorHandler ("clear";$currentErrorHandler)