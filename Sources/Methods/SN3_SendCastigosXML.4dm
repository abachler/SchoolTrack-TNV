//%attributes = {}
  //SN3_SendCastigosXML

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

SN3_BuildSelections (SN3_DTi_Conducta;$todos;$useArrays;SN3_SDTx_Castigos)
If (Records in selection:C76([Alumnos_Castigos:9])>0)
	ARRAY LONGINT:C221($arrayLong;0)
	ARRAY LONGINT:C221($recNums;0)
	SELECTION TO ARRAY:C260([Alumnos_Castigos:9];$recNums;[Alumnos_Castigos:9]ID:10;$arrayLong)
	
	$size:=Size of array:C274($recNums)
	
	$vt_FileName:=SN3_CreateFile2Send ("crear";"";SN3_Castigos;"sax";->$refXMLDoc)
	SN3_BuildFileHeader ($refXMLDoc;SN3_Castigos;"castigos";$todos;$useArrays)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando documento con ")+String:C10($size)+__ (" registros de castigos..."))
	For ($indice;1;$size)
		KRL_GotoRecord (->[Alumnos_Castigos:9];$recNums{$indice};False:C215)
		SAX_CreateNode ($refXMLDoc;"castigo")
		SAX_CreateNode ($refXMLDoc;"id";True:C214;String:C10([Alumnos_Castigos:9]ID:10))
		SAX_CreateNode ($refXMLDoc;"idalumno";True:C214;String:C10([Alumnos_Castigos:9]Alumno_Numero:8))
		SAX_CreateNode ($refXMLDoc;"fecha";True:C214;SN3_MakeDateInmune2LocalFormat ([Alumnos_Castigos:9]Fecha:9))
		SAX_CreateNode ($refXMLDoc;"motivo";True:C214;[Alumnos_Castigos:9]Motivo:2;True:C214)
		SAX_CreateNode ($refXMLDoc;"observacion";True:C214;[Alumnos_Castigos:9]Observaciones:3;True:C214)
		SAX_CreateNode ($refXMLDoc;"idprofesor";True:C214;String:C10([Alumnos_Castigos:9]Profesor_Numero:6))
		SAX_CreateNode ($refXMLDoc;"horas";True:C214;String:C10([Alumnos_Castigos:9]Horas_de_castigo:7))
		SAX_CreateNode ($refXMLDoc;"cumplido";True:C214;String:C10(Num:C11([Alumnos_Castigos:9]Castigo_cumplido:4)))
		SAX CLOSE XML ELEMENT:C854($refXMLDoc)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$indice/$size)
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	SN3_CloseXMLCompress ("";$vt_FileName;"sax";$refXMLDoc)
	If (Error=0)
		SN3_ManejaReferencias ("eliminar";SN3_Castigos;0;SNT_Accion_Actualizar;->$arrayLong)
		SN3_RegisterLogEntry (SN3_Log_FileGeneration;"Generación del documento con "+String:C10($size)+" registros de castigos.")
	Else 
		SN3_RegisterLogEntry (SN3_Log_Error;"El documento con registros de castigos no pudo ser generado.";Error)
	End if 
End if 

SN3_SetErrorHandler ("clear";$currentErrorHandler)