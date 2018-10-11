//%attributes = {}
  //SN3_SendEnfermeriaXML

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

SN3_BuildSelections (SN3_DTi_Salud;$todos;$useArrays;SN3_SDTx_EventosEnfermeria)
If (Records in selection:C76([Alumnos_EventosEnfermeria:14])>0)
	ARRAY LONGINT:C221($arrayLong;0)
	ARRAY LONGINT:C221($recNums;0)
	SELECTION TO ARRAY:C260([Alumnos_EventosEnfermeria:14];$recNums;[Alumnos_EventosEnfermeria:14]ID:15;$arrayLong)
	
	$size:=Size of array:C274($recNums)
	
	$vt_FileName:=SN3_CreateFile2Send ("crear";"";SN3_EventosEnfermeria;"sax";->$refXMLDoc)
	SN3_BuildFileHeader ($refXMLDoc;SN3_EventosEnfermeria;"enfermeria";$todos;$useArrays)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando documento con ")+String:C10($size)+__ (" registros de eventos de enfermería..."))
	For ($indice;1;$size)
		KRL_GotoRecord (->[Alumnos_EventosEnfermeria:14];$recNums{$indice};False:C215)
		SAX_CreateNode ($refXMLDoc;"evento")
		SAX_CreateNode ($refXMLDoc;"idevento";True:C214;String:C10([Alumnos_EventosEnfermeria:14]ID:15))
		SAX_CreateNode ($refXMLDoc;"idalumno";True:C214;String:C10([Alumnos_EventosEnfermeria:14]Alumno_Numero:1))
		SAX_CreateNode ($refXMLDoc;"fecha";True:C214;SN3_MakeDateInmune2LocalFormat ([Alumnos_EventosEnfermeria:14]Fecha:2))
		SAX_CreateNode ($refXMLDoc;"horaingreso";True:C214;String:C10([Alumnos_EventosEnfermeria:14]Hora_de_Ingreso:3;HH MM:K7:2))
		SAX_CreateNode ($refXMLDoc;"procedencia";True:C214;[Alumnos_EventosEnfermeria:14]Procedencia:4;True:C214)
		SAX_CreateNode ($refXMLDoc;"afeccion";True:C214;[Alumnos_EventosEnfermeria:14]Afeccion:6;True:C214)
		SAX_CreateNode ($refXMLDoc;"tratamiento";True:C214;[Alumnos_EventosEnfermeria:14]Tratamiento:7;True:C214)
		SAX_CreateNode ($refXMLDoc;"horasalida";True:C214;String:C10([Alumnos_EventosEnfermeria:14]Hora_de_Salida:8;HH MM:K7:2))
		SAX_CreateNode ($refXMLDoc;"destino";True:C214;[Alumnos_EventosEnfermeria:14]Destino:9;True:C214)
		SAX_CreateNode ($refXMLDoc;"observaciones";True:C214;[Alumnos_EventosEnfermeria:14]Observaciones:10;True:C214)
		SAX_CreateNode ($refXMLDoc;"idprofesor";True:C214;String:C10([Alumnos_EventosEnfermeria:14]ID_Profesor:12))
		SAX_CreateNode ($refXMLDoc;"despliegueasignatura";True:C214;[Alumnos_EventosEnfermeria:14]Asignatura:11;True:C214)
		SAX_CreateNode ($refXMLDoc;"idprofesorautoriza";True:C214;String:C10([Alumnos_EventosEnfermeria:14]ID_Profesor_Autoriza:13))
		SAX CLOSE XML ELEMENT:C854($refXMLDoc)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$indice/$size)
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	SN3_CloseXMLCompress ("";$vt_FileName;"sax";$refXMLDoc)
	If (Error=0)
		SN3_ManejaReferencias ("eliminar";SN3_EventosEnfermeria;0;SNT_Accion_Actualizar;->$arrayLong)
		SN3_RegisterLogEntry (SN3_Log_FileGeneration;"Generación del documento con "+String:C10($size)+" registros de eventos de enfermería.")
	Else 
		SN3_RegisterLogEntry (SN3_Log_Error;"El documento con registros de eventos de enfermería no pudo s"+"er generado.";Error)
	End if 
End if 

SN3_SetErrorHandler ("clear";$currentErrorHandler)

