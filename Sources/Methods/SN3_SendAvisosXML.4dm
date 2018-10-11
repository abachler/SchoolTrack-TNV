//%attributes = {}
  //SN3_SendAvisosXML

  //`======
  // Modified by: abachler (5/2/10)
vb_ConstantesModificadas:=True:C214
  //`======


C_BOOLEAN:C305($1;$2;$todos;$useArrays)
C_TIME:C306($refXMLDoc)

  //20130510 RCH Se declaran los arreglos fuera del IF para que el archivo sea declarado a pesar de que no se cumpla la condicion.
ARRAY LONGINT:C221($aRNAvisos;0)
ARRAY TEXT:C222(SN3_AvisosPDF2Send;0)

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

SN3_BuildSelections (SN3_DTi_AvisosCobranza;$todos;$useArrays)
If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
	LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];$aRNAvisos;"")
	
	$vt_FileName:=SN3_CreateFile2Send ("crear";"";SN3_ACT_Avisos;"sax";->$refXMLDoc)
	SN3_BuildFileHeader ($refXMLDoc;SN3_ACT_Avisos;"avisos";$todos;$useArrays)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando documento con ")+String:C10(Size of array:C274($aRNAvisos))+__ (" registros de avisos de cobranza..."))
	For ($k;1;Size of array:C274($aRNAvisos))
		KRL_GotoRecord (->[ACT_Avisos_de_Cobranza:124];$aRNAvisos{$k};False:C215)
		SAX_CreateNode ($refXMLDoc;"aviso")
		SAX_CreateNode ($refXMLDoc;"id";True:C214;String:C10([ACT_Avisos_de_Cobranza:124]ID_Aviso:1))
		SAX_CreateNode ($refXMLDoc;"idpersona";True:C214;String:C10([ACT_Avisos_de_Cobranza:124]ID_Apoderado:3))
		SAX_CreateNode ($refXMLDoc;"fechaemision";True:C214;SN3_MakeDateInmune2LocalFormat ([ACT_Avisos_de_Cobranza:124]Fecha_Emision:4))
		SAX_CreateNode ($refXMLDoc;"fechavencimiento";True:C214;SN3_MakeDateInmune2LocalFormat ([ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5))
		SAX_CreateNode ($refXMLDoc;"saldoanterior";True:C214;String:C10([ACT_Avisos_de_Cobranza:124]Saldo_anterior:12;"|Despliegue_ACT"))
		SAX_CreateNode ($refXMLDoc;"intereses";True:C214;String:C10([ACT_Avisos_de_Cobranza:124]Intereses:13;"|Despliegue_ACT"))
		SAX_CreateNode ($refXMLDoc;"montoneto";True:C214;String:C10([ACT_Avisos_de_Cobranza:124]Monto_Neto:11;"|Despliegue_ACT"))
		SAX_CreateNode ($refXMLDoc;"montoapagar";True:C214;String:C10([ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14;"|Despliegue_ACT"))
		SAX_CreateNode ($refXMLDoc;"moneda";True:C214;[ACT_Avisos_de_Cobranza:124]Moneda:17;True:C214)
		SAX CLOSE XML ELEMENT:C854($refXMLDoc)
		APPEND TO ARRAY:C911(SN3_AvisosPDF2Send;"AC_"+String:C10([ACT_Avisos_de_Cobranza:124]ID_Aviso:1)+".pdf")
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$k/Size of array:C274($aRNAvisos))
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	SN3_CloseXMLCompress ("";$vt_FileName;"sax";$refXMLDoc)
	If (Error=0)
		SN3_ManejaReferencias ("eliminar";SN3_ACT_Avisos;0;SNT_Accion_Actualizar)
		SN3_ManejaReferencias ("eliminar";SN3_ACT_Cargos;0;SNT_Accion_Actualizar)
		SN3_RegisterLogEntry (SN3_Log_FileGeneration;"Generación del documento con "+String:C10(Size of array:C274($aRNAvisos))+" registros de avisos de cobranza.")
	Else 
		SN3_RegisterLogEntry (SN3_Log_Error;"El documento con registros de avisos de cobranza no pudo ser generado.";Error)
	End if 
End if 

SN3_SetErrorHandler ("clear";$currentErrorHandler)