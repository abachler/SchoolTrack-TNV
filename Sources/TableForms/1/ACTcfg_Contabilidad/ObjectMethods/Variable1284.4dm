$line:=AL_GetLine (xALP_Cuentas)
If ($line#0)
	$vt_ok:=ACTcfg_OpcionesContabilidad ("ValidaELiminacionCtaContable";-><>alACT_idCta{$line})
	If ($vt_ok="1")
		$r:=CD_Dlog (0;__ ("Los items de cargo o formas de pago que tengan asignada esta cuenta la conservarán. ¿Desea eliminarla?");__ ("");__ ("No");__ ("Si"))
		If ($r=2)
			AL_UpdateArrays (xALP_Cuentas;0)
			  //AT_Delete ($line;1;-><>asACT_GlosaCta;-><>asACT_CuentaCta;-><>asACT_CodAuxCta)
			ACTcfg_OpcionesContabilidad ("EliminaArreglosCuentasContables";-><>alACT_idCta{$line})
			AL_UpdateArrays (xALP_Cuentas;-2)
			AL_SetEnterable (xALP_CtasEspeciales;2;2;<>asACT_CuentaCta)
			IT_SetButtonState ((Size of array:C274(<>asACT_GlosaCta)>0);Self:C308)
		End if 
	Else 
		CD_Dlog (0;__ ("La cuenta contable que intenta eliminar está actualmente asignada a un centro de costo o a una cuenta especial o a una forma de pago o a un estado de forma de pago. No es posible eliminar la cuenta contable seleccionada."))
	End if 
End if 