//%attributes = {}
  //SN3_SendActividadesXML

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

SN3_BuildSelections (SN3_DTi_ActividadesExtraCurr;$todos;$useArrays)
If (Records in selection:C76([Actividades:29])>0)
	ARRAY LONGINT:C221($arrayLong;0)
	ARRAY LONGINT:C221($recNums;0)
	SELECTION TO ARRAY:C260([Actividades:29];$recNums;[Actividades:29]ID:1;$arrayLong)
	
	$size:=Size of array:C274($recNums)
	
	$vt_FileName:=SN3_CreateFile2Send ("crear";"";SN3_Actividades;"sax";->$refXMLDoc)
	SN3_BuildFileHeader ($refXMLDoc;SN3_Actividades;"actividades";$todos;$useArrays)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando documento con ")+String:C10($size)+__ (" registros de actividades..."))
	For ($indice;1;$size)
		KRL_GotoRecord (->[Actividades:29];$recNums{$indice};False:C215)
		SAX_CreateNode ($refXMLDoc;"actividad")
		SAX_CreateNode ($refXMLDoc;"id";True:C214;String:C10([Actividades:29]ID:1))
		SAX_CreateNode ($refXMLDoc;"nombre";True:C214;[Actividades:29]Nombre:2;True:C214)
		SAX_CreateNode ($refXMLDoc;"descripcion";True:C214;[Actividades:29]Description:10;True:C214)
		SAX_CreateNode ($refXMLDoc;"idprofesor";True:C214;String:C10([Actividades:29]No_Profesor:3))
		SAX_CreateNode ($refXMLDoc;"idconfigperiodos";True:C214;String:C10([Actividades:29]ID_ConfiguracionPeriodos:13))
		SAX CLOSE XML ELEMENT:C854($refXMLDoc)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$indice/$size)
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	SN3_CloseXMLCompress ("";$vt_FileName;"sax";$refXMLDoc)
	If (Error=0)
		SN3_ManejaReferencias ("eliminar";SN3_Actividades;0;SNT_Accion_Actualizar;->$arrayLong)
		SN3_RegisterLogEntry (SN3_Log_FileGeneration;"Generación del documento con "+String:C10($size)+" registros de actividades.")
	Else 
		SN3_RegisterLogEntry (SN3_Log_Error;"El documento con registros de actividades no pudo ser generado.";Error)
	End if 
End if 

SN3_SetErrorHandler ("clear";$currentErrorHandler)