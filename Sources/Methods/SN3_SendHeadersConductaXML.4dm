//%attributes = {}
  //SN3_SendHeadersConductaXML

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

READ ONLY:C145([Alumnos:2])
READ ONLY:C145([xxSTR_Niveles:6])

$currentErrorHandler:=SN3_SetErrorHandler ("set")

USE SET:C118("headers")

If (Records in selection:C76([Alumnos:2])>0)
	$vt_FileName:=SN3_CreateFile2Send ("crear";"";SN3_HeadersConducta;"sax";->$refXMLDoc)
	SN3_BuildFileHeader ($refXMLDoc;SN3_HeadersConducta;"encabezados";$todos;$useArrays)
	
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando documento con ")+String:C10(Records in selection:C76([Alumnos:2]))+__ (" registros de encabezados de conducta..."))
	FIRST RECORD:C50([Alumnos:2])
	While (Not:C34(End selection:C36([Alumnos:2])))
		SAX_CreateNode ($refXMLDoc;"encabezado")
		SAX_CreateNode ($refXMLDoc;"idalumno";True:C214;String:C10([Alumnos:2]numero:1))
		$key:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10([Alumnos:2]nivel_numero:29)+"."+String:C10([Alumnos:2]numero:1)
		KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$key)
		SAX_CreateNode ($refXMLDoc;"anotneg";True:C214;String:C10([Alumnos_SintesisAnual:210]Anotaciones_Negativas:36))
		SAX_CreateNode ($refXMLDoc;"anotpos";True:C214;String:C10([Alumnos_SintesisAnual:210]Anotaciones_Positivas:34))
		SAX_CreateNode ($refXMLDoc;"anotneutra";True:C214;String:C10([Alumnos_SintesisAnual:210]Anotaciones_Neutras:35))
		SAX_CreateNode ($refXMLDoc;"suspensiones";True:C214;String:C10([Alumnos_SintesisAnual:210]Suspensiones:44))
		SAX_CreateNode ($refXMLDoc;"castigos";True:C214;String:C10([Alumnos_SintesisAnual:210]Castigos:43))
		SAX_CreateNode ($refXMLDoc;"atrasos";True:C214;String:C10([Alumnos_SintesisAnual:210]Atrasos_Sesiones:41+[Alumnos_SintesisAnual:210]Atrasos_Jornada:40))
		SAX_CreateNode ($refXMLDoc;"porcasist";True:C214;String:C10([Alumnos_SintesisAnual:210]PorcentajeAsistencia:33))
		$modeAsis:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]AttendanceMode:3)
		$InasistXAtraso:=Num:C11(PREF_fGet (0;"RegistrarInasistenciasPorAtrasos";"0"))
		Case of 
			: ($modeAsis=1)
				If ($InasistXAtraso=1)
					SAX_CreateNode ($refXMLDoc;"totalinasistencias";True:C214;String:C10([Alumnos_SintesisAnual:210]Inasistencias_Dias:30+[Alumnos_SintesisAnual:210]Faltas_x_RetardoJornada:45+[Alumnos_SintesisAnual:210]Faltas_x_RetardoSesiones:46))
				Else 
					SAX_CreateNode ($refXMLDoc;"totalinasistencias";True:C214;String:C10([Alumnos_SintesisAnual:210]Inasistencias_Dias:30))
				End if 
			: ($modeAsis=2)
				If ($InasistXAtraso=1)
					SAX_CreateNode ($refXMLDoc;"totalinasistencias";True:C214;String:C10([Alumnos_SintesisAnual:210]Inasistencias_Horas:31+[Alumnos_SintesisAnual:210]Faltas_x_RetardoSesiones:46))
				Else 
					SAX_CreateNode ($refXMLDoc;"totalinasistencias";True:C214;String:C10([Alumnos_SintesisAnual:210]Inasistencias_Horas:31))
				End if 
			: ($modeAsis=3)
				If ($InasistXAtraso=1)
					SAX_CreateNode ($refXMLDoc;"totalinasistencias";True:C214;String:C10([Alumnos_SintesisAnual:210]Inasistencias_Dias:30+[Alumnos_SintesisAnual:210]Faltas_x_RetardoJornada:45+[Alumnos_SintesisAnual:210]Faltas_x_RetardoSesiones:46))
				Else 
					SAX_CreateNode ($refXMLDoc;"totalinasistencias";True:C214;String:C10([Alumnos_SintesisAnual:210]Inasistencias_Dias:30))
				End if 
			: ($modeAsis=4)
				If ($InasistXAtraso=1)
					SAX_CreateNode ($refXMLDoc;"totalinasistencias";True:C214;String:C10([Alumnos_SintesisAnual:210]Inasistencias_Horas:31+[Alumnos_SintesisAnual:210]Faltas_x_RetardoSesiones:46))
				Else 
					SAX_CreateNode ($refXMLDoc;"totalinasistencias";True:C214;String:C10([Alumnos_SintesisAnual:210]Inasistencias_Horas:31))
				End if 
		End case 
		SAX CLOSE XML ELEMENT:C854($refXMLDoc)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;Selected record number:C246([Alumnos:2])/Records in selection:C76([Alumnos:2]))
		NEXT RECORD:C51([Alumnos:2])
	End while 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	SN3_CloseXMLCompress ("";$vt_FileName;"sax";$refXMLDoc)
	If (Error=0)
		SN3_ManejaReferencias ("eliminar";SN3_HeadersConducta;0;SNT_Accion_Actualizar)
		SN3_RegisterLogEntry (SN3_Log_FileGeneration;"Generación del documento con "+String:C10(Records in selection:C76([Alumnos:2]))+" registros de encabezados de conducta.")
	Else 
		SN3_RegisterLogEntry (SN3_Log_Error;"El documento con registros de encabezados de conducta no pudo ser generado.";Error)
	End if 
End if 

SN3_SetErrorHandler ("clear";$currentErrorHandler)

