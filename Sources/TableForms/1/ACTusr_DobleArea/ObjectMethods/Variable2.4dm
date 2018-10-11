ARRAY INTEGER:C220($aselected;0)
C_POINTER:C301($ptr)
$err:=AL_GetSelect (xALP_CuentasCbl;$aselected)
If (Size of array:C274($aselected)>0)
	AL_UpdateArrays (xALP_CuentasCbl;0)
	For ($i;1;Size of array:C274($aselected))
		If (aenccuenta{$aselected{$i}}#0)
			$line:=Find in array:C230(aCCID;aenccuenta{$aselected{$i}})
			If ($line#-1)
				$el:=Find in array:C230(at_Descripcion;"Monto al haber moneda Base")
				If ($el>0)
					$ptr:=Get pointer:C304("at_contabilidadTrfCC"+String:C10($el))
					$ptr->{$line}:=String:C10(acampocc3{$line}-acampo2{$aselected{$i}};"|Despliegue_ACT")
				End if 
				$el:=Find in array:C230(at_Descripcion;"Monto al debe moneda Base")
				If ($el>0)
					$ptr:=Get pointer:C304("at_contabilidadTrfCC"+String:C10($el))
					$ptr->{$line}:=String:C10(acampocc2{$line}-acampo3{$aselected{$i}};"|Despliegue_ACT")
				End if 
				acampocc2{$line}:=acampocc2{$line}-acampo3{$aselected{$i}}
				acampocc3{$line}:=acampocc3{$line}-acampo2{$aselected{$i}}
			End if 
			If ((acampocc2{$line}=0) & (acampocc3{$line}=0))
				AL_UpdateArrays (xALP_ContraCuentasCbl;0)
				AT_Delete ($line;1;->acampocc1;->acampocc2;->acampocc3;->acampocc4;->acampocc5;->acampocc6;->acampocc7;->acampocc8;->acampocc9;->acampocc10;->acampocc11;->acampocc12;->acampocc13;->acampocc14;->acampocc15;->acampocc16;->acampocc17;->acampocc18;->acampocc19;->acampocc20;->acampocc21;->acampocc22;->acampocc23;->acampocc24;->acampocc25;->acampocc26;->acampocc27;->acampocc28;->acampocc29;->acampocc30;->acampocc31;->acampocc32;->acampocc33;->acampocc34;->acampocc35;->acampocc36;->acampocc37;->acampocc38;->acampocc39;->aCCID)
				For ($r;1;Size of array:C274(al_Numero))
					$ptr:=Get pointer:C304("at_contabilidadTrfCC"+String:C10($r))
					AT_Delete ($line;1;$ptr)
				End for 
				AL_UpdateArrays (xALP_ContraCuentasCbl;-2)
			End if 
		End if 
	End for 
	ARRAY LONGINT:C221($aIDs2Delete;Size of array:C274($aselected))
	For ($i;1;Size of array:C274($aIDs2Delete))
		$aIDs2Delete{$i}:=aID{$aselected{$i}}
	End for 
	For ($i;1;Size of array:C274($aIDs2Delete))
		$line2Delete:=Find in array:C230(aID;$aIDs2Delete{$i})
		If ($line2Delete#-1)
			AT_Delete ($line2Delete;1;->acampo1;->acampo2;->acampo3;->acampo4;->acampo5;->acampo6;->acampo7;->acampo8;->acampo9;->acampo10;->acampo11;->acampo12;->acampo13;->acampo14;->acampo15;->acampo16;->acampo17;->acampo18;->acampo19;->acampo20;->acampo21;->acampo22;->acampo23;->acampo24;->acampo25;->acampo26;->acampo27;->acampo28;->acampo29;->acampo30;->acampo31;->acampo32;->acampo33;->acampo34;->acampo35;->acampo36;->acampo37;->acampo38;->acampo39;->aenccuenta;->aID)
			For ($r;1;Size of array:C274(al_Numero))
				$ptr:=Get pointer:C304("at_contabilidadTrf"+String:C10($r))
				AT_Delete ($line2Delete;1;$ptr)
			End for 
		End if 
	End for 
	AL_UpdateArrays (xALP_CuentasCbl;-2)
	ARRAY INTEGER:C220($aselected;0)
	AL_SetSelect (xALP_CuentasCbl;$aselected)
	ACTwiz_CuentasCblFootersTrf 
End if 