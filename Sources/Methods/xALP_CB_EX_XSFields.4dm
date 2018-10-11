//%attributes = {}
  //xALP_CB_EX_XSFields

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2)

If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
End if 
If (AL_GetCellMod (xALP_Fields)=1)
	AL_GetCurrCell (xALP_Fields;$col;$row)
	READ WRITE:C146([xShell_Fields:52])
	GOTO RECORD:C242([xShell_Fields:52];alXS_Fields_RecNums{$row})
	$fieldPtr:=Field:C253([xShell_Fields:52]NumeroTabla:1;[xShell_Fields:52]NumeroCampo:2)
	$oldIndex:=[xShell_Fields:52]EsCampoIndexado:6
	$newIndex:=abXS_Fields_Indexed{$row}
	[xShell_Fields:52]EsCampoIndexado:6:=abXS_Fields_Indexed{$row}
	[xShell_Fields:52]EsCampoOcultoEnEditores:9:=abXS_Fields_CampoOculto{$row}
	[xShell_Fields:52]EsImportable:13:=alXS_Fields_Importable{$row}
	[xShell_Fields:52]FormatoNombres:15:=arXS_Fields_AutoformatMode{$row}
	[xShell_Fields:52]ListaDeValoresAsociados:11:=atXS_Fields_AssociatedListArray{$row}
	[xShell_Fields:52]AutomaticSequenceNumber:23:=abXS_Fields_AutoSeqNumber{$row}
	SAVE RECORD:C53([xShell_Fields:52])
	XSvs_ActualizaLocalizacionCampo (Record number:C243([xShell_Fields:52]);vtXS_CountryCode;vtXS_LangageCode)
	
	KRL_UnloadReadOnly (->[xShell_Fields:52])
	If ($oldIndex)
		If (Not:C34($newIndex))
			MESSAGES OFF:C175
			$ProcID:=IT_UThermometer (1;0;__ ("Borrando index de campo ")+Field name:C257($fieldPtr)+__ ("..."))
			SET INDEX:C344($fieldPtr->;False:C215)
			IT_UThermometer (-2;$ProcID)
			MESSAGES ON:C181
		End if 
	Else 
		If ($newIndex)
			MESSAGES OFF:C175
			$ProcID:=IT_UThermometer (1;0;__ ("Indexando campo ")+Field name:C257($fieldPtr)+__ ("..."))
			SET INDEX:C344($fieldPtr->;True:C214;100)
			IT_UThermometer (-2;$ProcID)
			MESSAGES ON:C181
		End if 
	End if 
End if 