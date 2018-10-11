//%attributes = {}
  //SN3_SendPagosXML

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

SN3_BuildSelections (SN3_DTi_Pagos;$todos;$useArrays)
If (Records in selection:C76([ACT_Pagos:172])>0)
	ARRAY LONGINT:C221($recNums;0)
	LONGINT ARRAY FROM SELECTION:C647([ACT_Pagos:172];$recNums;"")
	
	$size:=Size of array:C274($recNums)
	
	$vt_FileName:=SN3_CreateFile2Send ("crear";"";SN3_ACT_Pagos;"sax";->$refXMLDoc)
	SN3_BuildFileHeader ($refXMLDoc;SN3_ACT_Pagos;"pagos";$todos;$useArrays)
	
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando documento con ")+String:C10($size)+__ (" registros de pagos..."))
	For ($indice;1;$size)
		KRL_GotoRecord (->[ACT_Pagos:172];$recNums{$indice};False:C215)
		SAX_CreateNode ($refXMLDoc;"pago")
		SAX_CreateNode ($refXMLDoc;"idpersona";True:C214;String:C10([ACT_Pagos:172]ID_Apoderado:3))
		SAX_CreateNode ($refXMLDoc;"idpago";True:C214;String:C10([ACT_Pagos:172]ID:1))
		SAX_CreateNode ($refXMLDoc;"fechapago";True:C214;SN3_MakeDateInmune2LocalFormat ([ACT_Pagos:172]Fecha:2))
		SAX_CreateNode ($refXMLDoc;"montopago";True:C214;String:C10([ACT_Pagos:172]Monto_Pagado:5;"|Despliegue_ACT_Pagos"))
		SAX_CreateNode ($refXMLDoc;"saldopago";True:C214;String:C10([ACT_Pagos:172]Saldo:15;"|Despliegue_ACT_Pagos"))
		SAX_CreateNode ($refXMLDoc;"formapago";True:C214;[ACT_Pagos:172]forma_de_pago_new:31;True:C214)
		SAX CLOSE XML ELEMENT:C854($refXMLDoc)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$indice/$size)
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	SN3_CloseXMLCompress ("";$vt_FileName;"sax";$refXMLDoc)
	If (Error=0)
		SN3_ManejaReferencias ("eliminar";SN3_ACT_Pagos;0;SNT_Accion_Actualizar)
		SN3_RegisterLogEntry (SN3_Log_FileGeneration;"Generación del documento con "+String:C10($size)+" registros de pagos.")
	Else 
		SN3_RegisterLogEntry (SN3_Log_Error;"El documento con registros de pagos no pudo ser generado.";Error)
	End if 
End if 

SN3_SetErrorHandler ("clear";$currentErrorHandler)

