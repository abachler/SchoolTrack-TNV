$line:=AL_GetLine (xALP_ExportBankFilesH)
If ($line>0)
	
	$PosInicial:=al_PosIniHe{$line-1}
	$lineaInicial:=$line
	AL_UpdateArrays (xALP_ExportBankFilesH;0)
	
	$temp2:=at_DescripcionHe{$line}
	$temp4:=al_LargoHe{$line}
	$temp6:=at_formatoHe{$line}
	$temp7:=at_AlineadoHe{$line}
	$temp8:=at_RellenoHe{$line}
	$temp10:=at_TextoFijoHe{$line}
	
	at_DescripcionHe{$line}:=at_DescripcionHe{$line-1}
	al_LargoHe{$line}:=al_LargoHe{$line-1}
	at_formatoHe{$line}:=at_formatoHe{$line-1}
	at_AlineadoHe{$line}:=at_AlineadoHe{$line-1}
	at_RellenoHe{$line}:=at_RellenoHe{$line-1}
	at_TextoFijoHe{$line}:=at_TextoFijoHe{$line-1}
	
	
	at_DescripcionHe{$line-1}:=$temp2
	al_LargoHe{$line-1}:=$temp4
	at_formatoHe{$line-1}:=$temp6
	at_AlineadoHe{$line-1}:=$temp7
	at_RellenoHe{$line-1}:=$temp8
	at_TextoFijoHe{$line-1}:=$temp10
	
	
	If ((($line-1)>=1) & (Size of array:C274(al_NumeroHe)>1))  //para recorrer los arreglos y modificar la posición inicial y final. El largo se mantiene
		For ($i;1;((Size of array:C274(al_NumeroHe)-($line-1))+1))
			  //al_PosIni{($line-1)}:=al_PosFinal{($line-1)}-1
			If ($i=1)
				al_PosIniHe{$line-1}:=$PosInicial
				al_PosFinalHe{($line-1)}:=(al_PosIniHe{($line-1)}+al_LargoHe{($line-1)})-1
				$line:=$line+1
			Else 
				al_PosIniHe{($line-1)}:=al_PosFinalHe{($line-2)}+1
				al_PosFinalHe{($line-1)}:=(al_PosIniHe{($line-1)}+al_LargoHe{($line-1)})-1
				$line:=$line+1
			End if 
		End for 
	End if 
	
	
	AL_UpdateArrays (xALP_ExportBankFilesH;-2)
	
	AL_SetLine (xALP_ExportBankFilesH;$lineaInicial-1)
	$line:=AL_GetLine (xALP_ExportBankFilesH)
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