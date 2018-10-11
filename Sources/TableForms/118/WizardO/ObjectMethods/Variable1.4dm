
alProEvt:=AL_GetLine (xALP_ExportBankFilesH)
If (alProEvt>=0)
	AL_UpdateArrays (xALP_ExportBankFilesH;0)
	  //AT_Insert (0;1;->al_Numero;->at_DescripcionHe;->al_PosIni;->al_Largo;->al_PosFinal;->at_formato;->at_AlineadoHe;->at_Relleno;->al_Decimales;->at_TextoFijo)
	AT_Insert (0;1;->al_NumeroHe;->at_DescripcionHe;->al_PosIniHe;->al_LargoHe;->al_PosFinalHe;->at_formatoHe;->at_AlineadoHe;->at_RellenoHe;->at_TextoFijoHe)
	al_NumeroHe{Size of array:C274(al_NumeroHe)}:=Size of array:C274(al_NumeroHe)
	al_LargoHe{Size of array:C274(al_LargoHe)}:=1
	If (Size of array:C274(al_PosIniHe)=1)
		al_PosIniHe{Size of array:C274(al_PosIniHe)}:=1
	Else 
		If (Size of array:C274(al_PosIniHe)>1)
			al_PosIniHe{Size of array:C274(al_PosIniHe)}:=al_PosFinalHe{Size of array:C274(al_PosFinalHe)-1}+1
		End if 
	End if 
	  //al_PosFinalHe{Size of array(al_PosFinalHe)}:=al_PosIniHe{Size of array(al_PosIniHe)}+al_LargoHe{Size of array(al_LargoHe)}
	al_PosFinalHe{Size of array:C274(al_PosFinalHe)}:=al_PosIniHe{Size of array:C274(al_PosIniHe)}
	AL_UpdateArrays (xALP_ExportBankFilesH;-2)
	AL_SetLine (xALP_ExportBankFilesH;1)
	alProEvt:=AL_GetLine (xALP_ExportBankFilesH)
	If (alProEvt=0)
		_O_DISABLE BUTTON:C193(bDeleteLine)
	Else 
		_O_ENABLE BUTTON:C192(bDeleteLine)
	End if 
	
	If ((alProEvt=0) | (alProEvt=1))
		_O_DISABLE BUTTON:C193(bSubirLineaExp)
	Else 
		_O_ENABLE BUTTON:C192(bSubirLineaExp)
	End if 
	
	If ((alProEvt=0) | (alProEvt=Size of array:C274(al_NumeroHe)))
		_O_DISABLE BUTTON:C193(bBajarLineaExp)
	Else 
		_O_ENABLE BUTTON:C192(bBajarLineaExp)
	End if 
	
End if 