Case of 
	: ((alProEvt=1) | (alProEvt=2))
		$line:=AL_GetLine (ALP_AvisosXPagar)
		vl_lineaAviso:=$line
		$col:=AL_GetColumn (ALP_AvisosXPagar)
		If (($line=0) | ($line=1))
			_O_DISABLE BUTTON:C193(bSubir)
		Else 
			_O_ENABLE BUTTON:C192(bSubir)
		End if 
		
		If (($line=0) | ($line=Size of array:C274(alACT_AIDAviso)))
			_O_DISABLE BUTTON:C193(bBajar)
		Else 
			_O_ENABLE BUTTON:C192(bBajar)
		End if 
		If ($line#0)
			LOAD RECORD:C52([ACT_CuentasCorrientes:175])
			AL_UpdateArrays (ALP_CargosXPagar;0)
			ACTpgs_LoadCargosAviso 
			AL_SetLine (ALP_CargosXPagar;0)
			If ($col=1)
				If ($line#0)
					If (abACT_ASelectedAvisos{$line})
						abACT_ASelectedAvisos{$line}:=False:C215
						GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_ASelectedAvisos{$line})
					Else 
						abACT_ASelectedAvisos{$line}:=True:C214
						GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_ASelectedAvisos{$line})
					End if 
					AL_UpdateArrays (ALP_AvisosXPagar;-1)
				End if 
				modCargos:=True:C214
			End if 
		Else 
			AL_UpdateArrays (ALP_CargosXPagar;0)
		End if 
		IT_SetButtonState (False:C215;->bSubirC;->bBajarC;->bDelCargos)
	: (alProEvt=5)
		AL_UpdateArrays (ALP_CargosXPagar;0)
		AL_SetLine (ALP_CargosXPagar;0)
		$line:=AL_GetLine (ALP_AvisosXPagar)
		If (abACT_ASelectedAvisos{$line})
			$text:="No pagar"
		Else 
			$text:="Pagar"
		End if 
		$text:=$text+";(-;No Pagar Todos;Pagar Todos"
		$choice:=Pop up menu:C542($text)
		Case of 
			: ($choice=1)
				If (abACT_ASelectedAvisos{$line})
					abACT_ASelectedAvisos{$line}:=False:C215
					GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_ASelectedAvisos{$line})
				Else 
					abACT_ASelectedAvisos{$line}:=True:C214
					GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_ASelectedAvisos{$line})
				End if 
				AL_UpdateArrays (ALP_AvisosXPagar;-1)
				modCargos:=True:C214
			: ($choice=3)
				For ($i;1;Size of array:C274(abACT_ASelectedAvisos))
					abACT_ASelectedAvisos{$i}:=False:C215
					GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_ASelectedAvisos{$i})
				End for 
				AL_UpdateArrays (ALP_AvisosXPagar;-1)
				modCargos:=True:C214
			: ($choice=4)
				For ($i;1;Size of array:C274(abACT_ASelectedAvisos))
					abACT_ASelectedAvisos{$i}:=True:C214
					GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_ASelectedAvisos{$i})
				End for 
				AL_UpdateArrays (ALP_AvisosXPagar;-1)
				modCargos:=True:C214
		End case 
	: (alProEvt=6)
		$text:="No Pagar Todos;Pagar Todos"
		$choice:=Pop up menu:C542($text)
		Case of 
			: ($choice=1)
				For ($i;1;Size of array:C274(abACT_ASelectedAvisos))
					abACT_ASelectedAvisos{$i}:=False:C215
					GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_ASelectedAvisos{$i})
				End for 
				AL_UpdateArrays (ALP_AvisosXPagar;-1)
				modCargos:=True:C214
			: ($choice=2)
				For ($i;1;Size of array:C274(abACT_ASelectedAvisos))
					abACT_ASelectedAvisos{$i}:=True:C214
					GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_ASelectedAvisos{$i})
				End for 
				AL_UpdateArrays (ALP_AvisosXPagar;-1)
				modCargos:=True:C214
		End case 
End case 
$line:=AL_GetLine (ALP_AvisosXPagar)
If ($line>0)
	ACTpgs_LoadCargosAviso 
End if 