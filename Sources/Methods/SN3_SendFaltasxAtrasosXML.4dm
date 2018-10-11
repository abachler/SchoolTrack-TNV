//%attributes = {}
  // ----------------------------------------------------
  // Usuario (SO): Daniel Ledezma
  // Fecha y hora: 28-09-18, 14:38:30
  // ----------------------------------------------------
  // Método: SN3_SendFaltasxAtrasosXML
  // TICKET 209421
  // ----------------------------------------------------
ARRAY LONGINT:C221($al_rnASA;0)
C_LONGINT:C283($l_nivelcargado;$i;$p)
C_BOOLEAN:C305($1;$2;$todos;$useArrays)
C_TIME:C306($refXMLDoc)
C_POINTER:C301($y_frj;$y_frs)

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

SN3_BuildSelections (SN3_DTi_Conducta;$todos;$useArrays;-9)

If (Records in selection:C76([Alumnos_SintesisAnual:210])>0)
	
	READ ONLY:C145([Alumnos_SintesisAnual:210])
	$vt_FileName:=SN3_CreateFile2Send ("crear";"";101055;"sax";->$refXMLDoc)
	SN3_BuildFileHeader ($refXMLDoc;101055;"faltasxatrasos";$todos;$useArrays)
	LONGINT ARRAY FROM SELECTION:C647([Alumnos_SintesisAnual:210];$al_rnASA;"")
	
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando documento con ")+String:C10(Size of array:C274($al_rnASA))+__ (" registros de Faltas por Atrasos..."))
	
	For ($i;1;Size of array:C274($al_rnASA))
		
		GOTO RECORD:C242([Alumnos_SintesisAnual:210];$al_rnASA{$i})
		If ($l_nivelcargado#[Alumnos_SintesisAnual:210]NumeroNivel:6)
			$l_nivelcargado:=[Alumnos_SintesisAnual:210]NumeroNivel:6
			PERIODOS_LoadData ([Alumnos_SintesisAnual:210]NumeroNivel:6)
		End if 
		
		SAX_CreateNode ($refXMLDoc;"faltasxatrasos")
		SAX_CreateNode ($refXMLDoc;"idalumno";True:C214;String:C10([Alumnos_SintesisAnual:210]ID_Alumno:4))
		SAX_CreateNode ($refXMLDoc;"FaltasxRetardoJornada";True:C214;String:C10([Alumnos_SintesisAnual:210]Faltas_x_RetardoJornada:45);True:C214)
		SAX_CreateNode ($refXMLDoc;"FaltasxRetardoSesiones";True:C214;String:C10([Alumnos_SintesisAnual:210]Faltas_x_RetardoSesiones:46);True:C214)
		SAX_CreateNode ($refXMLDoc;"periodo";True:C214;"-1")
		SAX CLOSE XML ELEMENT:C854($refXMLDoc)
		
		For ($p;1;viSTR_Periodos_NumeroPeriodos)
			SAX_CreateNode ($refXMLDoc;"faltasxatrasos")
			$y_frj:=KRL_GetFieldPointerByName ("[Alumnos_SintesisAnual]P0"+String:C10($p)+"_Faltas_x_RetardoJornada")
			$y_frs:=KRL_GetFieldPointerByName ("[Alumnos_SintesisAnual]P0"+String:C10($p)+"_Faltas_x_RetardoSesiones")
			SAX_CreateNode ($refXMLDoc;"idalumno";True:C214;String:C10([Alumnos_SintesisAnual:210]ID_Alumno:4))
			SAX_CreateNode ($refXMLDoc;"FaltasxRetardoJornada";True:C214;String:C10($y_frj->);True:C214)
			SAX_CreateNode ($refXMLDoc;"FaltasxRetardoSesiones";True:C214;String:C10($y_frs->);True:C214)
			SAX_CreateNode ($refXMLDoc;"periodo";True:C214;String:C10($p))
			SAX CLOSE XML ELEMENT:C854($refXMLDoc)
		End for 
		
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($al_rnASA))
		
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	SN3_CloseXMLCompress ("";$vt_FileName;"sax";$refXMLDoc)
	
	If (Error=0)
		SN3_ManejaReferencias ("eliminar";101055;0;SNT_Accion_Actualizar)
		SN3_RegisterLogEntry (SN3_Log_FileGeneration;"Generación del documento con "+String:C10(Size of array:C274($al_rnASA))+" registros de Faltas por Atrasos.")
	Else 
		SN3_RegisterLogEntry (SN3_Log_Error;"El documento con registros de Faltas por Atrasos no pudo ser generado.";Error)
	End if 
End if 

SN3_SetErrorHandler ("clear";$currentErrorHandler)
