Case of 
	: (alProEvt=-2)
		ARRAY INTEGER:C220($aselected;0)
		$err:=AL_GetSelect (Self:C308->;$aselected)
		ACTwiz_CuentasCblFootersTrf 
	: (alProEvt=1)
		ARRAY INTEGER:C220($aselected;0)
		$err:=AL_GetSelect (Self:C308->;$aselected)
		ACTwiz_CuentasCblFootersTrf 
		IT_SetButtonState ((Size of array:C274($aselected)>0);->bDelLinea)
		AL_SetLine (xALP_ContraCuentasCbl;0)
	: (alProEvt=2)
		C_LONGINT:C283($centroCostos;$planCuenta;$codAuxCta;$glosaCta)
		C_POINTER:C301($ptr)
		$centroCostos:=Find in array:C230(at_Descripcion;"Código centro de costos")
		$planCuenta:=Find in array:C230(at_Descripcion;"Código Plan de Cuentas")
		$codAuxCta:=Find in array:C230(at_Descripcion;"Código Auxiliar")
		$glosaCta:=Find in array:C230(at_Descripcion;"Descripción de Movimiento")
		
		$col:=AL_GetColumn (Self:C308->)
		$row:=AL_GetLine (Self:C308->)
		Case of 
			: ($col=$planCuenta)
				ARRAY POINTER:C280(<>aChoicePtrs;0)
				ARRAY POINTER:C280(<>aChoicePtrs;3)
				<>aChoicePtrs{1}:=-><>asACT_CuentaCta
				<>aChoicePtrs{2}:=-><>asACT_CodAuxCta
				<>aChoicePtrs{3}:=-><>asACT_GlosaCta
				TBL_ShowChoiceList (0;"Seleccione la Cuenta";2)
				If (ok=1)
					If ($planCuenta>0)
						$ptr:=Get pointer:C304("at_contabilidadTrf"+String:C10($planCuenta))
						$ptr->{$row}:=<>asACT_CuentaCta{choiceidx}
					End if 
					If ($glosaCta>0)
						$ptr:=Get pointer:C304("at_contabilidadTrf"+String:C10($glosaCta))
						$ptr->{$row}:=<>asACT_GlosaCta{choiceidx}
					End if 
					If ($codAuxCta>0)
						$ptr:=Get pointer:C304("at_contabilidadTrf"+String:C10($codAuxCta))
						$ptr->{$row}:=<>asACT_CodAuxCta{choiceidx}
					End if 
					acampo1{$row}:=<>asACT_CuentaCta{choiceidx}
					acampo4{$row}:=<>asACT_GlosaCta{choiceidx}
					acampo19{$row}:=<>asACT_CodAuxCta{choiceidx}
				End if 
			: ($col=$centroCostos)
				ARRAY POINTER:C280(<>aChoicePtrs;0)
				ARRAY POINTER:C280(<>aChoicePtrs;1)
				<>aChoicePtrs{1}:=-><>asACT_Centro
				TBL_ShowChoiceList (0;"Seleccione el Centro de Costos";1)
				If (ok=1)
					If ($centroCostos>0)
						$ptr:=Get pointer:C304("at_contabilidadTrf"+String:C10($centroCostos))
						$ptr->{$row}:=<>asACT_Centro{choiceidx}
					End if 
					acampo16{$row}:=<>asACT_Centro{choiceidx}
				End if 
		End case 
		ARRAY INTEGER:C220($aselected;0)
		$err:=AL_GetSelect (Self:C308->;$aselected)
		ACTwiz_CuentasCblFootersTrf 
		IT_SetButtonState ((Size of array:C274($aselected)>0);->bDelLinea)
		AL_SetLine (xALP_ContraCuentasCbl;0)
End case 
