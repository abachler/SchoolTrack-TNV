//%attributes = {}
  //xALP_GuardarDocumento

C_LONGINT:C283($1;$2)
C_BOOLEAN:C305($0)

_O_C_INTEGER:C282($id;$col;$row)
C_TEXT:C284($idText;$nombreDocumento;$tagDocumento;$tag)
ARRAY LONGINT:C221($idsDocumentos;0)
ARRAY LONGINT:C221($IdDocEnForm;0)

AL_GetCurrCell (xALP_Documentos;$col;$row)
AL_GetCellValue (xALP_Documentos;$row;4;$idText)
AL_GetCellValue (xALP_Documentos;$row;2;$nombreDocumento)
AL_GetCellValue (xALP_Documentos;$row;3;$tagDocumento)
$id:=Num:C11($idText)

If ($2=8)
	$0:=False:C215
Else 
	$0:=True:C214
	If ($col#1)
		
		
		Case of 
			: ($col=2)  //editando el nombre del documento
				
				If ($id#0)  //se esta editando un documento
					READ WRITE:C146([xxADT_Documentos:261])
					QUERY:C277([xxADT_Documentos:261];[xxADT_Documentos:261]ID_Documento:1=$id)
					[xxADT_Documentos:261]Nombre_Documento:2:=$nombreDocumento
					SAVE RECORD:C53([xxADT_Documentos:261])
				Else   //crea un nuevo documento
					READ WRITE:C146([xxADT_Documentos:261])
					CREATE RECORD:C68([xxADT_Documentos:261])
					[xxADT_Documentos:261]ID_Documento:1:=SQ_SeqNumber (->[xxADT_Documentos:261]ID_Documento:1)
					[xxADT_Documentos:261]Nombre_Documento:2:=$nombreDocumento
					$tag:=Replace string:C233($nombreDocumento;" ";"_")
					[xxADT_Documentos:261]TagDocumento:3:=$tag
					SAVE RECORD:C53([xxADT_Documentos:261])
				End if 
			: ($col=3)  //editando el tag del documento
				If ($id#0)  //se esta editando un documento
					READ WRITE:C146([xxADT_Documentos:261])
					QUERY:C277([xxADT_Documentos:261];[xxADT_Documentos:261]ID_Documento:1=$id)
					[xxADT_Documentos:261]TagDocumento:3:=$tagDocumento
					SAVE RECORD:C53([xxADT_Documentos:261])
				Else   //crea un nuevo documento
					READ WRITE:C146([xxADT_Documentos:261])
					CREATE RECORD:C68([xxADT_Documentos:261])
					[xxADT_Documentos:261]ID_Documento:1:=SQ_SeqNumber (->[xxADT_Documentos:261]ID_Documento:1)
					[xxADT_Documentos:261]TagDocumento:3:=$tagDocumento
					SAVE RECORD:C53([xxADT_Documentos:261])
				End if 
		End case 
		
		C_TEXT:C284($idFormulario)
		_O_C_INTEGER:C282($id;$indice)
		
		$row:=AL_GetLine (xALP_FormulariosOpciones)
		AL_GetCellValue (xALP_FormulariosOpciones;$row;2;$idFormulario)
		
		$id:=Num:C11($idFormulario)
		
		
		AT_Initialize (->atNombresDocumentos;->atTagDocumentos;->aiIDDocumentos)
		
		READ ONLY:C145([xxADT_Documentos:261])
		ALL RECORDS:C47([xxADT_Documentos:261])
		SELECTION TO ARRAY:C260([xxADT_Documentos:261]ID_Documento:1;aiIDDocumentos;[xxADT_Documentos:261]Nombre_Documento:2;atNombresDocumentos;[xxADT_Documentos:261]TagDocumento:3;atTagDocumentos)
		
		  //ahora actualizo el area list
		AL_SetLine (xALP_Documentos;0)
	End if 
	AL_UpdateArrays (xALP_Documentos;-2)
	AL_ExitCell (xALP_Documentos)
End if 