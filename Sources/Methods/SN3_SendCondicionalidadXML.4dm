//%attributes = {}
  //SN3_SendCondicionalidadXML

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

SN3_BuildSelections (SN3_DTi_Conducta;$todos;$useArrays;SN3_SDTx_Condicionalidad)
If (Records in selection:C76([Alumnos:2])>0)
	$vt_FileName:=SN3_CreateFile2Send ("crear";"";SN3_Condicionalidad;"sax";->$refXMLDoc)
	SN3_BuildFileHeader ($refXMLDoc;SN3_Condicionalidad;"condicionalidades";$todos;$useArrays)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando documento con ")+String:C10(Records in selection:C76([Alumnos:2]))+__ (" registros de condicionalidad..."))
	FIRST RECORD:C50([Alumnos:2])
	While (Not:C34(End selection:C36([Alumnos:2])))
		$key:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10([Alumnos:2]nivel_numero:29)+"."+String:C10([Alumnos:2]numero:1)
		KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$key)
		SAX_CreateNode ($refXMLDoc;"condicionalidad")
		SAX_CreateNode ($refXMLDoc;"idalumno";True:C214;String:C10([Alumnos:2]numero:1))
		SAX_CreateNode ($refXMLDoc;"tienecondicionalidad";True:C214;String:C10(Num:C11([Alumnos_SintesisAnual:210]Condicionalidad_Activada:57)))
		SAX_CreateNode ($refXMLDoc;"hasta";True:C214;SN3_MakeDateInmune2LocalFormat ([Alumnos_SintesisAnual:210]Condicionalidad_Hasta:58))
		SAX_CreateNode ($refXMLDoc;"motivo";True:C214;[Alumnos_SintesisAnual:210]Condicionalidad_Motivo:59;True:C214)
		SAX CLOSE XML ELEMENT:C854($refXMLDoc)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;Selected record number:C246([Alumnos:2])/Records in selection:C76([Alumnos:2]))
		NEXT RECORD:C51([Alumnos:2])
	End while 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	SN3_CloseXMLCompress ("";$vt_FileName;"sax";$refXMLDoc)
	If (Error=0)
		SN3_ManejaReferencias ("eliminar";SN3_Condicionalidad;0;SNT_Accion_Actualizar)
		SN3_RegisterLogEntry (SN3_Log_FileGeneration;"Generación del documento con "+String:C10(Records in selection:C76([Alumnos:2]))+" registros de condicionalidad.")
	Else 
		SN3_RegisterLogEntry (SN3_Log_Error;"El documento con registros de condicionalidad no pudo ser generado.";Error)
	End if 
End if 

SN3_SetErrorHandler ("clear";$currentErrorHandler)

