$line:=AL_GetLine (xALP_ExportBankFiles)
If ($line>0)
	
	$PosInicial:=al_PosIni{$line}
	$lineaInicial:=$line
	AL_UpdateArrays (xALP_ExportBankFiles;0)
	
	  //$temp1:=al_Numero{$line}
	$temp2:=at_Descripcion{$line}
	  //$temp3:=al_PosIni{$line}
	$temp4:=al_Largo{$line}
	  //$temp5:=al_PosFinal{$line}
	$temp6:=at_formato{$line}
	$temp7:=at_Alineado{$line}
	$temp8:=at_Relleno{$line}
	  //$temp9:=al_Decimales{$line}
	$temp10:=at_TextoFijo{$line}
	
	If (PWTrf_Pac1=1)
		$temp11:=at_HeaderAC{$line}
	End if 
	
	  //al_Numero{$line}:=al_Numero{$line+1}
	at_Descripcion{$line}:=at_Descripcion{$line+1}
	  //al_PosIni{$line}:=al_PosIni{$line+1}
	al_Largo{$line}:=al_Largo{$line+1}
	  //al_PosFinal{$line}:=al_PosFinal{$line+1}
	at_formato{$line}:=at_formato{$line+1}
	at_Alineado{$line}:=at_Alineado{$line+1}
	at_Relleno{$line}:=at_Relleno{$line+1}
	  //al_Decimales{$line}:=al_Decimales{$line+1}
	at_TextoFijo{$line}:=at_TextoFijo{$line+1}
	If (PWTrf_Pac1=1)
		at_HeaderAC{$line}:=at_HeaderAC{$line+1}
	End if 
	  //al_Numero{$line+1}:=$temp1
	at_Descripcion{$line+1}:=$temp2
	  //al_PosIni{$line+1}:=$temp3
	al_Largo{$line+1}:=$temp4
	  //al_PosFinal{$line-1}:=$temp5
	at_formato{$line+1}:=$temp6
	at_Alineado{$line+1}:=$temp7
	at_Relleno{$line+1}:=$temp8
	  //al_Decimales{$line+1}:=$temp9
	at_TextoFijo{$line+1}:=$temp10
	
	If (PWTrf_Pac1=1)
		at_HeaderAC{$line+1}:=$temp11
	End if 
	
	If ((($line+1)>=1) & (Size of array:C274(al_Numero)>1))  //para recorrer los arreglos y modificar la posición inicial y final. El largo se mantiene
		For ($i;1;((Size of array:C274(al_Numero)-$line)+1))
			  //al_PosIni{($line-1)}:=al_PosFinal{($line-1)}-1
			If ($i=1)
				al_PosIni{$line}:=$PosInicial
				al_PosFinal{($line)}:=(al_PosIni{($line)}+al_Largo{($line)})-1
				$line:=$line+1
			Else 
				al_PosIni{($line)}:=al_PosFinal{($line-1)}+1
				al_PosFinal{($line)}:=(al_PosIni{($line)}+al_Largo{($line)})-1
				$line:=$line+1
			End if 
		End for 
	End if 
	
	
	AL_UpdateArrays (xALP_ExportBankFiles;-2)
	
	AL_SetLine (xALP_ExportBankFiles;$lineaInicial+1)
	$line:=AL_GetLine (xALP_ExportBankFiles)
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
