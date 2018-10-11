Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		$err:=ALP_DefaultColSettings (xALP_MARCInput;1;"atBBL_MARCCode";__ ("Código\rMARC");70)
		$err:=ALP_DefaultColSettings (xALP_MARCInput;2;"atBBL_SubFieldCode";__ ("Código\rSubcampo");70)
		$err:=ALP_DefaultColSettings (xALP_MARCInput;3;"atBBL_SubFieldName";__ ("Nombre\rSubcampo");200)
		$err:=ALP_DefaultColSettings (xALP_MARCInput;4;"atBBL_MARCValue";__ ("Valor");200;"";0;0;1)
		$err:=ALP_DefaultColSettings (xALP_MARCInput;5;"alBBL_MarcValueRecNum")
		$err:=ALP_DefaultColSettings (xALP_MARCInput;6;"abBBL_EquivPrincipal")
		
		ALP_SetDefaultAppareance (xALP_MARCInput;9;3;6;2;8)
		AL_SetColOpts (xALP_MARCInput;1;1;1;2;0)
		AL_SetRowOpts (xALP_MARCInput;0;0;0;0;1;0)
		AL_SetCellOpts (xALP_MARCInput;0;1;1)
		AL_SetMainCalls (xALP_MARCInput;"";"")
		AL_SetCallbacks (xALP_MARCInput;"";"")
		AL_SetScroll (xALP_MARCInput;0;0)
		AL_SetEntryOpts (xALP_MARCInput;3;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
		AL_SetDrgOpts (xALP_MARCInput;0;30;0)
		
		AL_SetLine (xALP_MARCInput;0)
		_O_DISABLE BUTTON:C193(bDelMARC)
		
		ARRAY LONGINT:C221($aLong;2;0)
		For ($i;1;Size of array:C274(abBBL_EquivPrincipal))
			If (abBBL_EquivPrincipal{$i})
				  //AL_SetCellEnter (xALP_MARCInput;4;$i;0;0;$aLong;0)
				AL_SetRowStyle (xALP_MARCInput;$i;Bold:K14:2)
			Else 
				AL_SetCellEnter (xALP_MARCInput;4;$i;0;0;$aLong;1)
				  //AL_SetRowStyle (xALP_MARCInput;$i;Plain )
			End if 
		End for 
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Outside Call:K2:11)
		
End case 