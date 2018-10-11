//%attributes = {}
  //SN3_SendSesionesXML
  //MONO 22-05-14: pub sesiones

  //`======
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

SN3_BuildSelections (100022;$todos;$useArrays)  //sesiones

If (Records in selection:C76([Asignaturas_RegistroSesiones:168])>0)
	READ ONLY:C145([Asignaturas:18])
	READ ONLY:C145([Asignaturas_RegistroSesiones:168])
	ARRAY LONGINT:C221($arrayLong;0)
	ARRAY LONGINT:C221($recNums;0)
	ARRAY LONGINT:C221($al_inasist_alu_id;0)
	LONGINT ARRAY FROM SELECTION:C647([Asignaturas_RegistroSesiones:168];$recNums;"")
	
	$size:=Size of array:C274($recNums)
	
	$vt_FileName:=SN3_CreateFile2Send ("crear";"";10009;"sax";->$refXMLDoc)
	SN3_BuildFileHeader ($refXMLDoc;10009;"sesiones";$todos;$useArrays)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando documento con ")+String:C10($size)+__ (" registros de sesiones..."))
	
	For ($indice;1;Size of array:C274($recNums))
		KRL_GotoRecord (->[Asignaturas_RegistroSesiones:168];$recNums{$indice};False:C215)
		SAX_CreateNode ($refXMLDoc;"sesion")
		SAX_CreateNode ($refXMLDoc;"id";True:C214;String:C10([Asignaturas_RegistroSesiones:168]ID_Sesion:1))
		SAX_CreateNode ($refXMLDoc;"fecha";True:C214;String:C10([Asignaturas_RegistroSesiones:168]Fecha_Sesion:3))
		SAX_CreateNode ($refXMLDoc;"fecha_vista";True:C214;SN3_MakeDateInmune2LocalFormat ([Asignaturas_RegistroSesiones:168]Fecha_Sesion:3))
		
		QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=[Asignaturas_RegistroSesiones:168]ID_Asignatura:2)
		
		SAX_CreateNode ($refXMLDoc;"id_profesor";True:C214;String:C10([Asignaturas:18]profesor_numero:4))
		SAX_CreateNode ($refXMLDoc;"id_asignatura";True:C214;String:C10([Asignaturas_RegistroSesiones:168]ID_Asignatura:2))
		SAX_CreateNode ($refXMLDoc;"has_data";True:C214;String:C10([Asignaturas_RegistroSesiones:168]hasData:8))
		SAX_CreateNode ($refXMLDoc;"hrs";True:C214;String:C10([Asignaturas_RegistroSesiones:168]Hora:4))
		SAX_CreateNode ($refXMLDoc;"actividades";True:C214;[Asignaturas_RegistroSesiones:168]Actividades:7;True:C214)
		SAX_CreateNode ($refXMLDoc;"contenidos";True:C214;[Asignaturas_RegistroSesiones:168]Contenidos:6;True:C214)
		SAX_CreateNode ($refXMLDoc;"observaciones";True:C214;[Asignaturas_RegistroSesiones:168]Observacion:12;True:C214)
		
		KRL_RelateSelection (->[Asignaturas_Inasistencias:125]ID_Sesión:1;->[Asignaturas_RegistroSesiones:168]ID_Sesion:1;"")
		If (Records in selection:C76([Asignaturas_Inasistencias:125])>0)
			SELECTION TO ARRAY:C260([Asignaturas_Inasistencias:125]ID_Alumno:2;$al_inasist_alu_id)
			SAX_CreateNode ($refXMLDoc;"inasistencias")
			For ($i_alu_ina;1;Size of array:C274($al_inasist_alu_id))
				SAX_CreateNode ($refXMLDoc;"idalumno";True:C214;String:C10($al_inasist_alu_id{$i_alu_ina}))
			End for 
			SAX CLOSE XML ELEMENT:C854($refXMLDoc)  //20160415 RCH Se cierra tag de inasistencia
		End if 
		
		SAX CLOSE XML ELEMENT:C854($refXMLDoc)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$indice/$size)
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	SN3_CloseXMLCompress ("";$vt_FileName;"sax";$refXMLDoc)
	If (Error=0)
		SN3_ManejaReferencias ("eliminar";10009;0;SNT_Accion_Actualizar;->$arrayLong)
		SN3_RegisterLogEntry (SN3_Log_FileGeneration;"Generación del documento con "+String:C10($size)+" registros de sesiones.")
	Else 
		SN3_RegisterLogEntry (SN3_Log_Error;"El documento con registros de sesiones no pudo ser generado.";Error)
	End if 
End if 

SN3_SetErrorHandler ("clear";$currentErrorHandler)
