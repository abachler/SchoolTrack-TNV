If (Self:C308->=1)
	AL_SetEnterable (xALP_ExportBankFilesH;1;0)
	  //AL_SetEnterable (xALP_ExportBankFilesH;2;1)
	  //AL_SetEnterable (xALP_ExportBankFilesH;3;1)
	AL_SetEnterable (xALP_ExportBankFilesH;4;1)
	  //AL_SetEnterable (xALP_ExportBankFilesH;5;1)
	  //AL_SetEnterable (xALP_ExportBankFilesH;6;1)
	  //AL_SetEnterable (xALP_ExportBankFilesH;7;1)
	  //AL_SetEnterable (xALP_ExportBankFilesH;8;1)
	AL_SetEnterable (xALP_ExportBankFilesH;9;1)
	AL_SetEnterable (xALP_ExportBankFilesH;2;2;at_DescripcionExp)  //2 Arreglos
	AL_SetEnterable (xALP_ExportBankFilesH;6;2;atACT_FormatExp)  //6 FORMATO
	AL_SetEnterable (xALP_ExportBankFilesH;7;2;atACT_AlinExp)  //7 Alineado
	AL_SetEnterable (xALP_ExportBankFilesH;8;2;atACT_FillExp)  //8 Relleno
	IT_SetButtonState (True:C214;->bInsertLine)
Else 
	If (Size of array:C274(al_NumeroHe)>0)
		$el:=CD_Dlog (0;__ ("Se limpiarán los datos ingresados");__ ("");__ ("Aceptar");__ ("Cancelar"))
		If ($el=1)
			AL_UpdateArrays (xALP_ExportBankFilesH;0)
			AT_Initialize (->al_NumeroHe;->at_DescripcionHe;->al_PosIniHe;->al_LargoHe;->al_PosFinalHe;->at_formatoHe;->at_AlineadoHe;->at_RellenoHe;->at_TextoFijoHe)
			AL_UpdateArrays (xALP_ExportBankFilesH;-2)
			AL_SetEnterable (xALP_ExportBankFilesH;1;0)
			AL_SetEnterable (xALP_ExportBankFilesH;2;0)
			AL_SetEnterable (xALP_ExportBankFilesH;3;0)
			AL_SetEnterable (xALP_ExportBankFilesH;4;0)
			AL_SetEnterable (xALP_ExportBankFilesH;5;0)
			AL_SetEnterable (xALP_ExportBankFilesH;6;0)
			AL_SetEnterable (xALP_ExportBankFilesH;7;0)
			AL_SetEnterable (xALP_ExportBankFilesH;8;0)
			AL_SetEnterable (xALP_ExportBankFilesH;9;0)
			IT_SetButtonState (False:C215;->bSubirLineaExp;->bBajarLineaExp;->bDeleteLine;->bInsertLine)
		Else 
			Self:C308->:=1
		End if 
	Else 
		IT_SetButtonState (False:C215;->bSubirLineaExp;->bBajarLineaExp;->bDeleteLine;->bInsertLine)
	End if 
End if 