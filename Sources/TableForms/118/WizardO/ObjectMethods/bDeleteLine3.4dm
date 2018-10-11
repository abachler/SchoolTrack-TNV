$line:=AL_GetLine (xALP_ExportBankFiles)
If ($line>0)
	If (al_Numero{$line}#Size of array:C274(al_Numero))
		CD_Dlog (1;__ ("Sólo puede eliminar la última fila"))
	Else 
		If (($line>=1) & (al_Numero{$line}=Size of array:C274(al_Numero)))
			AL_GetSort (xALP_ExportBankFiles;$c1)
			AL_UpdateArrays (xALP_ExportBankFiles;0)
			If (PWTrf_Ptb1=1)
				AT_Delete ($line;1;->al_Numero;->at_Descripcion;->al_PosIni;->al_Largo;->al_PosFinal;->at_formato;->at_Alineado;->at_Relleno;->at_TextoFijo)
			Else 
				AT_Delete ($line;1;->al_Numero;->at_Descripcion;->al_PosIni;->al_Largo;->al_PosFinal;->at_formato;->at_Alineado;->at_Relleno;->at_TextoFijo;->at_HeaderAC)
			End if 
			AL_UpdateArrays (xALP_ExportBankFiles;-2)
			AL_SetLine (xALP_ExportBankFiles;$line-1)
			$line:=AL_GetLine (xALP_ExportBankFiles)
			IT_SetButtonState (($line>0);->bDeleteLine)
			If (($line=0) | ($line=1))
				_O_DISABLE BUTTON:C193(bSubirLineaExp)
			Else 
				_O_ENABLE BUTTON:C192(bSubirLineaExp)
			End if 
			
			If (($line=0) | ($line=Size of array:C274(al_Numero)))
				_O_DISABLE BUTTON:C193(bBajarLineaExp)
			Else 
				_O_ENABLE BUTTON:C192(bBajarLineaExp)
			End if 
		End if 
	End if 
End if 
