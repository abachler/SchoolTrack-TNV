ARRAY INTEGER:C220($aInteger2D;2;0)
$line:=AL_GetLine (xALP_ContraCuentasCbl)
If ($line#0)
	aenccuenta{0}:=aCCID{$line}
	ARRAY LONGINT:C221($DA_Return;0)
	AT_SearchArray (->aenccuenta;"=";->$DA_Return)
	For ($i;1;Size of array:C274($DA_Return))
		aenccuenta{$DA_Return{$i}}:=0
		AL_SetRowColor (xALP_CuentasCbl;$DA_Return{$i};"Black";0)
		AL_SetRowStyle (xALP_CuentasCbl;$DA_Return{$i};0)
		AL_SetCellEnter (xALP_CuentasCbl;1;$DA_Return{$i};39;$DA_Return{$i};$aInteger2D;1)
	End for 
	AL_UpdateArrays (xALP_CuentasCbl;-1)
	AT_Initialize (->DA_Return)
	AL_UpdateArrays (xALP_ContraCuentasCbl;0)
	AT_Delete ($line;1;->acampocc1;->acampocc2;->acampocc3;->acampocc4;->acampocc5;->acampocc6;->acampocc7;->acampocc8;->acampocc9;->acampocc10;->acampocc11;->acampocc12;->acampocc13;->acampocc14;->acampocc15;->acampocc16;->acampocc17;->acampocc18;->acampocc19;->acampocc20;->acampocc21;->acampocc22;->acampocc23;->acampocc24;->acampocc25;->acampocc26;->acampocc27;->acampocc28;->acampocc29;->acampocc30;->acampocc31;->acampocc32;->acampocc33;->acampocc34;->acampocc35;->acampocc36;->acampocc37;->acampocc38;->acampocc39;->aCCID)
	AL_UpdateArrays (xALP_ContraCuentasCbl;-2)
	ARRAY INTEGER:C220($select;0)
	AL_SetSelect (xALP_CuentasCbl;$select)
	AL_SetLine (xALP_ContraCuentasCbl;0)
	IT_SetButtonState (False:C215;->bClearCCCbl)
End if 
ACTwiz_CuentasCblFooters 