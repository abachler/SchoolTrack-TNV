  //(xALP_ExportBankFiles;1;8;"al_Numero";"at_Descripcion";"al_PosIni";"al_Largo";"al_PosFinal";"al_formato";"al_Alineado";"al_Relleno")
$line:=AL_GetLine (xALP_ExportBankFilesH)
If ($line>0)
	If (al_NumeroHe{$line}#Size of array:C274(al_NumeroHe))
		CD_Dlog (1;__ ("Sólo puede eliminar la última fila"))
	Else 
		If (($line>=1) & (al_NumeroHe{$line}=Size of array:C274(al_NumeroHe)))
			AL_GetSort (xALP_ExportBankFilesH;$c1)
			AL_UpdateArrays (xALP_ExportBankFilesH;0)
			AT_Delete ($line;1;->al_NumeroHe;->at_DescripcionHe;->al_PosIniHe;->al_LargoHe;->al_PosFinalHe;->at_formatoHe;->at_AlineadoHe;->at_RellenoHe;->at_TextoFijoHe)
			AL_UpdateArrays (xALP_ExportBankFilesH;-2)
			  //AL_SetSort (xALP_ExportBankFilesH;$c1)
			AL_SetLine (xALP_ExportBankFilesH;$line-1)
			$line:=AL_GetLine (xALP_ExportBankFilesH)
			IT_SetButtonState (($line>0);->bDeleteLine)
			
			
			If (($line=0) | ($line=1))
				_O_DISABLE BUTTON:C193(bSubirLineaExp)
			Else 
				_O_ENABLE BUTTON:C192(bSubirLineaExp)
			End if 
			
			If (($line=0) | ($line=Size of array:C274(al_NumeroHe)))
				_O_DISABLE BUTTON:C193(bBajarLineaExp)
			Else 
				_O_ENABLE BUTTON:C192(bBajarLineaExp)
			End if 
		End if 
	End if 
End if 
  //REDRAW WINDOW