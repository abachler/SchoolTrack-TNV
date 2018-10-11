  //(xALP_ExportBankFiles;1;8;"al_Numero";"at_Descripcion";"al_PosIni";"al_Largo";"al_PosFinal";"al_formato";"al_Alineado";"al_Relleno")
$line:=AL_GetLine (xALP_ExportBankFilesF)
If ($line>0)
	If (al_NumeroFo{$line}#Size of array:C274(al_NumeroFo))
		CD_Dlog (1;__ ("Sólo puede eliminar la última fila"))
	Else 
		If (($line>=1) & (al_NumeroFo{$line}=Size of array:C274(al_NumeroFo)))
			AL_GetSort (xALP_ExportBankFilesF;$c1)
			AL_UpdateArrays (xALP_ExportBankFilesF;0)
			  //AT_Delete ($line;1;->al_Numero;->at_Descripcion;->al_PosIni;->al_Largo;->al_PosFinal;->at_formato;->at_Alineado;->at_Relleno;->al_Decimales;->at_TextoFijo)
			AT_Delete ($line;1;->al_NumeroFo;->at_DescripcionFo;->al_PosIniFo;->al_LargoFo;->al_PosFinalFo;->at_formatoFo;->at_AlineadoFo;->at_RellenoFo;->at_TextoFijoFo)
			AL_UpdateArrays (xALP_ExportBankFilesF;-2)
			  //AL_SetSort (xALP_ExportBankFiles;$c1)
			AL_SetLine (xALP_ExportBankFilesF;$line-1)
			$line:=AL_GetLine (xALP_ExportBankFilesF)
			IT_SetButtonState (($line>0);->bDeleteLine)
			
			
			If (($line=0) | ($line=1))
				_O_DISABLE BUTTON:C193(bSubirLineaExp)
			Else 
				_O_ENABLE BUTTON:C192(bSubirLineaExp)
			End if 
			
			If (($line=0) | ($line=Size of array:C274(al_NumeroFo)))
				_O_DISABLE BUTTON:C193(bBajarLineaExp)
			Else 
				_O_ENABLE BUTTON:C192(bBajarLineaExp)
			End if 
		End if 
	End if 
End if 