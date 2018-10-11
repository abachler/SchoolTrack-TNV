If (Self:C308->=1)
	AL_SetEnterable (xALP_ExportBankFilesF;1;0)
	  //AL_SetEnterable (xALP_ExportBankFilesF;2;1)
	  //AL_SetEnterable (xALP_ExportBankFilesF;3;1)
	AL_SetEnterable (xALP_ExportBankFilesF;4;1)
	  //AL_SetEnterable (xALP_ExportBankFilesF;5;1)
	  //AL_SetEnterable (xALP_ExportBankFilesF;6;1)
	  //AL_SetEnterable (xALP_ExportBankFilesF;7;1)
	  //AL_SetEnterable (xALP_ExportBankFilesF;8;1)
	AL_SetEnterable (xALP_ExportBankFilesF;9;1)
	AL_SetEnterable (xALP_ExportBankFilesF;2;2;at_DescripcionExp)  //2 Arreglos
	AL_SetEnterable (xALP_ExportBankFilesF;6;2;atACT_FormatExp)  //6 FORMATO
	AL_SetEnterable (xALP_ExportBankFilesF;7;2;atACT_AlinExp)  //7 Alineado
	AL_SetEnterable (xALP_ExportBankFilesF;8;2;atACT_FillExp)  //8 Relleno
	IT_SetButtonState (True:C214;->bInsertLine)
Else 
	If (Size of array:C274(al_NumeroFo)>0)
		$el:=CD_Dlog (0;__ ("Se limpiarán los datos ingresados");__ ("");__ ("Aceptar");__ ("Cancelar"))
		If ($el=1)
			AL_UpdateArrays (xALP_ExportBankFilesF;0)
			AT_Initialize (->al_NumeroFo;->at_DescripcionFo;->al_PosIniFo;->al_LargoFo;->al_PosFinalFo;->at_formatoFo;->at_AlineadoFo;->at_RellenoFo;->at_TextoFijoFo)
			AL_UpdateArrays (xALP_ExportBankFilesF;-2)
			AL_SetEnterable (xALP_ExportBankFilesF;1;0)
			AL_SetEnterable (xALP_ExportBankFilesF;2;0)
			AL_SetEnterable (xALP_ExportBankFilesF;3;0)
			AL_SetEnterable (xALP_ExportBankFilesF;4;0)
			AL_SetEnterable (xALP_ExportBankFilesF;5;0)
			AL_SetEnterable (xALP_ExportBankFilesF;6;0)
			AL_SetEnterable (xALP_ExportBankFilesF;7;0)
			AL_SetEnterable (xALP_ExportBankFilesF;8;0)
			AL_SetEnterable (xALP_ExportBankFilesF;9;0)
			IT_SetButtonState (False:C215;->bSubirLineaExp;->bBajarLineaExp;->bDeleteLine;->bInsertLine)
		Else 
			Self:C308->:=1
		End if 
	Else 
		IT_SetButtonState (False:C215;->bSubirLineaExp;->bBajarLineaExp;->bDeleteLine;->bInsertLine)
	End if 
End if 