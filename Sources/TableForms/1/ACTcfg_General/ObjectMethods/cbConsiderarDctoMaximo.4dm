If ((Self:C308->>100) | (Self:C308-><0))
	BEEP:C151
	Self:C308->:=0
Else 
	If (vb_muestraMensaje)
		CD_Dlog (0;__ ("La modificación en la configuración será tomada en cuenta en la próxima emisión y/o generación"))
		vb_muestraMensaje:=False:C215
	End if 
	
	ARRAY LONGINT:C221($alACT_idCta;0)
	ARRAY LONGINT:C221($alACT_idCta2;0)
	ARRAY REAL:C219($arACT_Pct;0)
	
	READ ONLY:C145([ACT_DctosIndividuales_Cuentas:228])
	ALL RECORDS:C47([ACT_DctosIndividuales_Cuentas:228])
	SELECTION TO ARRAY:C260([ACT_DctosIndividuales_Cuentas:228]ID_CuentaCorriente:6;$alACT_idCta;[ACT_DctosIndividuales_Cuentas:228]Porcentaje:7;$arACT_Pct)
	
	COPY ARRAY:C226($alACT_idCta;$alACT_idCta2)
	AT_DistinctsArrayValues (->$alACT_idCta2)
	$vl_dctoMax:=0
	For ($l_indice;1;Size of array:C274($alACT_idCta2))
		$r_suma:=AT_GetSumArrayByArrayPos (->$alACT_idCta2{$l_indice};"=";->$alACT_idCta;->$arACT_Pct)
		If ($r_suma>Self:C308->)
			$vl_dctoMax:=$vl_dctoMax+1
		End if 
	End for 
	  //SET QUERY DESTINATION(Into variable;$vl_dctoMax)
	  //QUERY([ACT_CuentasCorrientes];[ACT_CuentasCorrientes]Descuento>Self->)
	  //SET QUERY DESTINATION(Into current selection)
	If ($vl_dctoMax>0)
		CD_Dlog (0;__ ("Hay ")+String:C10($vl_dctoMax)+__ (" cuenta(s) corriente(s) que tiene(n) descuento(s) por cuenta superior(es) a ")+String:C10(Self:C308->)+__ ("%."))
	End if 
End if 