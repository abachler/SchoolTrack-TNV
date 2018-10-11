//%attributes = {}
  //SN3_SendHorariosXML

  //`======
  // Modified by: abachler (5/2/10)
vb_ConstantesModificadas:=True:C214
  //`======


C_BOOLEAN:C305($1;$2;$todos;$useArrays)
C_TIME:C306($refXMLDoc)
C_TEXT:C284($t_aliasHora)
C_LONGINT:C283($l_NivAsig;$l_confPeriodo;$last_idConfPeriodo;$last_NoNivel;$fia)
ARRAY INTEGER:C220($aiSTR_Horario_HoraNo;0)
ARRAY TEXT:C222($atSTR_Horario_HoraAlias;0)

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
SN3_BuildSelections (SN3_DTi_Horarios;$todos;$useArrays)
If (Records in selection:C76([TMT_Horario:166])>0)
	ARRAY LONGINT:C221($arrayLong;0)
	ARRAY LONGINT:C221($recNums;0)
	SELECTION TO ARRAY:C260([TMT_Horario:166];$recNums;[TMT_Horario:166]ID:15;$arrayLong)
	
	$size:=Size of array:C274($recNums)
	
	$vt_FileName:=SN3_CreateFile2Send ("crear";"";SN3_Horarios;"sax";->$refXMLDoc)
	SN3_BuildFileHeader ($refXMLDoc;SN3_Horarios;"horarios";$todos;$useArrays)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando documento con ")+String:C10($size)+__ (" registros de horario..."))
	For ($indice;1;$size)
		KRL_GotoRecord (->[TMT_Horario:166];$recNums{$indice};False:C215)
		SAX_CreateNode ($refXMLDoc;"horario")
		SAX_CreateNode ($refXMLDoc;"id";True:C214;String:C10([TMT_Horario:166]ID:15))
		SAX_CreateNode ($refXMLDoc;"idasignatura";True:C214;String:C10([TMT_Horario:166]ID_Asignatura:5))
		SAX_CreateNode ($refXMLDoc;"idprofesor";True:C214;String:C10([TMT_Horario:166]ID_Teacher:9))
		SAX_CreateNode ($refXMLDoc;"numerodia";True:C214;String:C10([TMT_Horario:166]NumeroDia:1))
		SAX_CreateNode ($refXMLDoc;"numerohora";True:C214;String:C10([TMT_Horario:166]NumeroHora:2))
		SAX_CreateNode ($refXMLDoc;"numerociclo";True:C214;String:C10([TMT_Horario:166]No_Ciclo:14))
		SAX_CreateNode ($refXMLDoc;"sala";True:C214;[TMT_Horario:166]Sala:8)
		  //20140403 ASM ticket 130785
		SAX_CreateNode ($refXMLDoc;"desde";True:C214;String:C10([TMT_Horario:166]SesionesDesde:12))
		SAX_CreateNode ($refXMLDoc;"hasta";True:C214;String:C10([TMT_Horario:166]SesionesHasta:13))
		SAX CLOSE XML ELEMENT:C854($refXMLDoc)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$indice/$size)
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	SN3_CloseXMLCompress ("";$vt_FileName;"sax";$refXMLDoc)
	If (Error=0)
		SN3_ManejaReferencias ("eliminar";SN3_Horarios;0;SNT_Accion_Actualizar;->$arrayLong)
		SN3_RegisterLogEntry (SN3_Log_FileGeneration;"Generación del documento con "+String:C10($size)+" registros de horario.")
	Else 
		SN3_RegisterLogEntry (SN3_Log_Error;"El documento con registros de horario no pudo ser generado.";Error)
	End if 
End if 

SN3_SetErrorHandler ("clear";$currentErrorHandler)

