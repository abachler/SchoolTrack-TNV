C_BOOLEAN:C305($vb_restaurar)
C_TEXT:C284($vt_forma)

$line:=AL_GetLine (xALP_EstadosFDP)

  //If (alACT_estadosID{$line}#-16)  // no corre para fdp pagares

$vt_forma:=ACTcfg_OpcionesFormasDePago ("GetFormaDePagoXID";->vlACT_idFormaDePago)

ARRAY TEXT:C222(at_ACT_CuentaCta;0)
ARRAY TEXT:C222(at_ACT_CodAuxCta;0)
ARRAY TEXT:C222(at_ACT_GlosaCta;0)
ARRAY LONGINT:C221(al_ACT_IDCta;0)
ARRAY TEXT:C222(at_ACT_Centro;0)
ARRAY LONGINT:C221(al_ACT_IDCentro;0)
AT_CopyArrayElements (-><>asACT_CuentaCta;->at_ACT_CuentaCta)
AT_CopyArrayElements (-><>asACT_CodAuxCta;->at_ACT_CodAuxCta)
AT_CopyArrayElements (-><>asACT_GlosaCta;->at_ACT_GlosaCta)
AT_CopyArrayElements (-><>asACT_Centro;->at_ACT_Centro)
AT_CopyArrayElements (-><>alACT_idCta;->al_ACT_IDCta)
AT_CopyArrayElements (-><>alACT_idCentro;->al_ACT_IDCentro)
AT_Insert (0;1;->at_ACT_CuentaCta;->at_ACT_CodAuxCta;->al_ACT_IDCta;->al_ACT_IDCentro)
APPEND TO ARRAY:C911(at_ACT_GlosaCta;__ ("NINGUNA"))
APPEND TO ARRAY:C911(at_ACT_Centro;__ ("Ninguno"))

