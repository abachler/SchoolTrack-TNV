If ((PWTrf_Pac1=1) & (Size of array:C274(al_Numero)=39))
	CD_Dlog (0;__ ("El límite de columnas es 39. No es posible insertar una nueva línea"))
Else 
	alProEvt:=AL_GetLine (xALP_ExportBankFiles)
	AL_UpdateArrays (xALP_ExportBankFiles;0)
	If (alProEvt>=0)
		If (PWTrf_Ptb1=1)
			AT_Insert (0;1;->al_Numero;->at_Descripcion;->al_PosIni;->al_Largo;->al_PosFinal;->at_formato;->at_Alineado;->at_Relleno;->at_TextoFijo)
		Else 
			AT_Insert (0;1;->al_Numero;->at_Descripcion;->al_PosIni;->al_Largo;->al_PosFinal;->at_formato;->at_Alineado;->at_Relleno;->at_TextoFijo;->at_HeaderAC)
		End if 
		al_Numero{Size of array:C274(al_Numero)}:=Size of array:C274(al_Numero)
		al_Largo{Size of array:C274(al_Largo)}:=1
		If (Size of array:C274(al_PosIni)=1)
			al_PosIni{Size of array:C274(al_PosIni)}:=1
		Else 
			If (Size of array:C274(al_PosIni)>1)
				al_PosIni{Size of array:C274(al_PosIni)}:=al_PosFinal{Size of array:C274(al_PosFinal)-1}+1
			End if 
		End if 
		al_PosFinal{Size of array:C274(al_PosFinal)}:=al_PosIni{Size of array:C274(al_PosIni)}
		  //Else 
		  //AT_Insert (0;1;->al_Numero;->at_Descripcion;->al_PosIni;->al_Largo;->al_PosFinal;->at_formato;->at_Alineado;->at_Relleno;->at_TextoFijo;->at_HeaderAC)
		  //al_Numero{Size of array(al_Numero)}:=Size of array(al_Numero)
		  //al_Largo{Size of array(al_Largo)}:=1
		  //If (Size of array(al_PosIni)=1)
		  //al_PosIni{Size of array(al_PosIni)}:=1
		  //Else 
		  //If (Size of array(al_PosIni)>1)
		  //al_PosIni{Size of array(al_PosIni)}:=al_PosFinal{Size of array(al_PosFinal)-1}+1
		  //End if 
		  //End if 
		  //al_PosFinal{Size of array(al_PosFinal)}:=al_PosIni{Size of array(al_PosIni)}
		  //End if 
		AL_UpdateArrays (xALP_ExportBankFiles;-2)
		AL_SetLine (xALP_ExportBankFiles;1)
		alProEvt:=AL_GetLine (xALP_ExportBankFiles)
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
		
		If ((alProEvt=0) | (alProEvt=Size of array:C274(al_Numero)))
			_O_DISABLE BUTTON:C193(bBajarLineaExp)
		Else 
			_O_ENABLE BUTTON:C192(bBajarLineaExp)
		End if 
	End if 
End if 