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
		$line:=AL_GetLine (xALP_FormasdePago)
		IT_SetButtonState ((alACT_FormasdePagoID{$line}>0);->bDelFP)
	: (alProEvt=2)
		$col:=AL_GetColumn (xALP_FormasdePago)
		$row:=AL_GetLine (xALP_FormasdePago)
		IT_SetButtonState ((alACT_FormasdePagoID{$row}>0);->bDelFP)
		Case of 
			: ($col=3)
				$temp:=atACT_FdPCtaContable{$row}
				$temp2:=alACT_idCtaFDP{$row}
				$temp3:=atACT_FdPCtaCodAux{$row}
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
						alACT_idCtaFDP{$row}:=<>alACT_idCta{$index}
						atACT_FdPCtaContable{$row}:=<>asACT_CuentaCta{$index}
						atACT_FdPCtaCodAux{$row}:=<>asACT_CodAuxCta{$index}
					Else 
						alACT_idCtaFDP{$row}:=0
						atACT_FdPCtaContable{$row}:=""
						atACT_FdPCtaCodAux{$row}:=""
					End if 
					If ((atACT_FdPCtaContable{$row}#$temp) | (Windows Ctrl down:C562 | Macintosh command down:C546))
						
						  //20130809 RCH Si no hay pagos asociados no aparece el mensaje.
						C_LONGINT:C283($l_records)
						SET QUERY DESTINATION:C396(Into variable:K19:4;$l_records)
						SET QUERY LIMIT:C395(1)
						QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]id_forma_de_pago:30=alACT_FormasdePagoID{$row})
						SET QUERY LIMIT:C395(0)
						SET QUERY DESTINATION:C396(Into current selection:K19:1)
						
						If ($l_records>0)
							
							vtMsg:=__ ("Usted modificó el código de plan de cuentas para esta forma de pago.")+"\r"+__ ("Si lo desea puede aplicar el nuevo código a los pagos ya ingresados o bien utilizar este nuevo código sólo para los pagos que se ingresen de ahora en adelante.")
							vtDesc1:=__ ("El código de plan de cuentas es modificado, pero sólo será aplicado a los nuevos pagos que se ingresen.")
							vtDesc2:=__ ("Se asigna el nuevo código a los pagos ya ingresados.")
							vtBtn1:=__ ("Sólo para los nuevos pagos")
							vtBtn2:=__ ("Aplicar también a los pagos ya ingresados")
							WDW_OpenDialogInDrawer (->[xxACT_GlosasExtraordinarias:5];"ACT_DLG_ModGExtras")
							If (ok=1)
								If (r2=1)
									vString1:=atACT_FdPCtaContable{$row}
									vString2:=atACT_FdPCtaCodAux{$row}
									READ WRITE:C146([ACT_Pagos:172])
									READ ONLY:C145([ACT_Documentos_de_Pago:176])
									
									  //20110831 RCH Se cambia forma de buscar documentos de cargo
									  //QUERY([ACT_Documentos_de_Pago];[ACT_Documentos_de_Pago]En_cartera=True;*)
									  //  //QUERY([ACT_Documentos_de_Pago]; & ;[ACT_Documentos_de_Pago]Estado="A Fecha@")
									  //QUERY([ACT_Documentos_de_Pago]; & ;[ACT_Documentos_de_Pago]id_estado=-4)
									QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]id_forma_de_pago:51=-4)
									QUERY SELECTION BY FORMULA:C207([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]Fecha:13<=[ACT_Documentos_de_Pago:176]FechaPago:4)
									
									KRL_RelateSelection (->[ACT_Pagos:172]ID_DocumentodePago:6;->[ACT_Documentos_de_Pago:176]ID:1;"")
									CREATE SET:C116([ACT_Pagos:172];"AFecha")
									QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]id_forma_de_pago:30=alACT_FormasdePagoID{$row})
									CREATE SET:C116([ACT_Pagos:172];"Todos")
									DIFFERENCE:C122("Todos";"AFecha";"Todos")
									USE SET:C118("Todos")
									SET_ClearSets ("Todos";"AFecha")
									$proc:=IT_UThermometer (1;0;__ ("Actualizando información contable en pagos..."))
									_O_ARRAY STRING:C218(80;asNCta;0)
									_O_ARRAY STRING:C218(80;asNCta;Records in selection:C76([ACT_Pagos:172]))
									_O_ARRAY STRING:C218(80;asCACta;0)
									_O_ARRAY STRING:C218(80;asCACta;Records in selection:C76([ACT_Pagos:172]))
									AT_Populate (->asNCta;->vString1)
									AT_Populate (->asCACta;->vString2)
									ARRAY TO SELECTION:C261(asNCta;[ACT_Pagos:172]No_Cuenta_Contable:16;asCACta;[ACT_Pagos:172]CodAuxCta:22)
									AT_Initialize (->asNCta;->asCACta)
									KRL_UnloadReadOnly (->[ACT_Pagos:172])
									IT_UThermometer (-2;$proc)
								End if 
							Else 
								atACT_FdPCtaContable{$row}:=$temp
								alACT_idCtaFDP{$row}:=$temp2
								atACT_FdPCtaCodAux{$row}:=$temp3
							End if 
							
						End if 
						
					End if 
				End if 
			: ($col=5)
				$temp:=atACT_FdPCentroCostos{$row}
				$temp2:=alACT_idCentroFDP{$row}
				ARRAY POINTER:C280(<>aChoicePtrs;0)
				ARRAY POINTER:C280(<>aChoicePtrs;2)
				<>aChoicePtrs{1}:=->at_ACT_Centro
				<>aChoicePtrs{2}:=->al_ACT_IDCentro
				TBL_ShowChoiceList (1;__ ("Seleccione el Centro de Costos");1)
				If (ok=1)
					$index:=Find in array:C230(<>asACT_Centro;at_ACT_Centro{choiceIdx})
					If ($index#-1)
						atACT_FdPCentroCostos{$row}:=<>asACT_Centro{$index}
						alACT_idCentroFDP{$row}:=<>alACT_idCentro{$index}
					Else 
						atACT_FdPCentroCostos{$row}:=""
						alACT_idCentroFDP{$row}:=0
					End if 
					vbACT_ModifiedCol:=True:C214
					If ((atACT_FdPCentroCostos{$row}#$temp) | (Windows Ctrl down:C562 | Macintosh command down:C546))
						
						  //20130809 RCH Si no hay pagos asociados no aparece el mensaje.
						C_LONGINT:C283($l_records)
						SET QUERY DESTINATION:C396(Into variable:K19:4;$l_records)
						SET QUERY LIMIT:C395(1)
						QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]id_forma_de_pago:30=alACT_FormasdePagoID{$row})
						SET QUERY LIMIT:C395(0)
						SET QUERY DESTINATION:C396(Into current selection:K19:1)
						
						If ($l_records>0)
							
							vtMsg:=__ ("Usted modificó el código de centro de costos para esta forma de pago.")+"\r"+__ ("Si lo desea puede aplicar el nuevo código a los pagos ya ingresados o bien utilizar este nuevo código sólo para los pagos que se ingresen de ahora en adelante.")
							vtDesc1:=__ ("El código de centro de costos es modificado, pero sólo será aplicado a los nuevos pagos que se ingresen.")
							vtDesc2:=__ ("Se asigna el nuevo código a los pagos ya ingresados.")
							vtBtn1:=__ ("Sólo para los nuevos pagos")
							vtBtn2:=__ ("Aplicar también a los pagos ya ingresados")
							WDW_OpenDialogInDrawer (->[xxACT_GlosasExtraordinarias:5];"ACT_DLG_ModGExtras")
							If (ok=1)
								If (r2=1)
									vString1:=atACT_FdPCentroCostos{$row}
									READ WRITE:C146([ACT_Pagos:172])
									READ ONLY:C145([ACT_Documentos_de_Pago:176])
									
									  //20110831 RCH Se cambia forma de buscar documentos de cargo
									  //QUERY([ACT_Documentos_de_Pago];[ACT_Documentos_de_Pago]En_cartera=True;*)
									  //  //QUERY([ACT_Documentos_de_Pago]; & ;[ACT_Documentos_de_Pago]Estado="A Fecha@")
									  //QUERY([ACT_Documentos_de_Pago]; & ;[ACT_Documentos_de_Pago]id_estado=-4)
									QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]id_forma_de_pago:51=-4)
									QUERY SELECTION BY FORMULA:C207([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]Fecha:13<=[ACT_Documentos_de_Pago:176]FechaPago:4)
									
									KRL_RelateSelection (->[ACT_Pagos:172]ID_DocumentodePago:6;->[ACT_Documentos_de_Pago:176]ID:1;"")
									CREATE SET:C116([ACT_Pagos:172];"AFecha")
									QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]id_forma_de_pago:30=alACT_FormasdePagoID{$row})
									CREATE SET:C116([ACT_Pagos:172];"Todos")
									DIFFERENCE:C122("Todos";"AFecha";"Todos")
									USE SET:C118("Todos")
									SET_ClearSets ("Todos";"AFecha")
									$proc:=IT_UThermometer (1;0;__ ("Actualizando información contable en pagos..."))
									_O_ARRAY STRING:C218(80;asNCta;0)
									_O_ARRAY STRING:C218(80;asNCta;Records in selection:C76([ACT_Pagos:172]))
									AT_Populate (->asNCta;->vString1)
									ARRAY TO SELECTION:C261(asNCta;[ACT_Pagos:172]Centro_de_costos:17)
									AT_Initialize (->asNCta)
									KRL_UnloadReadOnly (->[ACT_Pagos:172])
									IT_UThermometer (-2;$proc)
								End if 
							Else 
								atACT_FdPCentroCostos{$row}:=$temp
								alACT_idCentroFDP{$row}:=$temp2
							End if 
							
						End if 
						
					End if 
				End if 
			: ($col=6)
				$temp:=atACT_FdPCCtaContable{$row}
				$temp2:=alACT_idCCtaFDP{$row}
				$temp3:=atACT_FdPCCtaCodAux{$row}
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
						alACT_idCCtaFDP{$row}:=<>alACT_idCta{$index}
						atACT_FdPCCtaContable{$row}:=<>asACT_CuentaCta{$index}
						atACT_FdPCCtaCodAux{$row}:=<>asACT_CodAuxCta{$index}
					Else 
						alACT_idCCtaFDP{$row}:=0
						atACT_FdPCCtaContable{$row}:=""
						atACT_FdPCCtaCodAux{$row}:=""
					End if 
					If ((atACT_FdPCCtaContable{$row}#$temp) | (Windows Ctrl down:C562 | Macintosh command down:C546))
						
						  //20130809 RCH Si no hay pagos asociados no aparece el mensaje.
						C_LONGINT:C283($l_records)
						SET QUERY DESTINATION:C396(Into variable:K19:4;$l_records)
						SET QUERY LIMIT:C395(1)
						QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]id_forma_de_pago:30=alACT_FormasdePagoID{$row})
						SET QUERY LIMIT:C395(0)
						SET QUERY DESTINATION:C396(Into current selection:K19:1)
						
						If ($l_records>0)
							
							vtMsg:=__ ("Usted modificó el código de plan de cuentas de contra cuenta para esta forma de pago.")+"\r"+__ ("Si lo desea puede aplicar el nuevo código a los pagos ya ingresados o bien utilizar este nuevo código sólo para los pagos que se ingresen de ahora en adelante.")
							vtDesc1:=__ ("El código de plan de cuentas de contra cuenta es modificado, pero sólo será aplicado a los nuevos pagos que se ingresen.")
							vtDesc2:=__ ("Se asigna el nuevo código a los pagos ya ingresados.")
							vtBtn1:=__ ("Sólo para los nuevos pagos")
							vtBtn2:=__ ("Aplicar también a los pagos ya ingresados")
							WDW_OpenDialogInDrawer (->[xxACT_GlosasExtraordinarias:5];"ACT_DLG_ModGExtras")
							If (ok=1)
								If (r2=1)
									vString1:=atACT_FdPCCtaContable{$row}
									vString2:=atACT_FdPCCtaCodAux{$row}
									READ WRITE:C146([ACT_Pagos:172])
									READ ONLY:C145([ACT_Documentos_de_Pago:176])
									
									  //20110831 RCH Se cambia forma de buscar documentos de cargo
									  //QUERY([ACT_Documentos_de_Pago];[ACT_Documentos_de_Pago]En_cartera=True;*)
									  //  //QUERY([ACT_Documentos_de_Pago]; & ;[ACT_Documentos_de_Pago]Estado="A Fecha@")
									  //QUERY([ACT_Documentos_de_Pago]; & ;[ACT_Documentos_de_Pago]id_estado=-4)
									QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]id_forma_de_pago:51=-4)
									QUERY SELECTION BY FORMULA:C207([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]Fecha:13<=[ACT_Documentos_de_Pago:176]FechaPago:4)
									
									KRL_RelateSelection (->[ACT_Pagos:172]ID_DocumentodePago:6;->[ACT_Documentos_de_Pago:176]ID:1;"")
									CREATE SET:C116([ACT_Pagos:172];"AFecha")
									QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]id_forma_de_pago:30=alACT_FormasdePagoID{$row})
									CREATE SET:C116([ACT_Pagos:172];"Todos")
									DIFFERENCE:C122("Todos";"AFecha";"Todos")
									USE SET:C118("Todos")
									SET_ClearSets ("Todos";"AFecha")
									$proc:=IT_UThermometer (1;0;__ ("Actualizando información contable en pagos..."))
									_O_ARRAY STRING:C218(80;asNCta;0)
									_O_ARRAY STRING:C218(80;asNCta;Records in selection:C76([ACT_Pagos:172]))
									_O_ARRAY STRING:C218(80;asCACta;0)
									_O_ARRAY STRING:C218(80;asCACta;Records in selection:C76([ACT_Pagos:172]))
									AT_Populate (->asNCta;->vString1)
									AT_Populate (->asCACta;->vString2)
									ARRAY TO SELECTION:C261(asNCta;[ACT_Pagos:172]No_CCta_Contable:19;asCACta;[ACT_Pagos:172]CodAuxCCta:23)
									AT_Initialize (->asNCta;->asCACta)
									KRL_UnloadReadOnly (->[ACT_Pagos:172])
									IT_UThermometer (-2;$proc)
								End if 
							Else 
								atACT_FdPCCtaContable{$row}:=$temp
								alACT_idCCtaFDP{$row}:=$temp2
								atACT_FdPCCtaCodAux{$row}:=$temp3
							End if 
							
						End if 
						
					End if 
				End if 
			: ($col=8)
				$temp:=atACT_FdPCCentroCostos{$row}
				$temp2:=alACT_idCCentroFDP{$row}
				ARRAY POINTER:C280(<>aChoicePtrs;0)
				ARRAY POINTER:C280(<>aChoicePtrs;2)
				<>aChoicePtrs{1}:=->at_ACT_Centro
				<>aChoicePtrs{2}:=->al_ACT_IDCentro
				TBL_ShowChoiceList (1;__ ("Seleccione el Centro de Costos");1)
				If (ok=1)
					$index:=Find in array:C230(<>asACT_Centro;at_ACT_Centro{choiceIdx})
					If ($index#-1)
						alACT_idCCentroFDP{$row}:=<>alACT_idCentro{$index}
						atACT_FdPCCentroCostos{$row}:=<>asACT_Centro{$index}
					Else 
						alACT_idCCentroFDP{$row}:=0
						atACT_FdPCCentroCostos{$row}:=""
					End if 
					If ((atACT_FdPCCentroCostos{$row}#$temp) | (Windows Ctrl down:C562 | Macintosh command down:C546))
						
						  //20130809 RCH Si no hay pagos asociados no aparece el mensaje.
						C_LONGINT:C283($l_records)
						SET QUERY DESTINATION:C396(Into variable:K19:4;$l_records)
						SET QUERY LIMIT:C395(1)
						QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]id_forma_de_pago:30=alACT_FormasdePagoID{$row})
						SET QUERY LIMIT:C395(0)
						SET QUERY DESTINATION:C396(Into current selection:K19:1)
						
						If ($l_records>0)
							
							vtMsg:=__ ("Usted modificó el código de centro de costos de contra cuenta para esta forma de pago.")+"\r"+__ ("Si lo desea puede aplicar el nuevo código a los pagos ya ingresados o bien utilizar este nuevo código sólo para los pagos que se ingresen de ahora en adelante.")
							vtDesc1:=__ ("El código de centro de costos de contra cuenta es modificado, pero sólo será aplicado a los nuevos pagos que se ingresen.")
							vtDesc2:=__ ("Se asigna el nuevo código a los pagos ya ingresados.")
							vtBtn1:=__ ("Sólo para los nuevos pagos")
							vtBtn2:=__ ("Aplicar también a los pagos ya ingresados")
							WDW_OpenDialogInDrawer (->[xxACT_GlosasExtraordinarias:5];"ACT_DLG_ModGExtras")
							If (ok=1)
								If (r2=1)
									vString1:=atACT_FdPCCentroCostos{$row}
									READ WRITE:C146([ACT_Pagos:172])
									READ ONLY:C145([ACT_Documentos_de_Pago:176])
									
									  //20110831 RCH Se cambia forma de buscar documentos de cargo
									  //QUERY([ACT_Documentos_de_Pago];[ACT_Documentos_de_Pago]En_cartera=True;*)
									  //  //QUERY([ACT_Documentos_de_Pago]; & ;[ACT_Documentos_de_Pago]Estado="A Fecha@")
									  //QUERY([ACT_Documentos_de_Pago]; & ;[ACT_Documentos_de_Pago]id_estado=-4)
									QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]id_forma_de_pago:51=-4)
									QUERY SELECTION BY FORMULA:C207([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]Fecha:13<=[ACT_Documentos_de_Pago:176]FechaPago:4)
									
									KRL_RelateSelection (->[ACT_Pagos:172]ID_DocumentodePago:6;->[ACT_Documentos_de_Pago:176]ID:1;"")
									CREATE SET:C116([ACT_Pagos:172];"AFecha")
									QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]id_forma_de_pago:30=alACT_FormasdePagoID{$row})
									CREATE SET:C116([ACT_Pagos:172];"Todos")
									DIFFERENCE:C122("Todos";"AFecha";"Todos")
									USE SET:C118("Todos")
									SET_ClearSets ("Todos";"AFecha")
									$proc:=IT_UThermometer (1;0;__ ("Actualizando información contable en pagos..."))
									_O_ARRAY STRING:C218(80;asNCta;0)
									_O_ARRAY STRING:C218(80;asNCta;Records in selection:C76([ACT_Pagos:172]))
									AT_Populate (->asNCta;->vString1)
									ARRAY TO SELECTION:C261(asNCta;[ACT_Pagos:172]CCentro_de_costos:20)
									AT_Initialize (->asNCta)
									KRL_UnloadReadOnly (->[ACT_Pagos:172])
									IT_UThermometer (-2;$proc)
								End if 
							Else 
								atACT_FdPCCentroCostos{$row}:=$temp
								alACT_idCCentroFDP{$row}:=$temp2
							End if 
							
						End if 
						
					End if 
				End if 
		End case 
		AL_UpdateArrays (xALP_FormasdePago;-2)
		
	: (alProEvt=5)
		$col:=AL_GetColumn (xALP_FormasdePago)
		$row:=AL_GetLine (xALP_FormasdePago)
		IT_SetButtonState ((alACT_FormasdePagoID{$row}>0);->bDelFP)
		Case of 
			: ($col=1)
				ARRAY INTEGER:C220($aInt2D;2;0)
				If (alACT_FormasdePagoID{$row}>0)
					$text:=__ ("Editar")
				Else 
					$text:="("+__ ("Editar")
				End if 
				$text:=$text+";(-;"+__ ("Configurar estados")
				$text:=$text+";(-;"+__ ("Configurar recargos")
				$text:=$text+";(-;"+__ ("Ingresar % de cobro")  //20150325 ASM Ticket 141119 
				$choice:=Pop up menu:C542($text)
				Case of 
					: ($choice=1)
						AL_GotoCell (xALP_FormasdePago;$col;$row)
						
					: ($choice=3)
						vlACT_idFormaDePago:=alACT_FormasdePagoID{$row}
						WDW_OpenFormWindow (->[ACT_EstadosFormasdePago:201];"EstadosFormasDePago";-1;4;__ ("Configuración de estados para ")+ACTcfgfdp_OpcionesGenerales ("GetFormaDePagoFromID";->vlACT_idFormaDePago))
						DIALOG:C40([ACT_EstadosFormasdePago:201];"EstadosFormasDePago")
						CLOSE WINDOW:C154
					: ($choice=5)  //20120709 ASM. Nueva funcionalidad Recargos forma de pagos.
						vlACT_idFormaDePago:=alACT_FormasdePagoID{$row}
						WDW_OpenFormWindow (->[ACT_Formas_de_Pago:287];"RecargoFormaDePago";-1;4;__ ("Configuración de % de recargo de  ")+ACTcfgfdp_OpcionesGenerales ("GetFormaDePagoFromID";->vlACT_idFormaDePago))
						DIALOG:C40([ACT_Formas_de_Pago:287];"RecargoFormaDePago")
						CLOSE WINDOW:C154
						
					: ($choice=7)  //20150325 ASM Ticket 141119 
						vlACT_idFormaDePago:=alACT_FormasdePagoID{$row}
						WDW_OpenFormWindow (->[ACT_Formas_de_Pago:287];"PorcentajeFormaDePago";-1;4;__ (" % de Cobro de  ")+ACTcfgfdp_OpcionesGenerales ("GetFormaDePagoFromID";->vlACT_idFormaDePago))
						DIALOG:C40([ACT_Formas_de_Pago:287];"PorcentajeFormaDePago")
						CLOSE WINDOW:C154
						
				End case 
		End case 
		
	: (alProEvt=6)
		$col:=AL_GetColumn (xALP_FormasdePago)
		$row:=AL_GetLine (xALP_FormasdePago)
		IT_SetButtonState (False:C215;->bDelFP)
		Case of 
			: ($col=1)
				$text:="("+__ ("Editar")
				$text:=$text+";(-;("+__ ("Configurar estados")
				$choice:=Pop up menu:C542($text)
		End case 
End case 
AT_Initialize (->at_ACT_CuentaCta;->at_ACT_CodAuxCta;->at_ACT_GlosaCta;->at_ACT_Centro)