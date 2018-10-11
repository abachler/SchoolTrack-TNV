C_POINTER:C301($ptr)
C_LONGINT:C283($el)
If (vrACT_Descuadre#0)
	AL_UpdateArrays (xALP_ContraCuentasCbl;0)
	AT_Insert (1;1;->acampocc1;->acampocc2;->acampocc3;->acampocc4;->acampocc5;->acampocc6;->acampocc7;->acampocc8;->acampocc9;->acampocc10;->acampocc11;->acampocc12;->acampocc13;->acampocc14;->acampocc15;->acampocc16;->acampocc17;->acampocc18;->acampocc19;->acampocc20;->acampocc21;->acampocc22;->acampocc23;->acampocc24;->acampocc25;->acampocc26;->acampocc27;->acampocc28;->acampocc29;->acampocc30;->acampocc31;->acampocc32;->acampocc33;->acampocc34;->acampocc35;->acampocc36;->acampocc37;->acampocc38;->acampocc39)
	For ($r;1;Size of array:C274(al_Numero))
		$ptr:=Get pointer:C304("at_contabilidadTrfCC"+String:C10($r))
		AT_Insert (1;1;$ptr)
	End for 
	AT_Insert (1;1;->aCCID)
	aCCID{1}:=vlNextCCID
	vlNextCCID:=vlNextCCID+1
	acampocc1{1}:=""
	If (vrACT_Descuadre>0)
		$el:=0
		C_POINTER:C301($ptrTrf1)
		$el:=Find in array:C230(at_Descripcion;"Monto al haber moneda Base")
		If ($el>0)
			$ptrTrf1:=Get pointer:C304("at_contabilidadTrfCC"+String:C10($el))
		End if 
		If (Not:C34(Is nil pointer:C315($ptrTrf1)))
			$ptrTrf1:=Get pointer:C304("at_contabilidadTrfCC"+String:C10($el))
			$ptrTrf1->{1}:=String:C10(Abs:C99(vrACT_Descuadre);"|Despliegue_ACT")
		End if 
		$el:=0
		C_POINTER:C301($ptrTrf2)
		$el:=Find in array:C230(at_Descripcion;"Monto al debe moneda Base")
		If ($el>0)
			$ptrTrf2:=Get pointer:C304("at_contabilidadTrfCC"+String:C10($el))
		End if 
		If (Not:C34(Is nil pointer:C315($ptr)))
			$ptrTrf2:=Get pointer:C304("at_contabilidadTrfCC"+String:C10($el))
			$ptrTrf2->{1}:="0"
		End if 
		acampocc2{1}:=0
		acampocc3{1}:=Abs:C99(vrACT_Descuadre)
	Else 
		$el:=0
		C_POINTER:C301($ptrTrf1)
		$el:=Find in array:C230(at_Descripcion;"Monto al haber moneda Base")
		If ($el>0)
			$ptrTrf1:=Get pointer:C304("at_contabilidadTrfCC"+String:C10($el))
		End if 
		If (Not:C34(Is nil pointer:C315($ptrTrf1)))
			$ptrTrf1:=Get pointer:C304("at_contabilidadTrfCC"+String:C10($el))
			$ptr->{1}:="0"
		End if 
		$el:=0
		C_POINTER:C301($ptrTrf2)
		$el:=Find in array:C230(at_Descripcion;"Monto al debe moneda Base")
		If ($el>0)
			$ptrTrf2:=Get pointer:C304("at_contabilidadTrfCC"+String:C10($el))
		End if 
		If (Not:C34(Is nil pointer:C315($ptrTrf2)))
			$ptrTrf2:=Get pointer:C304("at_contabilidadTrfCC"+String:C10($el))
			$ptrTrf2->{1}:=String:C10(Abs:C99(vrACT_Descuadre);"|Despliegue_ACT")
		End if 
		acampocc2{1}:=Abs:C99(vrACT_Descuadre)
		acampocc3{1}:=0
	End if 
	AL_UpdateArrays (xALP_ContraCuentasCbl;-2)
	GOTO OBJECT:C206(xALP_ContraCuentasCbl)
	AL_GotoCell (xALP_ContraCuentasCbl;1;1)
End if 
ACTwiz_CuentasCblFootersTrf 