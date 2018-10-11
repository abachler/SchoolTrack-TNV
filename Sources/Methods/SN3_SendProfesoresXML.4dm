//%attributes = {}
  //SN3_SendProfesoresXML

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

SN3_BuildSelections (SN3_DTi_Profesores;$todos;$useArrays)
If (Records in selection:C76([Profesores:4])>0)
	ARRAY LONGINT:C221($arrayLong;0)
	ARRAY LONGINT:C221($recNums;0)
	SELECTION TO ARRAY:C260([Profesores:4];$recNums;[Profesores:4]Numero:1;$arrayLong)
	
	$size:=Size of array:C274($recNums)
	
	$vt_FileName:=SN3_CreateFile2Send ("crear";"";SN3_Profesores;"sax";->$refXMLDoc)
	SN3_BuildFileHeader ($refXMLDoc;SN3_Profesores;"profesores";$todos;$useArrays)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando documento con ")+String:C10($size)+__ (" registros de profesores..."))
	For ($indice;1;$size)
		KRL_GotoRecord (->[Profesores:4];$recNums{$indice};False:C215)
		$vt_name:=ST_GetCleanString ([Profesores:4]Nombres:2+[Profesores:4]Apellido_paterno:3+[Profesores:4]Apellido_materno:4)
		If ($vt_name#"")
			SAX_CreateNode ($refXMLDoc;"profesor")
			SAX_CreateNode ($refXMLDoc;"id";True:C214;String:C10([Profesores:4]Numero:1))
			If ([Profesores:4]RUT:27#"")
				SAX_CreateNode ($refXMLDoc;"idnacional";True:C214;[Profesores:4]RUT:27;True:C214)
			Else 
				SAX_CreateNode ($refXMLDoc;"idnacional";True:C214;[Profesores:4]Pasaporte:60;True:C214)
			End if 
			SAX_CreateNode ($refXMLDoc;"nombres";True:C214;[Profesores:4]Nombres:2;True:C214)
			SAX_CreateNode ($refXMLDoc;"appaterno";True:C214;[Profesores:4]Apellido_paterno:3;True:C214)
			SAX_CreateNode ($refXMLDoc;"apmaterno";True:C214;[Profesores:4]Apellido_materno:4;True:C214)
			SAX_CreateNode ($refXMLDoc;"nombrecomun";True:C214;[Profesores:4]Nombre_comun:21;True:C214)
			SAX_CreateNode ($refXMLDoc;"sexo";True:C214;[Profesores:4]Sexo:5;True:C214)  //mono sn3 cambio
			SAX_CreateNode ($refXMLDoc;"email";True:C214;[Profesores:4]eMail_profesional:38;True:C214)
			SET BLOB SIZE:C606($blob;0)
			PICTURE TO BLOB:C692([Profesores:4]Fotografia:59;$blob;".jpg")
			SAX OPEN XML ELEMENT:C853($refXMLDoc;"foto")
			SAX ADD XML ELEMENT VALUE:C855($refXMLDoc;$blob)
			SAX CLOSE XML ELEMENT:C854($refXMLDoc)
			
			SAX CLOSE XML ELEMENT:C854($refXMLDoc)
		End if 
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$indice/$size)
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	SN3_CloseXMLCompress ("";$vt_FileName;"sax";$refXMLDoc)
	If (Error=0)
		SN3_ManejaReferencias ("eliminar";SN3_Profesores;0;SNT_Accion_Actualizar;->$arrayLong)
		SN3_RegisterLogEntry (SN3_Log_FileGeneration;"Generación del documento con "+String:C10($size)+" registros de profesores.")
	Else 
		SN3_RegisterLogEntry (SN3_Log_Error;"El documento con registros de profesores no pudo ser generado.";Error)
	End if 
End if 

SN3_SetErrorHandler ("clear";$currentErrorHandler)

