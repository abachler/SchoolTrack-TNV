//%attributes = {}
  //SN3_SendControlesMedicosXML

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

SN3_BuildSelections (SN3_DTi_Salud;$todos;$useArrays;SN3_SDTx_ControlesMedicos)
If (Records in selection:C76([Alumnos_ControlesMedicos:99])>0)
	ARRAY LONGINT:C221($arrayLong;0)
	ARRAY LONGINT:C221($recNums;0)
	SELECTION TO ARRAY:C260([Alumnos_ControlesMedicos:99];$recNums;[Alumnos_ControlesMedicos:99]ID:9;$arrayLong)
	
	$size:=Size of array:C274($recNums)
	
	$vt_FileName:=SN3_CreateFile2Send ("crear";"";SN3_ControlesMedicos;"sax";->$refXMLDoc)
	SN3_BuildFileHeader ($refXMLDoc;SN3_ControlesMedicos;"controles";$todos;$useArrays)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando documento con ")+String:C10($size)+__ (" registros de controles médicos..."))
	For ($indice;1;$size)
		KRL_GotoRecord (->[Alumnos_ControlesMedicos:99];$recNums{$indice};False:C215)
		SAX_CreateNode ($refXMLDoc;"control")
		SAX_CreateNode ($refXMLDoc;"idcontrol";True:C214;String:C10([Alumnos_ControlesMedicos:99]ID:9))
		SAX_CreateNode ($refXMLDoc;"idalumno";True:C214;String:C10([Alumnos_ControlesMedicos:99]Numero_Alumno:1))
		SAX_CreateNode ($refXMLDoc;"fecha";True:C214;SN3_MakeDateInmune2LocalFormat ([Alumnos_ControlesMedicos:99]Fecha:2))
		SAX_CreateNode ($refXMLDoc;"curso";True:C214;[Alumnos_ControlesMedicos:99]Curso:3;True:C214)
		SAX_CreateNode ($refXMLDoc;"edad";True:C214;[Alumnos_ControlesMedicos:99]Edad:4)
		SAX_CreateNode ($refXMLDoc;"talla";True:C214;String:C10([Alumnos_ControlesMedicos:99]Talla_cm:5))
		SAX_CreateNode ($refXMLDoc;"peso";True:C214;String:C10([Alumnos_ControlesMedicos:99]Peso_kg:6))
		SAX_CreateNode ($refXMLDoc;"imc";True:C214;[Alumnos_ControlesMedicos:99]IMC:8)
		SAX CLOSE XML ELEMENT:C854($refXMLDoc)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$indice/$size)
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	SN3_CloseXMLCompress ("";$vt_FileName;"sax";$refXMLDoc)
	If (Error=0)
		SN3_ManejaReferencias ("eliminar";SN3_ControlesMedicos;0;SNT_Accion_Actualizar;->$arrayLong)
		SN3_RegisterLogEntry (SN3_Log_FileGeneration;"Generación del documento con "+String:C10($size)+" registros de controles médicos.")
	Else 
		SN3_RegisterLogEntry (SN3_Log_Error;"El documento con registros de controles médicos no pudo s"+"er generado.";Error)
	End if 
End if 
SN3_SetErrorHandler ("clear";$currentErrorHandler)