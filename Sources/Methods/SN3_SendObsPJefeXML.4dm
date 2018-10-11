//%attributes = {}
  //SN3_SendObsPJefeXML

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

SN3_BuildSelections (SN3_DTi_Observaciones;$todos;$useArrays;SN3_SDTx_ProfesorJefe)
If (Records in selection:C76([Alumnos_SintesisAnual:210])>0)
	ARRAY LONGINT:C221($arrayLong;0)
	ARRAY LONGINT:C221($recNums;0)
	SELECTION TO ARRAY:C260([Alumnos_SintesisAnual:210];$recNums;[Alumnos_SintesisAnual:210]ID:267;$arrayLong)
	
	$size:=Size of array:C274($recNums)
	
	$vt_FileName:=SN3_CreateFile2Send ("crear";"";SN3_ObsJefatura;"sax";->$refXMLDoc)
	SN3_BuildFileHeader ($refXMLDoc;SN3_ObsJefatura;"observaciones";$todos;$useArrays)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando documento con ")+String:C10($size)+__ (" registros de observaciones del profesor jefe..."))
	$curso:=""
	For ($indice;1;$size)
		KRL_GotoRecord (->[Alumnos_SintesisAnual:210];$recNums{$indice};False:C215)
		RELATE ONE:C42([Alumnos_SintesisAnual:210]ID_Alumno:4)
		If ([Alumnos:2]curso:20#$curso)
			QUERY:C277([Cursos:3];[Cursos:3]Curso:1=[Alumnos:2]curso:20)
			$curso:=[Alumnos:2]curso:20
		End if 
		PERIODOS_LoadData ([Alumnos:2]nivel_numero:29)
		For ($j;1;viSTR_Periodos_NumeroPeriodos)
			SAX_CreateNode ($refXMLDoc;"observacion")
			SAX_CreateNode ($refXMLDoc;"id";True:C214;String:C10([Alumnos_SintesisAnual:210]ID:267))
			SAX_CreateNode ($refXMLDoc;"idalumno";True:C214;String:C10([Alumnos_SintesisAnual:210]ID_Alumno:4))
			SAX_CreateNode ($refXMLDoc;"idprofesorjefe";True:C214;String:C10([Cursos:3]Numero_del_profesor_jefe:2))
			Case of 
				: ($j=1)
					$obs:=[Alumnos_SintesisAnual:210]P01_Observaciones_Academicas:114
				: ($j=2)
					$obs:=[Alumnos_SintesisAnual:210]P02_Observaciones_Academicas:143
				: ($j=3)
					$obs:=[Alumnos_SintesisAnual:210]P03_Observaciones_Academicas:172
				: ($j=4)
					$obs:=[Alumnos_SintesisAnual:210]P04_Observaciones_Academicas:201
				: ($j=5)
					$obs:=[Alumnos_SintesisAnual:210]P05_Observaciones_Academicas:230
			End case 
			SAX_CreateNode ($refXMLDoc;"periodo";True:C214;String:C10($j))
			SAX_CreateNode ($refXMLDoc;"obs";True:C214;$obs;True:C214)
			SAX CLOSE XML ELEMENT:C854($refXMLDoc)
		End for 
		SAX_CreateNode ($refXMLDoc;"observacion")
		SAX_CreateNode ($refXMLDoc;"id";True:C214;String:C10([Alumnos_SintesisAnual:210]ID:267))
		SAX_CreateNode ($refXMLDoc;"idalumno";True:C214;String:C10([Alumnos_SintesisAnual:210]ID_Alumno:4))
		SAX_CreateNode ($refXMLDoc;"idprofesorjefe";True:C214;String:C10([Cursos:3]Numero_del_profesor_jefe:2))
		SAX_CreateNode ($refXMLDoc;"periodo";True:C214;"-1")
		$obs:=[Alumnos_SintesisAnual:210]Observaciones_Academicas:47
		SAX_CreateNode ($refXMLDoc;"obs";True:C214;$obs;True:C214)
		SAX CLOSE XML ELEMENT:C854($refXMLDoc)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$indice/$size)
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	SN3_CloseXMLCompress ("";$vt_FileName;"sax";$refXMLDoc)
	If (Error=0)
		SN3_ManejaReferencias ("eliminar";SN3_ObsJefatura;0;SNT_Accion_Actualizar;->$arrayLong)
		SN3_RegisterLogEntry (SN3_Log_FileGeneration;"Generación del documento con "+String:C10($size)+" registros de observaciones del profesor jefe.")
	Else 
		SN3_RegisterLogEntry (SN3_Log_Error;"El documento con registros de observaciones del profesor jefe no pudo ser generad"+"o.";Error)
	End if 
End if 
SN3_SetErrorHandler ("clear";$currentErrorHandler)

