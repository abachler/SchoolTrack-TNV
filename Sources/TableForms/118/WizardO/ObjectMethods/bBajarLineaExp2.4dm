$line:=AL_GetLine (xALP_ExportBankFilesF)
If ($line>0)
	
	$PosInicial:=al_PosIniFo{$line}
	$lineaInicial:=$line
	AL_UpdateArrays (xALP_ExportBankFilesF;0)
	
	$temp2:=at_DescripcionFo{$line}
	$temp4:=al_LargoFo{$line}
	$temp6:=at_formatoFo{$line}
	$temp7:=at_AlineadoFo{$line}
	$temp8:=at_RellenoFo{$line}
	$temp10:=at_TextoFijoFo{$line}
	
	at_DescripcionFo{$line}:=at_DescripcionFo{$line+1}
	al_LargoFo{$line}:=al_LargoFo{$line+1}
	at_formatoFo{$line}:=at_formatoFo{$line+1}
	at_AlineadoFo{$line}:=at_AlineadoFo{$line+1}
	at_RellenoFo{$line}:=at_RellenoFo{$line+1}
	at_TextoFijoFo{$line}:=at_TextoFijoFo{$line+1}
	
	at_DescripcionFo{$line+1}:=$temp2
	al_LargoFo{$line+1}:=$temp4
	at_formatoFo{$line+1}:=$temp6
	at_AlineadoFo{$line+1}:=$temp7
	at_RellenoFo{$line+1}:=$temp8
	at_TextoFijoFo{$line+1}:=$temp10
	
	
	If ((($line+1)>=1) & (Size of array:C274(al_NumeroFo)>1))  //para recorrer los arreglos y modificar la posición inicial y final. El largo se mantiene
		For ($i;1;((Size of array:C274(al_NumeroFo)-$line)+1))
			If ($i=1)
				al_PosIniFo{$line}:=$PosInicial
				al_PosFinalFo{($line)}:=(al_PosIniFo{($line)}+al_LargoFo{($line)})-1
				$line:=$line+1
			Else 
				al_PosIniFo{($line)}:=al_PosFinalFo{($line-1)}+1
				al_PosFinalFo{($line)}:=(al_PosIniFo{($line)}+al_LargoFo{($line)})-1
				$line:=$line+1
			End if 
		End for 
	End if 
	
	
	AL_UpdateArrays (xALP_ExportBankFilesF;-2)
	
	AL_SetLine (xALP_ExportBankFilesF;$lineaInicial+1)
	$line:=AL_GetLine (xALP_ExportBankFilesF)
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
