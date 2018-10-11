//%attributes = {}
  //ACTpgs_OpcionesImportacion

C_BOOLEAN:C305($1;$importando;$0;$conDeuda;$2;$vb_esDescuento)
C_REAL:C285($diferencia;$intereses)
C_LONGINT:C283($idItem)
C_DATE:C307($vd_fechaPago;$vdACT_fechaVencimiento)
$diferencia:=0
$0:=True:C214
$importando:=$1
$conDeuda:=$2
$vd_fechaPago:=$3
If ($importando)
	C_BOOLEAN:C305($creaCargo;$vb_mismoAviso)
	C_LONGINT:C283($vl_rNDctoCargo;$recordNumberP;$recordNumberCta)
	$creaCargo:=False:C215
	$vb_mismoAviso:=False:C215
	If (vb_selectionMonth2Pay)
		If (vlACTimp_Year=0)
			$vdACT_fechaVencimiento:=DT_GetDateFromDayMonthYear (1;vi_selectedMonth;Year of:C25(Current date:C33(*)))
		Else 
			$vdACT_fechaVencimiento:=DT_GetDateFromDayMonthYear (1;vi_selectedMonth;vlACTimp_Year)
		End if 
	Else 
		If (vdACT_fechaVencimiento#!00-00-00!)
			$vdACT_fechaVencimiento:=vdACT_fechaVencimiento
		Else 
			$vdACT_fechaVencimiento:=!00-00-00!
		End if 
	End if 
	Case of 
		: ($conDeuda)
			ACTpgs_OpcionesCargosAPagar (1;vb_selectionItems2Pay;->al_idItems)  //reduce cargos
			ACTpgs_OpcionesCargosAPagar (2;vb_selectionMonth2Pay;->vi_selectedMonth)  //selecciona cargos del mes
			ACTpgs_OpcionesCargosAPagar (3;vb_selectionOrder2PayItems;->al_idItems)  //orden
			Case of 
				: (vb_importSoloCuadrado)
					$vr_saldo:=ACTpgs_retornaMontoAPagar ($vdACT_fechaVencimiento;$vd_fechaPago;0;vdACTpgs_fechaDesde)
					If ($vr_saldo#vrACT_MontoPago) | ($vr_saldo=-1)
						$0:=False:C215
						vb_descuadre:=True:C214
					End if 
				: (vb_crearCargoAutCUP)  //para cuponera
					$deudaTotal:=0
					$deudaTotal:=ACTpgs_retornaMontoAPagar (vdACT_fechaVencimiento;$vd_fechaPago)
					If (vb_selectionItems2Pay)
						If ($vdACT_fechaVencimiento#!00-00-00!)  //20110921 RCH Se calcula solo cuando viene fecha de vencimiento. Ticket 103388
							vrACT_MontoMora:=vrACT_MontoPago-$deudaTotal
						End if 
					End if 
					If ($deudaTotal#-1)
						Case of 
							: (vrACT_MontoMora>0)  //el monto mora debe vernir bien calculado desde donde sea....
								$diferencia:=vrACT_MontoMora
								If (vb_utilizarIECargoXMoneda)
									ACTcfg_LoadCargosEspeciales (6)
									$idItem:=vl_idIE
								Else 
									$idItem:=vlACT_selectedItemId
								End if 
								$creaCargo:=True:C214
							: (vrACT_MontoMora<0)
								If (vb_crearIEDctoXMoneda)  //descuento no solito
									ACTcfg_LoadCargosEspeciales (5)
									$diferencia:=$deudaTotal-vrACT_MontoPago
									If (($diferencia>vl_maximoDcto) & (vl_maximoDcto>0))
										$diferencia:=0
									Else 
										$idItem:=vl_idIE
										$creaCargo:=True:C214
										$vb_mismoAviso:=True:C214
										$vb_esDescuento:=True:C214
									End if 
								End if 
						End case 
					End if 
				: (vb_crearIEDctoXMoneda)  //descuento solito
					ACTcfg_LoadCargosEspeciales (5)
					$deudaTotal:=0
					$deudaCargos:=ACTpgs_retornaMontoAPagar (vdACT_fechaVencimiento;$vd_fechaPago)
					If ($vr_saldo#-1)
						$diferencia:=Abs:C99($deudaCargos)-vrACT_MontoPago
						If (($diferencia>vl_maximoDcto) & (vl_maximoDcto>0))
							$diferencia:=0
						End if 
						$idItem:=vl_idIE
						$creaCargo:=True:C214
						$vb_mismoAviso:=True:C214
						$vb_esDescuento:=True:C214
					End if 
				: (vb_crearCargoAut)
					$vr_saldo:=ACTpgs_retornaMontoAPagar ($vdACT_fechaVencimiento;$vd_fechaPago)
					If ($vr_saldo#-1)
						If ($vr_saldo<vrACT_MontoPago)  //para el resto cuando el pago sea mayor a la deuda
							$diferencia:=vrACT_MontoPago-$vr_saldo
							$idItem:=vlACT_selectedItemId
							$creaCargo:=True:C214
						End if 
					End if 
				: (vdACT_fechaVencimiento#!00-00-00!)
					$vr_saldo:=ACTpgs_retornaMontoAPagar (vdACT_fechaVencimiento;$vd_fechaPago)
			End case 
			If (($creaCargo) & ($diferencia>0))
				$recordNumberP:=Record number:C243([Personas:7])
				If (vdACT_fechaVencimiento=!00-00-00!)
					vdACT_fechaVencimiento:=Current date:C33(*)
				End if 
				$vl_idTercero:=0
				If (vbACTpgs_PagoXTercero)
					$vl_idTercero:=[ACT_Terceros:138]Id:1
				End if 
				If ($vb_esDescuento)  //descuento
					KRL_GotoRecord (->[ACT_Cargos:173];alACT_RecNumsCargos{1})
					$recNumCargo:=ACTpgs_CreaCargo (True:C214;[Personas:7]No:1;$diferencia;$idItem;$vb_mismoAviso;[ACT_Cargos:173]Fecha_de_Vencimiento:7;[ACT_Cargos:173]No_Incluir_en_DocTrib:50;$vl_idTercero;[ACT_Cargos:173]ID:1)
				Else 
					C_BOOLEAN:C305($NoEnBoleta)
					$NoEnBoleta:=KRL_GetBooleanFieldData (->[xxACT_Items:179]ID:1;->$idItem;->[xxACT_Items:179]No_incluir_en_DocTributario:31)
					$recNumCargo:=ACTpgs_CreaCargo (True:C214;[Personas:7]No:1;$diferencia;$idItem;$vb_mismoAviso;vdACT_fechaVencimiento;$NoEnBoleta;$vl_idTercero)
				End if 
				If ($recNumCargo#-1)
					ACTpgs_AppendCarToArray ($recNumCargo)
					$0:=True:C214
				Else 
					$0:=False:C215
				End if 
				KRL_GotoRecord (->[Personas:7];$recordNumberP)
			End if 
			
		: (Not:C34($conDeuda))  //para cuando no hay deuda
			  //$0:=False
			Case of 
				: (vb_importSoloCuadrado)
					vb_descuadre:=True:C214
					$0:=False:C215
				: (vb_crearCargoAut)
					If (vb_crearCargoAutCUP)  //para cuponera
						  //no hay deuda así que todo queda en saldo a favor
						  //$diferencia:=vrACT_MontoMora
						  //$idItem:=vlACT_selectedItemId
						  //$creaCargo:=True
					Else 
						$vr_saldo:=ACTpgs_retornaMontoAPagar ($vdACT_fechaVencimiento;$vd_fechaPago)
						If ($vr_saldo#-1)
							If ($vr_saldo<vrACT_MontoPago)  //para el resto cuando el pago sea mayor a la deuda
								  //no hay deuda así que todo queda en saldo a favor
								  //$diferencia:=vrACT_MontoPago-(AT_GetSumArray (->arACT_CSaldo)*-1)
								  //$idItem:=vlACT_selectedItemId
								  //$creaCargo:=True
							Else 
								$0:=False:C215
							End if 
						End if 
					End if 
				Else 
					If ((vb_selectionMonth2Pay) | (vb_selectionItems2Pay))
						vb_descuadre:=True:C214
						$0:=False:C215
					End if 
			End case 
	End case 
End if 