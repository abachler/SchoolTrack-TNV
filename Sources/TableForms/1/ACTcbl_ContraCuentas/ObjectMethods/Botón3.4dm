If (vrACT_Descuadre#0)
	AL_UpdateArrays (xALP_ContraCuentasCbl;0)
	AT_Insert (1;1;->acampocc1;->acampocc2;->acampocc3;->acampocc4;->acampocc5;->acampocc6;->acampocc7;->acampocc8;->acampocc9;->acampocc10;->acampocc11;->acampocc12;->acampocc13;->acampocc14;->acampocc15;->acampocc16;->acampocc17;->acampocc18;->acampocc19;->acampocc20;->acampocc21;->acampocc22;->acampocc23;->acampocc24;->acampocc25;->acampocc26;->acampocc27;->acampocc28;->acampocc29;->acampocc30;->acampocc31;->acampocc32;->acampocc33;->acampocc34;->acampocc35;->acampocc36;->acampocc37;->acampocc38;->acampocc39)
	AT_Insert (1;1;->aCCID)
	aCCID{1}:=vlNextCCID
	vlNextCCID:=vlNextCCID+1
	acampocc1{1}:=""
	If (vrACT_Descuadre>0)
		acampocc2{1}:=0
		acampocc3{1}:=Abs:C99(vrACT_Descuadre)
	Else 
		acampocc2{1}:=Abs:C99(vrACT_Descuadre)
		acampocc3{1}:=0
	End if 
	AL_UpdateArrays (xALP_ContraCuentasCbl;-2)
	GOTO OBJECT:C206(xALP_ContraCuentasCbl)
	AL_GotoCell (xALP_ContraCuentasCbl;1;1)
End if 
ACTwiz_CuentasCblFooters 