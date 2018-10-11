
alProEvt:=AL_GetLine (xALP_ExportBankFilesF)
If (alProEvt>=0)
	AL_UpdateArrays (xALP_ExportBankFilesF;0)
	  //AT_Insert (0;1;->al_Numero;->at_Descripcion;->al_PosIni;->al_Largo;->al_PosFinal;->at_formato;->at_Alineado;->at_Relleno;->al_Decimales;->at_TextoFijo)
	AT_Insert (0;1;->al_NumeroFo;->at_DescripcionFo;->al_PosIniFo;->al_LargoFo;->al_PosFinalFo;->at_formatoFo;->at_AlineadoFo;->at_RellenoFo;->at_TextoFijoFo)
	al_NumeroFo{Size of array:C274(al_NumeroFo)}:=Size of array:C274(al_NumeroFo)
	al_LargoFo{Size of array:C274(al_LargoFo)}:=1
	If (Size of array:C274(al_PosIniFo)=1)
		al_PosIniFo{Size of array:C274(al_PosIniFo)}:=1
	Else 
		If (Size of array:C274(al_PosIniFo)>1)
			al_PosIniFo{Size of array:C274(al_PosIniFo)}:=al_PosFinalFo{Size of array:C274(al_PosFinalFo)-1}+1
		End if 
	End if 
	  //al_PosFinal{Size of array(al_PosFinal)}:=al_PosIni{Size of array(al_PosIni)}+al_Largo{Size of array(al_Largo)}
	al_PosFinalFo{Size of array:C274(al_PosFinalFo)}:=al_PosIniFo{Size of array:C274(al_PosIniFo)}
	AL_UpdateArrays (xALP_ExportBankFilesF;-2)
	AL_SetLine (xALP_ExportBankFilesF;1)
	alProEvt:=AL_GetLine (xALP_ExportBankFilesF)
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
	
	If ((alProEvt=0) | (alProEvt=Size of array:C274(al_NumeroFo)))
		_O_DISABLE BUTTON:C193(bBajarLineaExp)
	Else 
		_O_ENABLE BUTTON:C192(bBajarLineaExp)
	End if 
	
End if 