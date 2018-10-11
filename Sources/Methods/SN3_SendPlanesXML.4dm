//%attributes = {}
  //SN3_SendPlanesXML

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

SN3_BuildSelections (SN3_DTi_PlanesClase;$todos;$useArrays;SN3_SDTx_Planes)
If (Records in selection:C76([Asignaturas_PlanesDeClases:169])>0)
	ARRAY LONGINT:C221($arrayLong;0)
	ARRAY LONGINT:C221($recNums;0)
	SELECTION TO ARRAY:C260([Asignaturas_PlanesDeClases:169];$recNums;[Asignaturas_PlanesDeClases:169]ID_Plan:1;$arrayLong)
	
	$size:=Size of array:C274($recNums)
	
	$vt_FileName:=SN3_CreateFile2Send ("crear";"";SN3_PlanesDeClase;"sax";->$refXMLDoc)
	SN3_BuildFileHeader ($refXMLDoc;SN3_PlanesDeClase;"planes";$todos;$useArrays)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando documento con ")+String:C10($size)+__ (" registros de planes de clase..."))
	For ($indice;1;$size)
		KRL_GotoRecord (->[Asignaturas_PlanesDeClases:169];$recNums{$indice};False:C215)
		SAX_CreateNode ($refXMLDoc;"plan")
		SAX_CreateNode ($refXMLDoc;"idasignatura";True:C214;String:C10([Asignaturas_PlanesDeClases:169]ID_Asignatura:2))
		SAX_CreateNode ($refXMLDoc;"idplan";True:C214;String:C10([Asignaturas_PlanesDeClases:169]ID_Plan:1))
		SAX_CreateNode ($refXMLDoc;"desde";True:C214;SN3_MakeDateInmune2LocalFormat ([Asignaturas_PlanesDeClases:169]Desde:3))
		SAX_CreateNode ($refXMLDoc;"hasta";True:C214;SN3_MakeDateInmune2LocalFormat ([Asignaturas_PlanesDeClases:169]Hasta:4))
		SAX_CreateNode ($refXMLDoc;"horas";True:C214;String:C10([Asignaturas_PlanesDeClases:169]NumeroHoras:5))
		SAX_CreateNode ($refXMLDoc;"actividades";True:C214;[Asignaturas_PlanesDeClases:169]Actividades:9;True:C214)
		SAX_CreateNode ($refXMLDoc;"contenidos";True:C214;[Asignaturas_PlanesDeClases:169]Contenidos:8;True:C214)
		SAX_CreateNode ($refXMLDoc;"objetivos";True:C214;[Asignaturas_PlanesDeClases:169]Objetivos:7;True:C214)
		SAX_CreateNode ($refXMLDoc;"nota";True:C214;[Asignaturas_PlanesDeClases:169]Nota_al_Alumno:6;True:C214)
		SAX_CreateNode ($refXMLDoc;"referencias";True:C214;[Asignaturas_PlanesDeClases:169]Referencias:10;True:C214)
		SAX_CreateNode ($refXMLDoc;"instrumentos";True:C214;[Asignaturas_PlanesDeClases:169]Intrumentos_evaluacion:11;True:C214)
		SAX_CreateNode ($refXMLDoc;"tareas";True:C214;[Asignaturas_PlanesDeClases:169]Tareas:12;True:C214)
		SAX_CreateNode ($refXMLDoc;"nombre";True:C214;[Asignaturas_PlanesDeClases:169]Nombre:14;True:C214)
		SAX CLOSE XML ELEMENT:C854($refXMLDoc)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$indice/$size)
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	SN3_CloseXMLCompress ("";$vt_FileName;"sax";$refXMLDoc)
	If (Error=0)
		SN3_ManejaReferencias ("eliminar";SN3_PlanesDeClase;0;SNT_Accion_Actualizar;->$arrayLong)
		SN3_RegisterLogEntry (SN3_Log_FileGeneration;"Generación del documento con "+String:C10($size)+" registros de planes de clase.")
	Else 
		SN3_RegisterLogEntry (SN3_Log_Error;"El documento con registros de planes de clase no pudo ser generado.";Error)
	End if 
End if 

SN3_SetErrorHandler ("clear";$currentErrorHandler)

