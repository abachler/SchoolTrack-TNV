//%attributes = {}
  //SN3_SendAnotacionesXML

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

SN3_BuildSelections (SN3_DTi_Conducta;$todos;$useArrays;SN3_SDTx_Anotaciones)
If (Records in selection:C76([Alumnos_Anotaciones:11])>0)
	ARRAY LONGINT:C221($arrayLong;0)
	ARRAY LONGINT:C221($recNums;0)
	SELECTION TO ARRAY:C260([Alumnos_Anotaciones:11];$recNums;[Alumnos_Anotaciones:11]ID:12;$arrayLong)
	
	$size:=Size of array:C274($recNums)
	
	$vt_FileName:=SN3_CreateFile2Send ("crear";"";SN3_Anotaciones;"sax";->$refXMLDoc)
	SN3_BuildFileHeader ($refXMLDoc;SN3_Anotaciones;"anotaciones";$todos;$useArrays)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando documento con ")+String:C10($size)+__ (" registros de anotaciones..."))
	For ($indice;1;$size)
		KRL_GotoRecord (->[Alumnos_Anotaciones:11];$recNums{$indice};False:C215)
		SAX_CreateNode ($refXMLDoc;"anotacion")
		SAX_CreateNode ($refXMLDoc;"id";True:C214;String:C10([Alumnos_Anotaciones:11]ID:12))
		SAX_CreateNode ($refXMLDoc;"idalumno";True:C214;String:C10([Alumnos_Anotaciones:11]Alumno_Numero:6))
		SAX_CreateNode ($refXMLDoc;"fecha";True:C214;SN3_MakeDateInmune2LocalFormat ([Alumnos_Anotaciones:11]Fecha:1))
		SAX_CreateNode ($refXMLDoc;"motivo";True:C214;[Alumnos_Anotaciones:11]Motivo:3;True:C214)
		SAX_CreateNode ($refXMLDoc;"idprofesor";True:C214;String:C10([Alumnos_Anotaciones:11]Profesor_Numero:5))
		SAX_CreateNode ($refXMLDoc;"observacion";True:C214;[Alumnos_Anotaciones:11]Observaciones:4;True:C214)
		SAX_CreateNode ($refXMLDoc;"signo";True:C214;[Alumnos_Anotaciones:11]Signo:7)
		SAX_CreateNode ($refXMLDoc;"categoria";True:C214;[Alumnos_Anotaciones:11]Categoria:8;True:C214)
		SAX_CreateNode ($refXMLDoc;"asignatura";True:C214;[Alumnos_Anotaciones:11]Asignatura:10;True:C214)
		SAX CLOSE XML ELEMENT:C854($refXMLDoc)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$indice/$size)
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	SN3_CloseXMLCompress ("";$vt_FileName;"sax";$refXMLDoc)
	If (Error=0)
		SN3_ManejaReferencias ("eliminar";SN3_Anotaciones;0;SNT_Accion_Actualizar;->$arrayLong)
		SN3_RegisterLogEntry (SN3_Log_FileGeneration;"Generación del documento con "+String:C10($size)+" registros de anotaciones.")
	Else 
		SN3_RegisterLogEntry (SN3_Log_Error;"El documento con registros de anotaciones no pudo ser generado.";Error)
	End if 
End if 

SN3_SetErrorHandler ("clear";$currentErrorHandler)