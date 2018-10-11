ARRAY INTEGER:C220($aselected;0)
ARRAY INTEGER:C220($aInteger2D;2;0)
C_POINTER:C301($ptr)
C_LONGINT:C283($el)
$err:=AL_GetSelect (xALP_CuentasCbl;$aselected)

$debesel:=0
$habersel:=0
$go:=True:C214
For ($i;1;Size of array:C274($aselected))
	If (aenccuenta{$aselected{$i}}#0)
		$go:=False:C215
		$i:=Size of array:C274($aselected)+1
	End if 
End for 
If ($go)
	For ($i;1;Size of array:C274($aselected))
		  //
		  //$debecc:=AT_GetSumArray (->acampocc2)
		  //$habercc:=AT_GetSumArray (->acampocc3)
		  //  `AL_SetFooters (xALP_ContraCuentasCbl;2;2;String($debecc;"|Despliegue_ACT");String($habercc;"|Despliegue_ACT"))
		  //
		  //$el:=Find in array(at_Descripcion;"Monto al haber moneda Base")
		  //If ($el>0)
		  //AL_SetFooters (xALP_CuentasCbl;$el;1;$footerhaber)
		  //AL_SetFooters (xALP_ContraCuentasCbl;$el;1;String($habercc;"|Despliegue_ACT"))
		  //End if 
		  //$el:=Find in array(at_Descripcion;"Monto al debe moneda Base")
		  //If ($el>0)
		  //AL_SetFooters (xALP_CuentasCbl;$el;1;$footerdebe)
		  //AL_SetFooters (xALP_ContraCuentasCbl;$el;1;String($debecc;"|Despliegue_ACT"))
		  //End if 
		
		$debesel:=$debesel+acampo2{$aselected{$i}}
		$habersel:=$habersel+acampo3{$aselected{$i}}
		aenccuenta{$aselected{$i}}:=vlNextCCID
		AL_SetRowColor (xALP_CuentasCbl;$aselected{$i};"Red";0)
		AL_SetRowStyle (xALP_CuentasCbl;$aselected{$i};2)
		AL_SetCellEnter (xALP_CuentasCbl;1;$aselected{$i};39;$aselected{$i};$aInteger2D;0)
	End for 
	AL_UpdateArrays (xALP_CuentasCbl;-1)
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
	$el:=0
	$el:=Find in array:C230(at_Descripcion;"Monto al haber moneda Base")
	If ($el>0)
		$ptr:=Get pointer:C304("at_contabilidadTrfCC"+String:C10($el))
	End if 
	If ($debesel#0)
		If (Not:C34(Is nil pointer:C315($ptr)))
			$ptr->{1}:=String:C10($debesel;"|Despliegue_ACT")
		End if 
		acampocc3{1}:=$debesel
	Else 
		If (Not:C34(Is nil pointer:C315($ptr)))
			$ptr->{1}:="0"
		End if 
		acampocc3{1}:=0
	End if 
	$el:=0
	$el:=Find in array:C230(at_Descripcion;"Monto al debe moneda Base")
	If ($el>0)
		$ptr:=Get pointer:C304("at_contabilidadTrfCC"+String:C10($el))
	End if 
	If ($habersel#0)
		If (Not:C34(Is nil pointer:C315($ptr)))
			$ptr->{1}:=String:C10($habersel;"|Despliegue_ACT")
		End if 
		acampocc2{1}:=$habersel
	Else 
		If (Not:C34(Is nil pointer:C315($ptr)))
			$ptr->{1}:="0"
		End if 
		acampocc2{1}:=0
	End if 
	ACTwiz_CuentasCblFootersTrf 
	AL_UpdateArrays (xALP_ContraCuentasCbl;-2)
	GOTO OBJECT:C206(xALP_ContraCuentasCbl)
	AL_GotoCell (xALP_ContraCuentasCbl;1;1)
Else 
	CD_Dlog (0;__ ("Una de la líneas seleccionadas ya fue incluida en una contra cuenta."))
End if 