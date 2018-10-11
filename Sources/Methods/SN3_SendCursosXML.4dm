//%attributes = {}
  //SN3_SendCursosXML

  //`======
  // Modified by: abachler (5/2/10)
vb_ConstantesModificadas:=True:C214
  //`======

C_BOOLEAN:C305($1;$2;$todos;$useArrays)
C_TIME:C306($refXMLDoc)
C_REAL:C285($promedio_nota;$promedio_pto;$promedio_real)
C_TEXT:C284($promedio;$promedio_sim)
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

SN3_BuildSelections (SN3_DTi_Cursos;$todos;$useArrays)
If (Records in selection:C76([Cursos:3])>0)
	$vt_FileName:=SN3_CreateFile2Send ("crear";"";SN3_Cursos;"sax";->$refXMLDoc)
	SN3_BuildFileHeader ($refXMLDoc;SN3_Cursos;"cursos";$todos;$useArrays)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando documento con ")+String:C10(Records in selection:C76([Cursos:3]))+__ (" registros de cursos..."))
	FIRST RECORD:C50([Cursos:3])
	While (Not:C34(End selection:C36([Cursos:3])))
		SAX_CreateNode ($refXMLDoc;"curso")
		SAX_CreateNode ($refXMLDoc;"id";True:C214;String:C10([Cursos:3]Numero_del_curso:6))
		SAX_CreateNode ($refXMLDoc;"idprofesor";True:C214;String:C10([Cursos:3]Numero_del_profesor_jefe:2))
		SAX_CreateNode ($refXMLDoc;"idnivel";True:C214;String:C10([Cursos:3]Nivel_Numero:7))
		SAX_CreateNode ($refXMLDoc;"nombre";True:C214;[Cursos:3]Curso:1;True:C214)
		  //$key:=KRL_MakeStringAccesKey (-><>gInstitucion;-><>gYear;->[Cursos]Nivel_Numero;->[Cursos]Curso)//MONO 184433
		  //$promedio:=KRL_GetTextFieldData (->[Cursos_SintesisAnual]LLavePrimaria;->$key;->[Cursos_SintesisAnual]PromedioFinal_Literal)//MONO 184433
		$promedio:=KRL_GetTextFieldData (->[Cursos_SintesisAnual:63]LLavePrimaria:6;->[Cursos:3]LLaveSintesisAnual:4;->[Cursos_SintesisAnual:63]PromedioFinal_Literal:21)  //MONO 184433
		SAX_CreateNode ($refXMLDoc;"promedio";True:C214;$promedio)
		  //$promedio_real:=KRL_GetNumericFieldData (->[Cursos_SintesisAnual]LLavePrimaria;->$key;->[Cursos_SintesisAnual]PromedioFinal_Real)
		$promedio_real:=KRL_GetNumericFieldData (->[Cursos_SintesisAnual:63]LLavePrimaria:6;->[Cursos:3]LLaveSintesisAnual:4;->[Cursos_SintesisAnual:63]PromedioFinal_Real:17)  //MONO 184433
		If ($promedio_real>=0)
			SAX_CreateNode ($refXMLDoc;"porcentaje";True:C214;EV2_Real_a_Literal ($promedio_real;Porcentaje))
			  //$promedio_nota:=KRL_GetNumericFieldData (->[Cursos_SintesisAnual]LLavePrimaria;->$key;->[Cursos_SintesisAnual]PromedioFinal_Nota)
			$promedio_nota:=KRL_GetNumericFieldData (->[Cursos_SintesisAnual:63]LLavePrimaria:6;->[Cursos:3]LLaveSintesisAnual:4;->[Cursos_SintesisAnual:63]PromedioFinal_Nota:18)  //MONO 184433
			SAX_CreateNode ($refXMLDoc;"notanum";True:C214;EV2_Literal_Aplicacion (String:C10($promedio_nota)))
			  //$promedio_pto:=KRL_GetNumericFieldData (->[Cursos_SintesisAnual]LLavePrimaria;->$key;->[Cursos_SintesisAnual]PromedioFinal_Puntos)
			$promedio_pto:=KRL_GetNumericFieldData (->[Cursos_SintesisAnual:63]LLavePrimaria:6;->[Cursos:3]LLaveSintesisAnual:4;->[Cursos_SintesisAnual:63]PromedioFinal_Puntos:19)  //MONO 184433
			SAX_CreateNode ($refXMLDoc;"puntos";True:C214;EV2_Literal_Aplicacion (String:C10($promedio_pto)))
			  //$promedio_sim:=KRL_GetTextFieldData (->[Cursos_SintesisAnual]LLavePrimaria;->$key;->[Cursos_SintesisAnual]PromedioFinal_Simbolo)
			$promedio_sim:=KRL_GetTextFieldData (->[Cursos_SintesisAnual:63]LLavePrimaria:6;->[Cursos:3]LLaveSintesisAnual:4;->[Cursos_SintesisAnual:63]PromedioFinal_Simbolo:20)  //MONO 184433
			SAX_CreateNode ($refXMLDoc;"simbolo";True:C214;$promedio_sim)
		Else 
			SAX_CreateNode ($refXMLDoc;"porcentaje";True:C214;$promedio)
			SAX_CreateNode ($refXMLDoc;"notanum";True:C214;$promedio)
			SAX_CreateNode ($refXMLDoc;"puntos";True:C214;$promedio)
			SAX_CreateNode ($refXMLDoc;"simbolo";True:C214;$promedio)
		End if 
		
		SAX_CreateNode ($refXMLDoc;"nombrelargo";True:C214;[Cursos:3]Nombre_Largo_curso:46;True:C214)  // 20120619 ASM. Para enviar nombre largo del curso
		SAX CLOSE XML ELEMENT:C854($refXMLDoc)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;Selected record number:C246([Cursos:3])/Records in selection:C76([Cursos:3]))
		NEXT RECORD:C51([Cursos:3])
	End while 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	SN3_CloseXMLCompress ("";$vt_FileName;"sax";$refXMLDoc)
	If (Error=0)
		SN3_ManejaReferencias ("eliminar";SN3_Cursos;0;SNT_Accion_Actualizar)
		SN3_RegisterLogEntry (SN3_Log_FileGeneration;"Generación del documento con "+String:C10(Records in selection:C76([Cursos:3]))+" registros de cursos.")
	Else 
		SN3_RegisterLogEntry (SN3_Log_Error;"El documento con registros de cursos no pudo ser generado.";Error)
	End if 
End if 

SN3_SetErrorHandler ("clear";$currentErrorHandler)