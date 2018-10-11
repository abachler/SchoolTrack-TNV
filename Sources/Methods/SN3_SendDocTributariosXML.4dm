//%attributes = {}
  //SN3_SendDocTributariosXML

  //`======
  // Modified by: abachler (5/2/10)
vb_ConstantesModificadas:=True:C214
  //`======


C_BOOLEAN:C305($1;$2;$todos;$useArrays)
C_TIME:C306($refXMLDoc)
C_LONGINT:C283($l_indice;$l_idRS)

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

SN3_BuildSelections (SN3_DTi_DTrib;$todos;$useArrays)  //20180323 RCH Ticket 202242. Esta linea estaba comentada
If (Records in selection:C76([ACT_Boletas:181])>0)
	READ ONLY:C145([ACT_RazonesSociales:279])
	ARRAY LONGINT:C221($arrayLong;0)
	ARRAY LONGINT:C221($recNums;0)
	
	ARRAY LONGINT:C221($al_idRS;0)
	ARRAY BOOLEAN:C223($ab_esEmisor;0)
	SELECTION TO ARRAY:C260([ACT_Boletas:181];$recNums;[ACT_Boletas:181]ID:1;$arrayLong;[ACT_Boletas:181]ID_RazonSocial:25;$al_idRS)
	
	AT_DistinctsArrayValues (->$al_idRS)
	If (Find in array:C230($al_idRS;0)>0)  //si hay recs con id 0, se verifica que el -1 exista en el arreglo
		AT_Delete (Find in array:C230($al_idRS;0);1;->$al_idRS)
		If (Find in array:C230($al_idRS;-1)=0)
			APPEND TO ARRAY:C911($al_idRS;-1)
		End if 
	End if 
	
	  //Verifico si RS es emisora CLG. DIsminuyo llamados a ACTdte_EsEmisorColegium porque demoraba mucho.
	For ($l_indice;1;Size of array:C274($al_idRS))
		APPEND TO ARRAY:C911($ab_esEmisor;ACTdte_EsEmisorColegium ($al_idRS{$l_indice}))
	End for 
	
	$size:=Size of array:C274($recNums)
	
	$vt_FileName:=SN3_CreateFile2Send ("crear";"";SN3_ACT_DocumentosTributarios;"sax";->$refXMLDoc)
	SN3_BuildFileHeader ($refXMLDoc;SN3_ACT_DocumentosTributarios;"documentos";$todos;$useArrays)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando documento con ")+String:C10($size)+__ (" registros de documentos tributarios..."))
	For ($indice;1;$size)
		KRL_GotoRecord (->[ACT_Boletas:181];$recNums{$indice};False:C215)
		If (((<>GCOUNTRYCODE="cl") & ([ACT_Boletas:181]Numero:11#0)) | (<>GCOUNTRYCODE#"cl"))
			SAX_CreateNode ($refXMLDoc;"documento")
			SAX_CreateNode ($refXMLDoc;"id";True:C214;String:C10([ACT_Boletas:181]ID:1))
			SAX_CreateNode ($refXMLDoc;"folio";True:C214;String:C10([ACT_Boletas:181]Numero:11))
			SAX_CreateNode ($refXMLDoc;"tipo";True:C214;[ACT_Boletas:181]TipoDocumento:7)
			SAX_CreateNode ($refXMLDoc;"fecha";True:C214;SN3_MakeDateInmune2LocalFormat ([ACT_Boletas:181]FechaEmision:3))
			SAX_CreateNode ($refXMLDoc;"monto";True:C214;String:C10([ACT_Boletas:181]Monto_Total:6;"|Despliegue_ACT"))
			SAX_CreateNode ($refXMLDoc;"codigosii";True:C214;[ACT_Boletas:181]codigo_SII:33)
			  //$esDTE:=([ACT_Boletas]documento_electronico) & (ACTdte_EsEmisorColegium ([ACT_Boletas]ID_RazonSocial))
			$l_idRS:=Choose:C955([ACT_Boletas:181]ID_RazonSocial:25=0;-1;[ACT_Boletas:181]ID_RazonSocial:25)
			$esDTE:=(([ACT_Boletas:181]documento_electronico:29) & ($ab_esEmisor{Find in array:C230($al_idRS;$l_idRS)}))
			SAX_CreateNode ($refXMLDoc;"esDTE";True:C214;String:C10(Num:C11($esDTE)))
			$rut:=KRL_GetTextFieldData (->[ACT_RazonesSociales:279]id:1;->[ACT_Boletas:181]ID_RazonSocial:25;->[ACT_RazonesSociales:279]RUT:3)
			SAX_CreateNode ($refXMLDoc;"rutrazonsocial";True:C214;ACTcfg_opcionesDTE ("GetFormatoRUT";->$rut))
			  //20170214 RCH
			SAX_CreateNode ($refXMLDoc;"idapoderado";True:C214;String:C10([ACT_Boletas:181]ID_Apoderado:14))
			SAX_CreateNode ($refXMLDoc;"idestado";True:C214;String:C10([ACT_Boletas:181]ID_Estado:20))
		End if 
		SAX CLOSE XML ELEMENT:C854($refXMLDoc)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$indice/$size)
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	SN3_CloseXMLCompress ("";$vt_FileName;"sax";$refXMLDoc)
	If (Error=0)
		SN3_ManejaReferencias ("eliminar";SN3_ACT_DocumentosTributarios;0;SNT_Accion_Actualizar;->$arrayLong)
		SN3_RegisterLogEntry (SN3_Log_FileGeneration;"Generación del documento con "+String:C10($size)+" registros de documentos tributarios.")
	Else 
		SN3_RegisterLogEntry (SN3_Log_Error;"El documento con registros de documentos tributarios no pudo ser generado.";Error)
	End if 
End if 
SN3_SetErrorHandler ("clear";$currentErrorHandler)