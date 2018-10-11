//%attributes = {}
  //SN3_SendEventosAgendaXML

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

SN3_BuildSelections (SN3_DTi_EventosAgenda;$todos;$useArrays)
If (Records in selection:C76([Asignaturas_Eventos:170])>0)
	ARRAY LONGINT:C221($arrayLong;0)
	ARRAY LONGINT:C221($recNums;0)
	SELECTION TO ARRAY:C260([Asignaturas_Eventos:170];$recNums;[Asignaturas_Eventos:170]ID_Event:11;$arrayLong)
	
	$size:=Size of array:C274($recNums)
	
	$vt_FileName:=SN3_CreateFile2Send ("crear";"";SN3_EventosAgenda;"sax";->$refXMLDoc)
	SN3_BuildFileHeader ($refXMLDoc;SN3_EventosAgenda;"eventos";$todos;$useArrays)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando documento con ")+String:C10(Records in selection:C76([Asignaturas_Eventos:170]))+__ (" registros de eventos de agenda..."))
	For ($indice;1;$size)
		KRL_GotoRecord (->[Asignaturas_Eventos:170];$recNums{$indice};False:C215)
		SAX_CreateNode ($refXMLDoc;"evento")
		SAX_CreateNode ($refXMLDoc;"id";True:C214;String:C10([Asignaturas_Eventos:170]ID_Event:11))
		SAX_CreateNode ($refXMLDoc;"origen";True:C214;"ASG")
		SAX_CreateNode ($refXMLDoc;"idasignatura";True:C214;String:C10([Asignaturas_Eventos:170]ID_asignatura:1))
		SAX_CreateNode ($refXMLDoc;"idprofesor";True:C214;String:C10([Asignaturas_Eventos:170]ID_Profesor:8))
		SAX_CreateNode ($refXMLDoc;"fecha";True:C214;SN3_MakeDateInmune2LocalFormat ([Asignaturas_Eventos:170]Fecha:2))
		SAX_CreateNode ($refXMLDoc;"tipo";True:C214;[Asignaturas_Eventos:170]Tipo Evento:7;True:C214)
		SAX_CreateNode ($refXMLDoc;"asunto";True:C214;[Asignaturas_Eventos:170]Evento:3;True:C214)
		SAX_CreateNode ($refXMLDoc;"descripcion";True:C214;[Asignaturas_Eventos:170]Descripción:4;True:C214)
		SAX CLOSE XML ELEMENT:C854($refXMLDoc)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$indice/$size)
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	SN3_CloseXMLCompress ("";$vt_FileName;"sax";$refXMLDoc)
	If (Error=0)
		SN3_ManejaReferencias ("eliminar";SN3_EventosAgenda;0;SNT_Accion_Actualizar;->$arrayLong)
		SN3_RegisterLogEntry (SN3_Log_FileGeneration;"Generación del documento con "+String:C10($size)+" registros de eventos de agenda.")
	Else 
		SN3_RegisterLogEntry (SN3_Log_Error;"El documento con registros de eventos de agenda no pudo ser generado.";Error)
	End if 
End if 

SN3_SetErrorHandler ("clear";$currentErrorHandler)