Case of 
	: (alProEvt=1)
		IT_SetButtonState ((($line>0) & (alACT_estadosID{$line}>0));->bDelEFP)
		
	: (alProEvt=2)
		$col:=AL_GetColumn (xALP_EstadosFDP)
		$row:=AL_GetLine (xALP_EstadosFDP)
		IT_SetButtonState ((($row>0) & (alACT_estadosID{$row}>0));->bDelEFP)
		Case of 
			: ($col=3)
				$temp:=atACT_estadosCta{$row}
				$temp2:=alACT_estadosIDCta{$row}
				$temp3:=atACT_estadosCtaCA{$row}
				ARRAY POINTER:C280(<>aChoicePtrs;0)
				ARRAY POINTER:C280(<>aChoicePtrs;4)
				<>aChoicePtrs{1}:=->at_ACT_CuentaCta
				<>aChoicePtrs{2}:=->at_ACT_CodAuxCta
				<>aChoicePtrs{3}:=->at_ACT_GlosaCta
				<>aChoicePtrs{4}:=->al_ACT_IDCta
				TBL_ShowChoiceList (0;__ ("Seleccione la Cuenta");2)
				If (ok=1)
					$index:=Find in array:C230(<>asACT_GlosaCta;at_ACT_GlosaCta{choiceIdx})
					If ($index#-1)
						alACT_estadosIDCta{$row}:=<>alACT_idCta{$index}
						atACT_estadosCta{$row}:=<>asACT_CuentaCta{$index}
						atACT_estadosCtaCA{$row}:=<>asACT_CodAuxCta{$index}
					Else 
						alACT_estadosIDCta{$row}:=0
						atACT_estadosCta{$row}:=""
						atACT_estadosCtaCA{$row}:=""
					End if 
					If ((atACT_estadosCta{$row}#$temp) | (Windows Ctrl down:C562 | Macintosh command down:C546))
						$vb_restaurar:=False:C215
						vtMsg:=__ ("Usted modificó el código de plan de cuentas para este estado de forma de pago.")+"\r"+__ ("Si lo desea puede aplicar el nuevo código a los registros ya creados o bien utilizar este nuevo código sólo para los nuevos registros de ahora en adelante.")
						vtDesc1:=__ ("El código de plan de cuentas es modificado, pero sólo será aplicado a los nuevos registros.")
						vtDesc2:=__ ("Se asigna el nuevo código a los registros ya creados.")
						vtBtn1:=__ ("Sólo para los nuevos registros")
						vtBtn2:=__ ("Aplicar también a los registros ya ingresados")
						WDW_OpenDialogInDrawer (->[xxACT_GlosasExtraordinarias:5];"ACT_DLG_ModGExtras")
						If (ok=1)
							$vl_ok:=Num:C11(ACTcfg_OpcionesEstadosPagos ("GuardaIDContabilidad";->alACT_estadosID{$row};->[ACT_EstadosFormasdePago:201]id_cuenta_contable:5;->alACT_estadosIDCta{$row}))
							If ($vl_ok=1)
								LOG_RegisterEvt ("Cambio de plan de cuenta contable para estado de forma de pago "+$vt_forma+", estado "+atACT_estados{$row}+". Cambió de "+$temp+" a "+atACT_estadosCta{$row}+".")
								If (r2=1)
									vString1:=atACT_estadosCta{$row}
									vString2:=atACT_estadosCtaCA{$row}
									
									READ WRITE:C146([ACT_Pagos:172])
									READ ONLY:C145([ACT_Documentos_de_Pago:176])
									$proc:=IT_UThermometer (1;0;__ ("Actualizando información contable en pagos..."))
									QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]id_forma_de_pago:51=alACT_estadosIDFDP{$row};*)
									QUERY:C277([ACT_Documentos_de_Pago:176]; & ;[ACT_Documentos_de_Pago:176]id_estado:53=alACT_estadosID{$row})
									KRL_RelateSelection (->[ACT_Pagos:172]ID_DocumentodePago:6;->[ACT_Documentos_de_Pago:176]ID:1;"")
									_O_ARRAY STRING:C218(80;asNCta;0)
									_O_ARRAY STRING:C218(80;asNCta;Records in selection:C76([ACT_Pagos:172]))
									_O_ARRAY STRING:C218(80;asCACta;0)
									_O_ARRAY STRING:C218(80;asCACta;Records in selection:C76([ACT_Pagos:172]))
									AT_Populate (->asNCta;->vString1)
									AT_Populate (->asCACta;->vString2)
									ARRAY TO SELECTION:C261(asNCta;[ACT_Pagos:172]No_Cuenta_Contable:16;asCACta;[ACT_Pagos:172]CodAuxCta:22)
									ACTcfg_OpcionesMovimientos ("CambioCtaContableEnConf";->alACT_estadosIDFDP{$row};->alACT_estadosID{$row};->alACT_estadosIDCta{$row};->[ACT_Movimientos_Estados:288]id_cta_contable:8;->[ACT_Movimientos_Estados:288]cuenta_contable:9)
									AT_Initialize (->asNCta;->asCACta)
									KRL_UnloadReadOnly (->[ACT_Pagos:172])
									IT_UThermometer (-2;$proc)
								End if 
							Else 
								$vb_restaurar:=True:C214
							End if 
						Else 
							$vb_restaurar:=True:C214
						End if 
						If ($vb_restaurar)
							alACT_estadosIDCta{$row}:=$temp2
							atACT_estadosCta{$row}:=$temp
							atACT_estadosCtaCA{$row}:=$temp3
						End if 
					End if 
				End if 
			: ($col=5)
				$temp:=atACT_estadosCentro{$row}
				$temp2:=alACT_estadosIDCentro{$row}
				ARRAY POINTER:C280(<>aChoicePtrs;0)
				ARRAY POINTER:C280(<>aChoicePtrs;2)
				<>aChoicePtrs{1}:=->at_ACT_Centro
				<>aChoicePtrs{2}:=->al_ACT_IDCentro
				TBL_ShowChoiceList (1;__ ("Seleccione el Centro de Costos");1)
				If (ok=1)
					$index:=Find in array:C230(<>asACT_Centro;at_ACT_Centro{choiceIdx})
					If ($index#-1)
						atACT_estadosCentro{$row}:=<>asACT_Centro{$index}
						alACT_estadosIDCentro{$row}:=<>alACT_idCentro{$index}
					Else 
						atACT_estadosCentro{$row}:=""
						alACT_estadosIDCentro{$row}:=0
					End if 
					vbACT_ModifiedCol:=True:C214
					If ((atACT_estadosCentro{$row}#$temp) | (Windows Ctrl down:C562 | Macintosh command down:C546))
						$vb_restaurar:=False:C215
						vtMsg:=__ ("Usted modificó el código de centro de costos para este estado de forma de pago.")+"\r"+__ ("Si lo desea puede aplicar el nuevo código a los registros ya ingresados o bien utilizar este nuevo código sólo para los registros que se ingresen de ahora en adelante.")
						vtDesc1:=__ ("El código de centro de costos es modificado, pero sólo será aplicado a los nuevos registros que se ingresen.")
						vtDesc2:=__ ("Se asigna el nuevo código a los registros ya ingresados.")
						vtBtn1:=__ ("Sólo para los nuevos registros")
						vtBtn2:=__ ("Aplicar también a los registros ya ingresados")
						WDW_OpenDialogInDrawer (->[xxACT_GlosasExtraordinarias:5];"ACT_DLG_ModGExtras")
						If (ok=1)
							$vl_ok:=Num:C11(ACTcfg_OpcionesEstadosPagos ("GuardaIDContabilidad";->alACT_estadosID{$row};->[ACT_EstadosFormasdePago:201]id_centro_costo:6;->alACT_estadosIDCentro{$row}))
							If ($vl_ok=1)
								LOG_RegisterEvt ("Cambio de centro de costo para estado de forma de pago "+$vt_forma+", estado "+atACT_estados{$row}+". Cambió de "+$temp+" a "+atACT_estadosCentro{$row}+".")
								If (r2=1)
									vString1:=atACT_estadosCentro{$row}
									
									READ WRITE:C146([ACT_Pagos:172])
									READ ONLY:C145([ACT_Documentos_de_Pago:176])
									$proc:=IT_UThermometer (1;0;__ ("Actualizando información contable en pagos..."))
									QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]id_forma_de_pago:51=alACT_estadosIDFDP{$row};*)
									QUERY:C277([ACT_Documentos_de_Pago:176]; & ;[ACT_Documentos_de_Pago:176]id_estado:53=alACT_estadosID{$row})
									KRL_RelateSelection (->[ACT_Pagos:172]ID_DocumentodePago:6;->[ACT_Documentos_de_Pago:176]ID:1;"")
									_O_ARRAY STRING:C218(80;asNCta;0)
									_O_ARRAY STRING:C218(80;asNCta;Records in selection:C76([ACT_Pagos:172]))
									AT_Populate (->asNCta;->vString1)
									ARRAY TO SELECTION:C261(asNCta;[ACT_Pagos:172]Centro_de_costos:17)
									ACTcfg_OpcionesMovimientos ("CambioCtaContableEnConf";->alACT_estadosIDFDP{$row};->alACT_estadosID{$row};->alACT_estadosIDCentro{$row};->[ACT_Movimientos_Estados:288]id_centro_costo:11)
									AT_Initialize (->asNCta)
									KRL_UnloadReadOnly (->[ACT_Pagos:172])
									IT_UThermometer (-2;$proc)
								End if 
							Else 
								$vb_restaurar:=True:C214
							End if 
						Else 
							$vb_restaurar:=True:C214
						End if 
						If ($vb_restaurar)
							atACT_estadosCentro{$row}:=$temp
							alACT_estadosIDCentro{$row}:=$temp2
						End if 
					End if 
				End if 
			: ($col=6)
				$temp:=atACT_estadosCCta{$row}
				$temp2:=alACT_estadosIDCCta{$row}
				$temp3:=atACT_estadosCCtaCA{$row}
				
				ARRAY POINTER:C280(<>aChoicePtrs;0)
				ARRAY POINTER:C280(<>aChoicePtrs;4)
				<>aChoicePtrs{1}:=->at_ACT_CuentaCta
				<>aChoicePtrs{2}:=->at_ACT_CodAuxCta
				<>aChoicePtrs{3}:=->at_ACT_GlosaCta
				<>aChoicePtrs{4}:=->al_ACT_IDCta
				TBL_ShowChoiceList (0;__ ("Seleccione la Cuenta");2)
				If (ok=1)
					$index:=Find in array:C230(<>asACT_GlosaCta;at_ACT_GlosaCta{choiceIdx})
					If ($index#-1)
						alACT_estadosIDCCta{$row}:=<>alACT_idCta{$index}
						atACT_estadosCCta{$row}:=<>asACT_CuentaCta{$index}
						atACT_estadosCCtaCA{$row}:=<>asACT_CodAuxCta{$index}
					Else 
						alACT_estadosIDCCta{$row}:=0
						atACT_estadosCCta{$row}:=""
						atACT_estadosCCtaCA{$row}:=""
					End if 
					If ((atACT_estadosCCta{$row}#$temp) | (Windows Ctrl down:C562 | Macintosh command down:C546))
						$vb_restaurar:=False:C215
						vtMsg:=__ ("Usted modificó el código de plan de cuentas de contra cuenta para este estado de forma de pago.")+"\r"+__ ("Si lo desea puede aplicar el nuevo código a los registros ya ingresados o bien utilizar este nuevo código sólo para los registros que se ingresen de ahora en adelante.")
						vtDesc1:=__ ("El código de plan de cuentas de contra cuenta es modificado, pero sólo será aplicado a los nuevos registros que se ingresen.")
						vtDesc2:=__ ("Se asigna el nuevo código a los registros ya ingresados.")
						vtBtn1:=__ ("Sólo para los nuevos registros")
						vtBtn2:=__ ("Aplicar también a los registros ya ingresados")
						WDW_OpenDialogInDrawer (->[xxACT_GlosasExtraordinarias:5];"ACT_DLG_ModGExtras")
						If (ok=1)
							$vl_ok:=Num:C11(ACTcfg_OpcionesEstadosPagos ("GuardaIDContabilidad";->alACT_estadosID{$row};->[ACT_EstadosFormasdePago:201]id_cuenta_contable_contra:7;->alACT_estadosIDCCta{$row}))
							If ($vl_ok=1)
								LOG_RegisterEvt ("Cambio de plan de contra cuenta contable para estado de forma de pago "+$vt_forma+", estado "+atACT_estados{$row}+". Cambió de "+$temp+" a "+atACT_estadosCCta{$row}+".")
								If (r2=1)
									vString1:=atACT_estadosCCta{$row}
									vString2:=atACT_estadosCCtaCA{$row}
									
									READ WRITE:C146([ACT_Pagos:172])
									READ ONLY:C145([ACT_Documentos_de_Pago:176])
									$proc:=IT_UThermometer (1;0;__ ("Actualizando información contable en pagos..."))
									QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]id_forma_de_pago:51=alACT_estadosIDFDP{$row};*)
									QUERY:C277([ACT_Documentos_de_Pago:176]; & ;[ACT_Documentos_de_Pago:176]id_estado:53=alACT_estadosID{$row})
									KRL_RelateSelection (->[ACT_Pagos:172]ID_DocumentodePago:6;->[ACT_Documentos_de_Pago:176]ID:1;"")
									_O_ARRAY STRING:C218(80;asNCta;0)
									_O_ARRAY STRING:C218(80;asNCta;Records in selection:C76([ACT_Pagos:172]))
									_O_ARRAY STRING:C218(80;asCACta;0)
									_O_ARRAY STRING:C218(80;asCACta;Records in selection:C76([ACT_Pagos:172]))
									AT_Populate (->asNCta;->vString1)
									AT_Populate (->asCACta;->vString2)
									ARRAY TO SELECTION:C261(asNCta;[ACT_Pagos:172]No_CCta_Contable:19;asCACta;[ACT_Pagos:172]CodAuxCCta:23)
									ACTcfg_OpcionesMovimientos ("CambioCtaContableEnConf";->alACT_estadosIDFDP{$row};->alACT_estadosID{$row};->alACT_estadosIDCCta{$row};->[ACT_Movimientos_Estados:288]id_contra_cuenta_contable:13)
									AT_Initialize (->asNCta;->asCACta)
									KRL_UnloadReadOnly (->[ACT_Pagos:172])
									IT_UThermometer (-2;$proc)
								End if 
							Else 
								$vb_restaurar:=True:C214
							End if 
						Else 
							$vb_restaurar:=True:C214
						End if 
						If ($vb_restaurar)
							alACT_estadosIDCCta{$row}:=$temp2
							atACT_estadosCCta{$row}:=$temp
							atACT_estadosCCtaCA{$row}:=$temp3
						End if 
					End if 
					
				End if 
			: ($col=8)
				$temp:=atACT_estadosCCentro{$row}
				$temp2:=alACT_estadosIDCCentro{$row}
				ARRAY POINTER:C280(<>aChoicePtrs;0)
				ARRAY POINTER:C280(<>aChoicePtrs;2)
				<>aChoicePtrs{1}:=->at_ACT_Centro
				<>aChoicePtrs{2}:=->al_ACT_IDCentro
				TBL_ShowChoiceList (1;__ ("Seleccione el Centro de Costos");1)
				If (ok=1)
					$index:=Find in array:C230(<>asACT_Centro;at_ACT_Centro{choiceIdx})
					If ($index#-1)
						alACT_estadosIDCCentro{$row}:=<>alACT_idCentro{$index}
						atACT_estadosCCentro{$row}:=<>asACT_Centro{$index}
					Else 
						alACT_estadosIDCCentro{$row}:=0
						atACT_estadosCCentro{$row}:=""
					End if 
					If ((atACT_estadosCCentro{$row}#$temp) | (Windows Ctrl down:C562 | Macintosh command down:C546))
						$vb_restaurar:=False:C215
						vtMsg:=__ ("Usted modificó el código de centro de costos de contra cuenta para este estado de forma de pago.")+"\r"+__ ("Si lo desea puede aplicar el nuevo código a los registros ya ingresados o bien utilizar este nuevo código sólo para los registros que se ingresen de ahora en adelante.")
						vtDesc1:=__ ("El código de centro de costos de contra cuenta es modificado, pero sólo será aplicado a los nuevos registros que se ingresen.")
						vtDesc2:=__ ("Se asigna el nuevo código a los registros ya ingresados.")
						vtBtn1:=__ ("Sólo para los nuevos registros")
						vtBtn2:=__ ("Aplicar también a los registros ya ingresados")
						WDW_OpenDialogInDrawer (->[xxACT_GlosasExtraordinarias:5];"ACT_DLG_ModGExtras")
						If (ok=1)
							$vl_ok:=Num:C11(ACTcfg_OpcionesEstadosPagos ("GuardaIDContabilidad";->alACT_estadosID{$row};->[ACT_EstadosFormasdePago:201]id_centro_costo_contra:8;->alACT_estadosIDCCentro{$row}))
							If ($vl_ok=1)
								LOG_RegisterEvt ("Cambio de centro de costo contra para estado de forma de pago "+$vt_forma+", estado "+atACT_estados{$row}+". Cambió de "+$temp+" a "+atACT_estadosCCentro{$row}+".")
								If (r2=1)
									vString1:=atACT_estadosCCentro{$row}
									
									READ WRITE:C146([ACT_Pagos:172])
									READ ONLY:C145([ACT_Documentos_de_Pago:176])
									$proc:=IT_UThermometer (1;0;__ ("Actualizando información contable en pagos..."))
									QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]id_forma_de_pago:51=alACT_estadosIDFDP{$row};*)
									QUERY:C277([ACT_Documentos_de_Pago:176]; & ;[ACT_Documentos_de_Pago:176]id_estado:53=alACT_estadosID{$row})
									KRL_RelateSelection (->[ACT_Pagos:172]ID_DocumentodePago:6;->[ACT_Documentos_de_Pago:176]ID:1;"")
									_O_ARRAY STRING:C218(80;asNCta;0)
									_O_ARRAY STRING:C218(80;asNCta;Records in selection:C76([ACT_Pagos:172]))
									AT_Populate (->asNCta;->vString1)
									ARRAY TO SELECTION:C261(asNCta;[ACT_Pagos:172]CCentro_de_costos:20)
									ACTcfg_OpcionesMovimientos ("CambioCtaContableEnConf";->alACT_estadosIDFDP{$row};->alACT_estadosID{$row};->alACT_estadosIDCCentro{$row};->[ACT_Movimientos_Estados:288]id_centro_costo_contra:16)
									AT_Initialize (->asNCta)
									KRL_UnloadReadOnly (->[ACT_Pagos:172])
									IT_UThermometer (-2;$proc)
								End if 
							Else 
								$vb_restaurar:=True:C214
							End if 
						Else 
							$vb_restaurar:=True:C214
						End if 
						If ($vb_restaurar)
							atACT_estadosCCentro{$row}:=$temp
							alACT_estadosIDCCentro{$row}:=$temp2
						End if 
						
					End if 
				End if 
		End case 
End case 
AT_Initialize (->at_ACT_CuentaCta;->at_ACT_CodAuxCta;->at_ACT_GlosaCta;->at_ACT_Centro)
  //End if 